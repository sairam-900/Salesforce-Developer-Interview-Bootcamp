public with sharing class ApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {

        // Check duplicate application
        List<Application__c> existingApplication = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
            LIMIT 1
        ];

        if (!existingApplication.isEmpty()) {
            return 'Rejected: Student has already applied for this job.';
        }

        // Create new Application
        Application__c app = new Application__c();

        app.Student__c = studentId;
        app.Job__c = jobId;
        app.Application_Date__c = Date.today();
        app.Status__c = 'Submitted';

        insert app;

        return 'Application submitted successfully.';
    }

}

// execute anonymous 

Id studentId = 'a04WU00000DWvRtYAL';
Id jobId = 'a06WU00000R7V5xYAF';

String result = ApplicationService.submitApplication(studentId, jobId);
System.debug(result);
