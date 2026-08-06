trigger ApplicationTrigger on Application__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {

        StudentPlacementService.processSelectedApplications(
            Trigger.new,
            Trigger.oldMap
        );

    }

}
