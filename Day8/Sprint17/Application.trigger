trigger ApplicationTrigger on Application__c (
    before insert,
    before update
) {

    if (Trigger.isBefore && Trigger.isInsert) {
        ApplicationTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        ApplicationTriggerHandler.beforeUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }

}
