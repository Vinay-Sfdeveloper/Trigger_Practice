/**When an Account is inserted, 
 * automatically create a related Opportunity with a default Stage and Amount. */
trigger CreateOppOnAccInsert on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        CreateOppOnAccInsertHandler.CreateOppOnAccInsert(Trigger.new);
    }
}