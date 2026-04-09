/***Update Account Type only if ALL Opportunities are Closed Won */
trigger UpdateAccTypeAllOppWon on Opportunity (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            UpdateAccTypeAllOppWonHandler.UpdateAccTypeAllOppWon(Trigger.new, Trigger.oldMap);
        }
    }
}