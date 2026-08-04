public with sharing class ApplicationService {

    public static Student__c getStudent(Id studentId) {

        return [
            SELECT CGPA__c,
                   Backlogs__c,
                   Branch__c,
                   Graduation_Year__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];
    }

    public static Job__c getJob(Id jobId) {

        return [
            SELECT Minimum_CGPA__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];
    }

    public static String checkDuplicate(Id studentId) {

        List<Application__c> applications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
            LIMIT 1
        ];

        if (!applications.isEmpty()) {
            return 'Duplicate application found.';
        }

        return 'No duplicate application found.';
    }

}

// Execute Anonymous

Id studentId = 'a04WU00000DWEbRYAX';

String result = ApplicationService.checkDuplicate(studentId);

System.debug(result);
