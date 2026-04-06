trigger OpportunityRecursionTrigger on Opportunity (after update) {

    String key = 'OpportunityToAccount';

    if(!RecursionHelper.processedRecords.containsKey(key)){
        RecursionHelper.processedRecords.put(key, new Set<Id>());
    }

    Set<Id> processedIds = RecursionHelper.processedRecords.get(key);

    List<Account> accToUpdate = new List<Account>();

    for(Opportunity opp : Trigger.new){

        if(!processedIds.contains(opp.Id)){

            accToUpdate.add(new Account(
                Id = opp.AccountId,
                Type = 'Updated'
            ));

            processedIds.add(opp.Id);
        }
    }

    if(!accToUpdate.isEmpty()){
        update accToUpdate;
    }
}