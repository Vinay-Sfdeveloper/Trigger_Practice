public with sharing class UpdateAccTypeForOppHandler {
    public static void UpdateAccTypeForOpp(List<Opportunity> newOppList, Map<Id, Opportunity> oppList) {
        List<String> accIds = new List<String>();
        for(Opportunity opp: newOppList){
            if(oppList == null){
                if(opp.AccountId != null){
                    accIds.add(opp.AccountId);
                }
            } else {
                if(opp.AccountId != null && oppList.get(opp.Id).AccountId != opp.AccountId){
                    accIds.add(opp.AccountId);
                    accIds.add(oppList.get(opp.Id).AccountId);
                } else if(opp.AccountId != null){
                    accIds.add(opp.AccountId);
                }
            }            
        }

        Map<Id, Integer> countMap = new Map<Id, Integer>();
        List<Account> accDatas = [Select Id, (Select Id From Opportunities Where StageName = 'Closed Won') From Account Where Id IN: accIds ];
        for(Account acc:accDatas){
            countMap.put(acc.Id, acc.Opportunities.size());
        }

        List<Account> accToUpdate = new List<Account>();
        for(Opportunity opp: newOppList){
            if(countMap.containsKey(opp.AccountId) && countMap.get(opp.AccountId) > 5){
                Account updatedAcc = new Account(Id = opp.AccountId);
                updatedAcc.Type = 'VIP Customer';
                accToUpdate.add(updatedAcc);
            } 
        }
        if(accToUpdate.size() > 0){
            update accToUpdate;
        }
        
        
    }
}