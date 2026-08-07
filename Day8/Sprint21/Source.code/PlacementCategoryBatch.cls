global class PlacementCategoryBatch
implements Database.Batchable<SObject>{

    global Database.QueryLocator start(Database.BatchableContext bc){

        return Database.getQueryLocator(
            'SELECT Id, Package__c, Placement_Category__c FROM Application__c WHERE Placement_Category__c=NULL'
        );
    }

    global void execute(Database.BatchableContext bc,
                        List<Application__c> scope){

        for(Application__c app : scope){

            if(app.Package__c >= 1000000){

                app.Placement_Category__c='Dream';

            }else{

                app.Placement_Category__c='Regular';
            }
        }

        update scope;
    }

    global void finish(Database.BatchableContext bc){

        System.debug('Batch Completed');
    }
}
