public with sharing class JobController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs(
        Decimal studentCGPA
    ) {

        if (studentCGPA == null) {
            return new List<Job__c>();
        }

        return [
            SELECT
                Id,
                Name,
                Job_id__c,
                Job_Status__c,
                Last_Date__c,
                Minimum_CGPA__c,
                Package__c,
                Role__c,
                Company__c
            FROM Job__c
            WHERE Minimum_CGPA__c <= :studentCGPA
            ORDER BY CreatedDate DESC
            LIMIT 200
        ];
    }
}