public with sharing class ApplicationService {

    public static Id submitApplication(Id jobId) {

        // 1. Get current user
        User currentUser = [
            SELECT Id
            FROM User
            WHERE Id = :UserInfo.getUserId()
            LIMIT 1
        ];

        // 2. Get Job
        Job__c job = [
            SELECT Id,
                   Name,
                   Job_id__c,
                   Job_Status__c,
                   Last_Date__c,
                   Minimum_CGPA__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        // 3. Check whether application already exists
        List<Application__c> existingApplications = [
            SELECT Id
            FROM Application__c
            WHERE Job__c = :jobId
            LIMIT 1
        ];

        if (!existingApplications.isEmpty()) {
            throw new AuraHandledException(
                'You have already applied for this opportunity.'
            );
        }

        // 4. Create Application
        Application__c application = new Application__c();

        application.Job__c = job.Id;

        insert application;

        // 5. Return Application Id
        return application.Id;
    }
}