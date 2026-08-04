public with sharing class ApplicationService {

    public static String updateApplicationStatus(Id applicationId, String status){

        try{

            Application__c app = [
                SELECT Id, Status__c
                FROM Application__c
                WHERE Id = :applicationId
                LIMIT 1
            ];

            app.Status__c = status;

            update app;

            return 'Success: Application status updated to ' + status;

        }catch(DmlException e){

            return 'Failed: ' + e.getDmlMessage(0);

        }

    }

}


// Execute Anonymous

Id applicationId = 'YOUR_APPLICATION_ID';

System.debug(
    ApplicationService.updateApplicationStatus(
        applicationId,
        'Selected'
    )
);
