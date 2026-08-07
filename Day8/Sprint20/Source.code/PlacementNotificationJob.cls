public class PlacementNotificationJob implements Queueable{

    private Id applicationId;

    public PlacementNotificationJob(Id applicationId){
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext qc){

        Application__c app = [
            SELECT Id, Name
            FROM Application__c
            WHERE Id=:applicationId
        ];

        System.debug('Notification Prepared');
    }
}
