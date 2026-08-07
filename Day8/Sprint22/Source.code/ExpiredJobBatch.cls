global class ExpiredJobBatch
implements Database.Batchable<SObject>{

    global Database.QueryLocator start(Database.BatchableContext bc){

        return Database.getQueryLocator(

        'SELECT Id, Status__c, Last_Date__c FROM Job__c WHERE Status__c = \'Open\''
        );
    }

    global void execute(Database.BatchableContext bc,
                        List<Job__c> scope){

        Date todayDate = Date.today();

        for(Job__c job : scope){

            if(job.Last_Date__c < todayDate){

                job.Status__c='Closed';
            }
        }

        update scope;
    }

    global void finish(Database.BatchableContext bc){

        System.debug('Expired Jobs Closed');
    }
}
