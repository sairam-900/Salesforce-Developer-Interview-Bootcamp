global class ExpiredJobScheduler
implements Schedulable{

    global void execute(SchedulableContext sc){

        Database.executeBatch(new ExpiredJobBatch(),200);
    }
}
