public class ExternalPlacementSyncJob implements Queueable {

    private Id applicationId;

    public ExternalPlacementSyncJob(Id applicationId){
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext qc){

        Application__c app = [
            SELECT Id, Name, Status__c
            FROM Application__c
            WHERE Id=:applicationId
        ];

        System.debug('External Synchronization');

        // Chain next Queueable
        System.enqueueJob(new PlacementNotificationJob(applicationId));
    }
}
