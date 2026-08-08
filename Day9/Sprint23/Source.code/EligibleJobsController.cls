public with sharing class EligibleJobsController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs(Decimal studentCGPA) {

        return EligibilityService.getEligibleJobs(studentCGPA);
    }
}
