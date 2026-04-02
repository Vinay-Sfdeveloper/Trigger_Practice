public with sharing class restrictDuplicateAccountHandler {
    public static void checkDuplicateAccounts(List<Account> accList) {
        Set<String> newAccNames = new Set<String>();

        /** Get all Account's Name inserted */
        for(Account acc: accList){
            newAccNames.add(acc.Name);
        }

        /** Pass new names and get account details to show error  */
        Set<String> accNames = new Set<String>();
        List<Account> accData = [Select Id, Name FROM Account Where Name IN: newAccNames];
        for(Account acc: accData){
            accNames.add(acc.Name);
        }

        /** Show Error to that account record having same name */
        for(Account acc: accList){
            if(accNames.contains(acc.Name)){
                acc.addError('An Account with '+acc.Name+' name already exists!');
            }
        }
    }
}