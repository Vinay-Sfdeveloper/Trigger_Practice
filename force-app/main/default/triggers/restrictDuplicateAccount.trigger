/** You need to prevent users from inserting 
 * duplicate Account records based on the Account Name.*/
trigger restrictDuplicateAccount on Account (before insert) {
    if(Trigger.isBefore && trigger.isInsert){
        restrictDuplicateAccountHandler.checkDuplicateAccounts(Trigger.new);
    }
    /*Set<String> newAccNames = new Set<String>();

    
    for(Account acc: Trigger.new){
        newAccNames.add(acc.Name);
    }

    
    Set<String> accNames = new Set<String>();
    List<Account> accData = [Select Id, Name FROM Account Where Name IN: newAccNames];
    for(Account acc: accData){
        accNames.add(acc.Name);
    }

    
    for(Account acc: Trigger.new){
        if(accNames.contains(acc.Name)){
            acc.addError('An Account with this name already exists.!');
        }
    }*/

}