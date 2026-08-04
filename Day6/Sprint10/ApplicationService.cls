public with sharing class ApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {

        // Retrieve Student
        Student__c student = [
            SELECT CGPA__c,
                   Backlogs__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        // Retrieve Job
        Job__c job = [
            SELECT Minimum_CGPA__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        // Eligibility Validation
        if(student.CGPA__c < job.Minimum_CGPA__c){
            return 'Rejected: Minimum CGPA requirement not met.';
        }

        if(student.Backlogs__c > 0){
            return 'Rejected: Student has active backlogs.';
        }

        // Create Application
        Application__c app = new Application__c();

        app.Student__c = studentId;
        app.Application_Date__c = Date.today();
        app.Status__c = 'Applied'; // Use a valid picklist value

        try{

            insert app;

            return 'Submitted: Application saved successfully.';

        }catch(DmlException e){

            return 'Failed: ' + e.getDmlMessage(0);

        }

    }

// Execute Anonymous

Id studentId = 'a04WU00000DWEbRYAX';
Id jobId = 'a06WU00000R7V5xYAF';

System.debug(
    ApplicationService.submitApplication(studentId, jobId)
);

}
