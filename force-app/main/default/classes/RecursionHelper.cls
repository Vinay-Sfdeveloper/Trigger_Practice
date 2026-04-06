/**Scenario: Cross Object Recursion
    👉 You have:
    Opportunity Trigger → updates Account
    Account Trigger → updates Opportunity 
*/
public class RecursionHelper {
    public static Map<String, Set<Id>> processedRecords = new Map<String, Set<Id>>();
}