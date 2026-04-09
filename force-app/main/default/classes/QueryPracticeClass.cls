public with sharing class QueryPracticeClass {
    public queries() {

        /**Fetch top 5 contacts with most activities */
        List<AggregateResult> mostAct = [Select ContactId, Count(Id) From Task WHERE IsClosed = TRUE Group By ContactId Order By count(Id) DESC LIMIT 5];

        /**Latest record per parent */
        List<Account> oppData = [Select Id, Name, (Select Name From Opportunity Order By LastModifiedDate Desc Limit 1) From Account];

        /**Count child records */
        List<AggregateResult> accData = [Select Count(Id) From Contact Group By AccountId];
        
        List<Account> accData2 = [Select Id, (Select Id From Contacts) From Account];
        for(Account acc: accData2){
            system.debug('Total Contact##'+ acc.Contacts.size());
        }

        /** Find Duplicate Leads based on Email */
        List<AggregateResult> aggLeads = [Select Id, Email From Lead Group By Email Having Count(Id) > 1];

        /** Top 5 Accounts with Highest Revenue */
        List<AggregateResult> aggData = [Select AccountId, Sum(Amount) From Opportunity Group By AccountId Order By Sum(Amount) Desc Limit 5];

        /** Fetch Contacts whose Account Industry = 'IT' */
        List<Contact> conData = [Select Id, Name FRom Contact Where Account.Industry = 'IT'];

        /** Fetch Accounts with at least 2 Contacts */
        List<AggregateResult> aggData = [Select AccountId, Count(Id) total From Contact Group By AccountId Having Count(Id) >=2];

        /**Find Opportunities Closing This Month */
        List<Opportunity> oppData = [Select Id, Name From Opportunity Where CloseDate = THIS_MONTH];

        /**Get Accounts Where:
            At least 1 Closed Won Opportunity and No Open Cases 
        */
        List<Account> accData = [Select Id, Name From Account Where Id IN (Select AccountId From Opportunity Where StageName = 'Closed Won') AND Id IN (Select AccountId From Case Where Status != 'Closed')];
    }
}