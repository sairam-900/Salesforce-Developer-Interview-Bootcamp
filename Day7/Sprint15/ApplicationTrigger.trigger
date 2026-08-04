trigger ApplicationTrigger on Application__c
(before insert, after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {

        NotificationService.sendNotifications(
            Trigger.new,
            Trigger.oldMap
        );

    }

}
