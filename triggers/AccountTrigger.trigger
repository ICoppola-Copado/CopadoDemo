trigger AccountTrigger on Account (before insert) {    
    AccountTriggerHelper.createDescription(trigger.new);
}