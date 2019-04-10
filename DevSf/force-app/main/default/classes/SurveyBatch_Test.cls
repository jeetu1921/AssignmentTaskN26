@isTest
public class SurveyBatch_Test {
	/**
    * Parameters: None
    * Description: Create Contact Data
    * Return Type: Contact
    */
    // NOTE: Here we can create a Seprate class to expose all the test method and can all in respective test class as here we have only one method 
    // so created here only. 
    static testMethod void testMethod1() 
    {        
        	contact con = new contact();
            con.FirstName = 'Test FirstName';
            con.LastName = 'Last Name';
            con.Email = 'test@test.com';
            con.Languages__c = 'en';
            con.survey_date__c = Date.today();
    		insert con;
         
        Test.startTest();
 		
            SurveyBatch obj = new SurveyBatch();
            DataBase.executeBatch(obj); 
             
        Test.stopTest();
    }
}