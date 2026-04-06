public with sharing class RestrictContactDeleteIfCaseExist {
    public static void RestrictContactDeleteIfCase(List<Contact> conList) {
        List<String> conIds = new List<String>();
        for(Contact con: conList){
            conIds.add(con.Id);
        }

        Map<Id, Integer> contHavingCase = new Map<Id, Integer>();
        List<Contact> contacts = [Select Id, (Select Id From Cases) From Contact Where Id IN: conIds];
        for(Contact con:contacts){
            if(con.Cases.size()>0){
                contHavingCase.put(con.Id, con.Cases.size());
            }
        }

        for(Contact con: conList){
            if(contHavingCase.containsKey(con.Id)){
                con.addError('You can\'t delete Contact. Case exist!');
            }
        }
    }
}