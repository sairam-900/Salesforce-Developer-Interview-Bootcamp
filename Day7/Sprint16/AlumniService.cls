public with sharing class AlumniService {

    public static void sendToAlumniOffice(

        List<Application__c> newApplications,
        Map<Id, Application__c> oldApplications

    ) {

        for (Application__c app : newApplications) {

            Application__c oldApp = oldApplications.get(app.Id);

            if (app.Status__c == 'Offer Accepted' &&
                oldApp.Status__c != 'Offer Accepted') {

                System.debug('Student Details Sent To Alumni Office');

                // Future Implementation

                // Create Alumni Record

                // Send Email To Alumni Office

                // Notify Alumni Department

            }

        }

    }

}
