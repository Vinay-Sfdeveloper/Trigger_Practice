/**When an Account has more than 5 closed won Opportunities, update its Type to “VIP Customer”. */
trigger UpdateAccTypeForOpp on Opportunity (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            UpdateAccTypeForOppHandler.UpdateAccTypeForOpp(Trigger.new, null);
        }
        else if(Trigger.isUpdate){
            UpdateAccTypeForOppHandler.UpdateAccTypeForOpp(Trigger.new, Trigger.oldMap);
        }
    }
}