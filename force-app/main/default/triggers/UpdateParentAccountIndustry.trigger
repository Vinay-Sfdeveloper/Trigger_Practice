/**When a child Account’s Industry changes, 
 * update the parent Account’s Industry to match the child’s new Industry. */
trigger UpdateParentAccountIndustry on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        UpdateParentAccountIndustryHandler.UpdateParentAccountIndustry(Trigger.new, Trigger.oldMap);
    }
}