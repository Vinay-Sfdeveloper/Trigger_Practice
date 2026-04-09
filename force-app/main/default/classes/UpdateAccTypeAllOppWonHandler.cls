public with sharing class UpdateAccTypeAllOppWonHandler {
    public static void UpdateAccTypeAllOppWon(List<Opportunity> newOpp, Map<Id, Opportunity> oldOppMap) {
        /** Set Account Ids */
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp: newOpp){
            if(opp.AccountId != null && opp.StageName != oldOppMap.get(opp.Id).StageName){
                accIds.add(opp.AccountId);
            }
        }

        /** Get total Opp of an Account */
        Map<Id, Integer> totalOpp = new Map<Id, Integer>();
        List<AggregateResult> getTotalOpp = [Select AccountId, Count(Id) total From Opportunity Where AccountId IN: accIds Group BY AccountId];
        for(AggregateResult agg: getTotalOpp){
            totalOpp.put((Id)agg.get('AccountId'), (Integer)agg.get('total'));
        }

        /** Get Closed Won Opp related to Account */
        Map<Id, Integer> closedOpp = new Map<Id, Integer>();
        List<AggregateResult> getClosedOpp = [Select AccountId, Count(Id) total From Opportunity Where AccountId IN: accIds AND StageName = 'Closed Won' Group BY AccountId];
        for(AggregateResult agg: getClosedOpp){
            closedOpp.put((Id)agg.get('AccountId'), (Integer)agg.get('total'));
        }

        /** Compare Total Opp with Closed Won and update Account */
        List<Account> accToUpdate = new List<Account>();
        for(Id accId: totalOpp.keySet()){
            if(totalOpp.get(accId) == closedOpp.get(accId)){
                Account acc = new Account();
                acc.Id = accId;
                acc.Type = 'Customer';
                accToUpdate.add(acc);
            }
        }

        if(!accToUpdate.isEmpty()){
            Update accToUpdate;
        }
    }
}