public with sharing class ApplicationController {

    @AuraEnabled
    public static Id submitApplication(Id jobId) {

        if (jobId == null) {
            throw new AuraHandledException('Job ID is required.');
        }

        return ApplicationService.submitApplication(jobId);
    }
}