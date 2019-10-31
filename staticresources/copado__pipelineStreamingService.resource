var ccdStream = ccdStream || {};

((pipelineStreamingService) => {
    var pipelineStreamingService = pipelineStreamingService || {};

    pipelineStreamingService.ns = '';
    pipelineStreamingService.sobjectAccessError = '';
    pipelineStreamingService.pushTopicName = 'CopadoEnvironments';
    pipelineStreamingService.streamCallback = {};
    var hasPushTopic = false;
    var alreadyInitialized = false;

    var _errorOnAccessingSobject = (e, sobjectType) => {
        console.error(e, e.faultstring);
        var msg = pipelineStreamingService.sobjectAccessError + (e.faultstring || e);
        msg = msg.replace('{SOBJECT}', sobjectType);
        return alert(msg);
    };

    var _getPushTopics = () => {
        var me = pipelineStreamingService;
        try {
            var result = sforce.connection.query('SELECT Id, Name, Query, ApiVersion, IsActive, NotifyForFields, NotifyForOperations, '
                                               + 'Description, NotifyForOperationCreate, NotifyForOperationUpdate, NotifyForOperationDelete, '
                                               + 'NotifyForOperationUndelete FROM PushTopic WHERE Name = \'' + me.pushTopicName + '\'');
        } catch(e) {
            return _errorOnAccessingSobject(e,'PushTopic');
        }
        var records = result.getArray('records');
        if(records.length > 0) {
            for(var i = 0; i < records.length; i++) {
                if(records[i].Name == me.pushTopicName) {
                    console.info('Push topic for ' + me.pushTopicName + ' already exists.');
                    me.hasPushTopic = true;
                }
            }
        }
    };

     var _createPushTopic = (name, query) => {
         var me = pipelineStreamingService;
         var pt = new sforce.SObject('PushTopic');
         pt.Name = name;
         pt.Query = query;
         pt.ApiVersion = 46.0;
         pt.NotifyForOperationCreate = true;
         pt.NotifyForOperationUpdate = true;
         pt.NotifyForOperationDelete = false;
         pt.NotifyForOperationUndelete = false;
         pt.NotifyForFields = 'All';

         try {
             var result = sforce.connection.create([pt]);
         } catch(e) {
             return _errorOnAccessingSobject(e, 'PushTopic');
         }
         if(result[0].getBoolean('success')) {
             console.info(me.pushTopicName + ' PushTopic not found and a new one is created');
         } else {
             console.error('Problem creating ' + me.pushTopicName + ' PushTopic: ', result[0]);
             return _errorOnAccessingSobject(result[0], 'PushTopic');
         }
     };

     pipelineStreamingService.initStreaming = () => {
         var query = 'SELECT Id, Name FROM PushTopic limit 10';
         var result = sforce.connection.query(query, {
             onSuccess: function(res) {
                 _init();
                 $copado.cometd.subscribe('/topic/' + pipelineStreamingService.pushTopicName, function(message) {
                     console.info('Push message: ', message);
                     console.info('message.data ', message.data);
                     _readStream(message);
                 });
             },
             onFailure: function(res) {
                 console.log('This feature is not enabled for the current user');
             }
         });
     };

     var _init = () => {
        var me = pipelineStreamingService;
        if(me.alreadyInitialized) {
            return;
        }
        me.alreadyInitialized = true;
        try {
            var query = 'Select Id, Name, ' + me.ns + 'Latest_Deployment__c, ' + me.ns + 'Latest_Deployment_Status__c FROM ' + me.ns + 'Environment__c';
            _getPushTopics();
            if(!me.hasPushTopic) {
                _createPushTopic(me.pushTopicName, query);
            }
        } catch(e) {
            console.error(e);
            return _errorOnAccessingSobject(e, me.ns + 'Environment__c');
        }
        me.c = $copado.cometd.init({
            url: window.location.protocol + '//' + window.location.hostname + '/cometd/37.0/',
            requestHeaders: { Authorization: 'OAuth ' + __sfdcSessionId }
        });
     };

     pipelineStreamingService.disconnect = () => {
          $copado.cometd.disconnect();
     };

     var _readStream = (message) => {
         var me = pipelineStreamingService;
         console.log('read stream', message);
         var statusMap = pipelineStreamingService.statusMap;
         if(message.channel == '/topic/' + pipelineStreamingService.pushTopicName) {
             var newStatus = message.data.sobject[me.ns + 'Latest_Deployment_Status__c'];

             var idString = '#deploymentStatus_' + message.data.sobject.Id;
             var environmentStatus = $copado(idString);
             var elementType = environmentStatus.prop('nodeName');
             if(elementType === 'DIV' && newStatus !== 'In progress') {
                 _replaceSpinner(idString);
             } else if (elementType === 'IMG' && newStatus === 'In progress') {
                 _replaceImg(idString);
                 return;
             }
             var statusElem = $copado(idString);
             if(statusElem && statusMap !== undefined && statusMap !== null && (newStatus in statusMap)) {
                 $copado(statusElem).attr('src', statusMap[newStatus]);
             }
         }
     };
     var _replaceSpinner = (elemId) => {
        var container = $copado(elemId).parent();
        $copado(elemId).remove();
        container.append('<img id="'+elemId.replace('#','')+'" src="" />')
     };

     var _replaceImg = (elemId) => {
         var container = $copado(elemId).parent();
         $copado(elemId).remove();
         var spinner = '<div id="'+elemId.replace('#','')+'" class="spinner">'+                                                                              '<div role="status" class="slds-spinner slds-spinner_xx-small slds-spinner_brand">'+                                                  '<span class="slds-assistive-text">Loading</span>'+
                    '<div class="slds-spinner__dot-a"></div>'+
                    '<div class="slds-spinner__dot-b"></div>'+
                    '</div>'+
                    '</div>'
          container.append(spinner);
      }
})(ccdStream);