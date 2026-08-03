public with sharing class ApplicationService {

    public static Student__c getStudent(Id studentId) {

        Student__c student = [
            SELECT CGPA__c,
                   Backlogs__c,
                   Branch__c,
                   Graduation_Year__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        return student;
    }

}

// Execute Anonymous

Id studentId = 'a04WU00000DWwSnYAL';
Id jobId = 'a06WU00000R7V5xYAF';

System.debug(
    ApplicationService.submitApplication(studentId, jobId)
);
