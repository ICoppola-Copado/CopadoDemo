var cronBuilder = cronBuilder || {};

((builder) => {
    const EVERY = 'every';

    var builder = builder || {};
    var hourlySettings = hourlySettings || {};
    var dailySettings = dailySettings || {};
    var weeklySettings = weeklySettings || {};
    var selectedTab = 'hourlySettings';

    ((thisCron) => {
        thisCron.EVERY_X_HOURS = 0;
        thisCron.START_HOUR = 0;
        thisCron.START_MINUTE = 0;
        thisCron.RADIOGROUP = EVERY;

        thisCron.generateCronExpression = () => {
            var cronExpression = '';
            _getValues();
            if(thisCron.RADIOGROUP == EVERY) {
                cronExpression = '0 0 0/' + thisCron.EVERY_X_HOURS + ' 1/1 * ? *';
            } else if(thisCron.RADIOGROUP == 'starts') {
                cronExpression = '0 ' + thisCron.START_MINUTE + ' ' + thisCron.START_HOUR + ' 1/1 * ? *';
            }
            return cronExpression;
        };

        var _getValues = () => {
            thisCron.EVERY_X_HOURS = document.getElementById('every_x_hours_hourOptions').value;
            thisCron.START_HOUR = document.getElementById('hourly_starts_at_hourOptions').value;
            thisCron.START_MINUTE = document.getElementById('hourly_starts_at_minuteOptions').value;
        };
    })(hourlySettings);

    ((thisCron) => {
        thisCron.EVERY_X_DAYS = 0;
        thisCron.START_HOUR = 0;
        thisCron.START_MINUTE = 0;
        thisCron.RADIOGROUP = EVERY;

        thisCron.generateCronExpression = () => {
            var cronExpression = '';
            _getValues();
            if(thisCron.RADIOGROUP == EVERY) {
                cronExpression = '0 ' + thisCron.START_MINUTE + ' ' + thisCron.START_HOUR + ' 1/' + thisCron.EVERY_X_DAYS + ' * ? *';
            } else if(thisCron.RADIOGROUP == 'weekdays') {
                cronExpression = '0 ' + thisCron.START_MINUTE + ' ' + thisCron.START_HOUR + ' ? * MON-FRI *';
            }
            return cronExpression;
        };

        var _getValues = () => {
            thisCron.EVERY_X_DAYS = document.getElementById('every_x_daysInput').value;
            thisCron.START_HOUR = document.getElementById('daily_starts_at_hourOptions').value;
            thisCron.START_MINUTE = document.getElementById('daily_starts_at_minuteOptions').value;
        };
    })(dailySettings);

    ((thisCron) => {
        thisCron.START_HOUR = 0;
        thisCron.START_MINUTE = 0;
        thisCron.DAYS_OF_WEEK = '';

        thisCron.generateCronExpression = () => {
            var cronExpression = '';
            _getValues();
            cronExpression = '0 ' + thisCron.START_MINUTE + ' ' + thisCron.START_HOUR + ' ? * ' + thisCron.DAYS_OF_WEEK + ' *';
            return cronExpression;
        };

        var _getValues = () => {
            thisCron.START_HOUR = document.getElementById('weekly_starts_at_hourOptions').value;
            thisCron.START_MINUTE = document.getElementById('weekly_starts_at_minuteOptions').value;
            thisCron.DAYS_OF_WEEK = _getDaysOfWeek();
        };

        var _getDaysOfWeek = () => {
            var dayCheckboxes = [];
            $copado(".dayCheckbox:checked").each(function() {
                dayCheckboxes.push($copado(this).val());
            });
            return dayCheckboxes.join(',');;
        };
    })(weeklySettings);

    var _isNotNull = (thisElement) => {
        return thisElement != null && thisElement != undefined;
    }

    var _getSelectedSetting = () => {
        if(selectedTab == 'hourlySettings') {
            return hourlySettings;
        } else if(selectedTab == 'dailySettings') {
            return dailySettings;
        } else if(selectedTab == 'weeklySettings') {
            return weeklySettings;
        }
        return null;
    };

    builder.setSelectedTab = (thisTab) => {
        selectedTab = thisTab;
        _switchTab();
    };

    var _switchTab = (thisTab) => {
        var settingContainers = document.getElementsByClassName('settingsContainer');
        if(_isNotNull(settingContainers)) {
            for(var i = 0; i < settingContainers.length; i++) {
                var thisContainer = settingContainers[i];
                if(thisContainer.id == selectedTab) {
                    thisContainer.style.display = 'block';
                } else {
                    thisContainer.style.display = 'none';
                }
            }
        }
    }

    builder.setFrequency = (frequency, name) => {
        if(frequency == 'hourly') {
            hourlySettings.RADIOGROUP = name;
        } else if(frequency == 'daily') {
            dailySettings.RADIOGROUP = name;
        }
    };

    var _generateCronExpression = () => {
        var setting = _getSelectedSetting();
    	var cronExpression = '';
    	if(setting == null) {
    	    return cronExpression;
        }
        cronExpression = setting.generateCronExpression();
    	$copado('input[id$="cronExpressionInput"]').val(cronExpression);
    };

    builder.setCronExpressionAndSave = () => {
        var cronExpression = document.querySelector('.cronExpression');
        if(_isNotNull(cronExpression)) {
            setCronExpressionValue(cronExpression.value);
        }
    };

    var _setControllerRadio = (thisInput) => {
        var radioId = $copado(thisInput).data('controller-element');
        var cronRadio = document.getElementById(radioId);
        if(_isNotNull(cronRadio)) {
            cronRadio.click();
        }
    };

    $copado(document).ready(() => {
        $copado('input[type="radio"].cronRadio,input[type="number"].cronInput,input[type="checkbox"].dayCheckbox').on('click', function() {
            if(this.type != 'radio') {
                _setControllerRadio(this);
            }
            _generateCronExpression();
        });
        $copado('select.cronInput').on('change', function() {
            _setControllerRadio(this);
            _generateCronExpression();
        });
    });
})(cronBuilder);