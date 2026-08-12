trigger ApplicationIntegrationTrigger
on Application__c (after update) {

    Set<Id> applicationIds =
        new Set<Id>();

    for (Application__c app : Trigger.new) {

        Application__c oldApp =
            Trigger.oldMap.get(app.Id);

        if (
            app.Status__c == 'Selected' &&
            oldApp.Status__c != 'Selected'
        ) {

            applicationIds.add(app.Id);
        }
    }

    if (!applicationIds.isEmpty()) {

        for (Id applicationId : applicationIds) {

            System.enqueueJob(
                new CandidateSyncQueueable(
                    applicationId
                )
            );
        }
    }
}
