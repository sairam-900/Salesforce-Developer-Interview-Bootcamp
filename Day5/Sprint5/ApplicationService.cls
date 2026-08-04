public with sharing class ApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {

        // Get Student
        Student__c student = [
            SELECT CGPA__c, Backlogs__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        // Get Job
        Job__c job = [
            SELECT Minimum_CGPA__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        // Eligibility Validation
        if(student.CGPA__c < job.Minimum_CGPA__c){
            return 'Application Rejected: CGPA is below the required minimum.';
        }

        if(student.Backlogs__c > 0){
            return 'Application Rejected: Student has active backlogs.';
        }

        // Save Application
        Application__c app = new Application__c();

        app.Student__c = studentId;
        app.Application_Date__c = Date.today();
        app.Status__c = 'Applied';   // Use a valid picklist value

        try{

            insert app;

            return 'Application submitted successfully.';

        }catch(DmlException e){

            return 'Application could not be saved. Error: ' +
                   e.getDmlMessage(0);

        }

    }

}

// execute anonymous 

Id studentId = 'a04WU00000DWvRtYAL';
Id jobId = 'a06WU00000R7V5xYAF';

String result = ApplicationService.submitApplication(studentId, jobId);
System.debug(result);
