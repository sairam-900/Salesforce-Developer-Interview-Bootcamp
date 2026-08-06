public with sharing class ApplicationService {

    public static void submitApplication(
        List<Application__c> applications
    ) {

        Set<Id> studentIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();

        for(Application__c app : applications){

            if(app.Student__c != null){
                studentIds.add(app.Student__c);
            }

            if(app.Job__c != null){
                jobIds.add(app.Job__c);
            }
        }

        Map<Id, Student__c> studentMap = new Map<Id, Student__c>([
            SELECT Id,
                   CGPA__c,
                   Backlogs__c,
                   Branch__c
            FROM Student__c
            WHERE Id IN :studentIds
        ]);

        Map<Id, Job__c> jobMap = new Map<Id, Job__c>([
            SELECT Id,
                   Minimum_CGPA__c
            FROM Job__c
            WHERE Id IN :jobIds
        ]);

        for(Application__c app : applications){

            Student__c student = studentMap.get(app.Student__c);
            Job__c job = jobMap.get(app.Job__c);

            if(student == null || job == null){
                app.addError('Student or Job not found.');
                continue;
            }

            if(student.CGPA__c < job.Minimum_CGPA__c){
                app.addError('Student is not eligible because CGPA is below the minimum.');
            }

            // Add additional validations here if your Job object
            // contains Allowed_Backlogs__c or Eligible_Branch__c.
        }

    }

}
