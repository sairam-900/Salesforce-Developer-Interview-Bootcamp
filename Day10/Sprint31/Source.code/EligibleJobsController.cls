public with sharing class EligibleJobsController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs() {

        return [
            SELECT Id, Name
            FROM Job__c
            LIMIT 20
        ];

    }
}