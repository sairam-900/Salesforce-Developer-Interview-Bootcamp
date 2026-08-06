public with sharing class StudentPlacementService {

    public static void processSelectedApplications(

        List<Application__c> newApplications,
        Map<Id, Application__c> oldApplications

    ){

        Set<Id> studentIds = new Set<Id>();
        Map<Id, Id> studentCompanyMap = new Map<Id, Id>();

        // Find newly selected applications
        for(Application__c app : newApplications){

            Application__c oldApp = oldApplications.get(app.Id);

            if(app.Status__c == 'Selected'
               && oldApp.Status__c != 'Selected'){

                if(app.Student__c != null){

                    studentIds.add(app.Student__c);

                    if(app.Company__c != null){
                        studentCompanyMap.put(
                            app.Student__c,
                            app.Company__c
                        );
                    }

                }

            }

        }

        if(studentIds.isEmpty()){
            return;
        }

        // Query Students once
        List<Student__c> studentsToUpdate = [

            SELECT Id,
                   Placement_Status__c,
                   Company__c
            FROM Student__c
            WHERE Id IN :studentIds

        ];

        // Update Student records
        for(Student__c stu : studentsToUpdate){

            stu.Placement_Status__c = 'Placed';

            if(studentCompanyMap.containsKey(stu.Id)){
                stu.Company__c = studentCompanyMap.get(stu.Id);
            }

        }

        // One DML
        if(!studentsToUpdate.isEmpty()){

            update studentsToUpdate;

        }

        System.debug('Placement Status Updated Successfully');
        System.debug('Students prepared for notification processing');

    }

}
