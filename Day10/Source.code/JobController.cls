public with sharing class JobController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getJobs() {

        return [
            SELECT Id,
                   Name,
                   Company__c,
                   Role__c,
                   Package__c
            FROM Job__c
            ORDER BY CreatedDate DESC
            LIMIT 200
        ];
    }
}