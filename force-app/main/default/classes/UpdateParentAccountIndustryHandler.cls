public with sharing class UpdateParentAccountIndustryHandler {
    public static void UpdateParentAccountIndustry(List<Account> newAccData, Map<Id, Account> oldAccData) {
        List<String> parentAccIds = new List<String>();
        for(Account acc: newAccData){
            parentAccIds.add(acc.ParentId);
        }

        Map<Id,Account> parentData = new Map<Id, Account> ([Select Id, Industry From Account Where Id IN: parentAccIds]);
        system.debug('parentData###'+ parentData);
        List<Account> parentToUpdate = new List<Account>();
        for(Account acc: newAccData){
            if(parentData.containsKey(acc.ParentId) && oldAccData.get(acc.Id).Industry != acc.Industry){
                Account updateParent = parentData.get(acc.ParentId);
                updateParent.Industry = acc.Industry;
                parentToUpdate.add(updateParent);
            }
        }

        if(parentToUpdate.size()>0){
            Update parentToUpdate;
        }
    }
}