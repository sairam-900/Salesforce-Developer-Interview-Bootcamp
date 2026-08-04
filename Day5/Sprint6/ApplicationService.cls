public with sharing class ApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {

        // Step 1: Duplicate Validation
        String duplicateResult = checkDuplicate(studentId, jobId);
        if (duplicateResult != null) {
            return duplicateResult;
        }

        // Step 2: Eligibility Validation
        String eligibilityResult = checkEligibility(studentId, jobId);
        if (eligibilityResult != null) {
            return eligibilityResult;
        }

        // Step 3: Save Application
        return saveApplication(studentId, jobId);
    }

    // Duplicate Validation
    private static String checkDuplicate(Id studentId, Id jobId) {

        // Replace with Student__c AND Job__c once Job__c lookup exists
        List<Application__c> applications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
        ];

        if (!applications.isEmpty()) {
            return 'Application already exists.';
        }

        return null;
    }

    // Eligibility Validation
    private static String checkEligibility(Id studentId, Id jobId) {

        Student__c student = [
            SELECT CGPA__c,
                   Backlogs__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        Job__c job = [
            SELECT Minimum_CGPA__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        if (student.CGPA__c < job.Minimum_CGPA__c) {
            return 'Rejected: Minimum CGPA requirement not met.';
        }

        if (student.Backlogs__c > 0) {
            return 'Rejected: Student has active backlogs.';
        }

        return null;
    }

    // Save Application
    private static String saveApplication(Id studentId, Id jobId) {

        Application__c app = new Application__c();

        app.Student__c = studentId;
        app.Application_Date__c = Date.today();

        // Replace with a valid picklist value from your org
        app.Status__c = 'Applied';

        try {

            insert app;
            return 'Application submitted successfully.';

        } catch (DmlException e) {

            return 'Unable to save application: ' + e.getDmlMessage(0);

        }
    }
}

// execute anonymous 

Id studentId = 'a04WU00000DWvRtYAL';
Id jobId = 'a06WU00000R7V5xYAF';

String result = ApplicationService.submitApplication(studentId, jobId);
System.debug(result);
