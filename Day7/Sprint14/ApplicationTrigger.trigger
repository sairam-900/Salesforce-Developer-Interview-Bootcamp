trigger ApplicationTrigger on Application__c (before insert, after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {

        StatisticsService.updateStatistics(
            Trigger.new,
            Trigger.oldMap
        );

    }
