trigger ApplicationTrigger on Application__c (before insert, after update) {

    if (Trigger.isBefore && Trigger.isInsert) {

        ApplicationService.validateApplications(Trigger.new);

    }
