public with sharing class NotificationService {

    public static void sendNotifications(

        List<Application__c> newApplications,
        Map<Id, Application__c> oldApplications

    ){

        for(Application__c app : newApplications){

            Application__c oldApp = oldApplications.get(app.Id);

            // Interview Scheduled

            if(app.Status__c == 'Interview Scheduled' &&
               oldApp.Status__c != 'Interview Scheduled'){

                System.debug('Notification : Interview Scheduled');

            }

            // Selected

            if(app.Status__c == 'Selected' &&
               oldApp.Status__c != 'Selected'){

                System.debug('Notification : Congratulations! You are Selected.');

            }

            // Rejected

            if(app.Status__c == 'Rejected' &&
               oldApp.Status__c != 'Rejected'){

                System.debug('Notification : Application Rejected.');

            }

            // Received Offer Letter

            if(app.Status__c == 'Received offer letter' &&
               oldApp.Status__c != 'Received offer letter'){

                System.debug('Notification : Offer Letter Received.');

            }

            // Offer Accepted

            if(app.Status__c == 'Offer Accepted' &&
               oldApp.Status__c != 'Offer Accepted'){

                System.debug('Notification : Offer Accepted Successfully.');

            }

        }

    }

}
