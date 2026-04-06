trigger AccountRecursionTrigger on Account (after update) {

    String key = 'AccountToOpportunity';

    if(!RecursionHelper.processedRecords.containsKey(key)){
        RecursionHelper.processedRecords.put(key, new Set<Id>());
    }

    Set<Id> processedIds = RecursionHelper.processedRecords.get(key);

    List<Opportunity> oppToUpdate = new List<Opportunity>();

    for(Account acc : Trigger.new){

        if(!processedIds.contains(acc.Id)){

            oppToUpdate.add(new Opportunity(
                Id = acc.Id, // example mapping
                StageName = 'Updated'
            ));

            processedIds.add(acc.Id);
        }
    }

    if(!oppToUpdate.isEmpty()){
        update oppToUpdate;
    }
}