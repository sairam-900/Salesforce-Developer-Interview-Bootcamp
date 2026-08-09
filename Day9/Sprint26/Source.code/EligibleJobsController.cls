public with sharing class EligibleJobsController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs() {

        return [
            SELECT Id,
                   Name,
                   Company__c,
                   Company__r.Name,
                   Job_Role__c,
                   Package__c,
                   Location__c,
                   Deadline__c
            FROM Job__c
            WHERE Is_Active__c = true
            ORDER BY Deadline__c ASC
        ];
    }
}