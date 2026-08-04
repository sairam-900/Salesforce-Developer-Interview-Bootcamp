trigger ApplicationTrigger on Application__c
(before insert, after update) {

    // Sprint 16
    if (Trigger.isAfter && Trigger.isUpdate) {

        AlumniService.sendToAlumniOffice(
            Trigger.new,
            Trigger.oldMap
        );

    }

}
