/*
* Purpose : This class will get the list of case and will pass to Lightning component
* CreatedBy : Jeetendra Gupta
* Date : 7/04/2019  
*/
public class CaseList {
 @AuraEnabled
    public static List<Case> getCaseList(List<Id> ids) {
        // Getting the list of contacts from where Id is in accountIds
                List<Case> caseList = [SELECT Id, Subject, Status,Contact.Home_Country__c,Contact.Product__r.Name,ContactId FROM Case WHERE Id in :ids];
                // Returning the contact list
        return caseList;
    }
}