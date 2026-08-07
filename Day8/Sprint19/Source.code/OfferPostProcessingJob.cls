public class OfferPostProcessingJob implements Queueable {

    private Id offerId;

    public OfferPostProcessingJob(Id offerId){
        this.offerId = offerId;
    }

    public void execute(QueueableContext qc){

        Offer__c offer = [
            SELECT Id, Name, Status__c, Student__c
            FROM Offer__c
            WHERE Id = :offerId
        ];

        System.debug('===== Background Processing Started =====');

        // External Sync
        System.debug('Syncing Offer to External System');

        // Analytics
        System.debug('Generating Analytics');

        // Notification
        System.debug('Preparing Notification');

        System.debug('===== Background Processing Completed =====');
    }
}
