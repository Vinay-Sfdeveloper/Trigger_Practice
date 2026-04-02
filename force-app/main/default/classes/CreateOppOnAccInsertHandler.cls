public with sharing class CreateOppOnAccInsertHandler {
    public static void CreateOppOnAccInsert(List<Account> accList) {

        List<Opportunity> oppToInsert = new List<Opportunity>();
        for(Account acc:accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.AccountId = acc.Id;
            opp.CloseDate = Date.today().addMonths(1);
            opp.StageName = 'Prospecting';
            opp.Amount = 5000;
            oppToInsert.add(opp);
        }

        if(oppToInsert.size()>0){
            INSERT oppToInsert;
        }
    }
}