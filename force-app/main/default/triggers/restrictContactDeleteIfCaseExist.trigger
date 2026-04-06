/** Prevent users from deleting a Contact if it has related Cases*/
trigger restrictContactDeleteIfCaseExist on Contact (before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        RestrictContactDeleteIfCaseExist.RestrictContactDeleteIfCase(Trigger.old);
    }
}