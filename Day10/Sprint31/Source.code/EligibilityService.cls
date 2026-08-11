public with sharing class EligibilityService {

    public static List<Job__c> getEligibleJobs(Decimal studentCGPA) {

        return [
            SELECT Id,
                   Name,
                   Job_id__c,
                   Job_Status__c,
                   Last_Date__c,
                   Minimum_CGPA__c,
                   Package__c,
                   Role__c,
                   Company__c,
                   Company__r.Name
            FROM Job__c
        ];
    }
}