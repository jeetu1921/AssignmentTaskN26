/*
* Purpose : Once batch will execute it will pick all next survey date and send Email notification.
* CreatedBy : Jeetendra Gupta
* Date : 7/04/2019  
*/
global class SurveyBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) { 
        
        // collect the batches of records or objects to be passed to execute 
        String query = 'SELECT Id,Email,FirstName,Languages__c,survey_date__c FROM Contact WHERE survey_date__c !=null';
        system.debug('Query '+query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> conList) {
        Boolean limitErr = false;
        String msg;
        List<Contact> lstcontact = new List<Contact>();
        System.debug('1st step');
        // Step 0: Create a master list to hold the emails we'll send
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        // process each batch of records
        for(Contact myContact : conList){ 
            System.debug('2nd step');
            // Update the Contact Name 
            myContact.survey_date__c = null;
            lstcontact.add(myContact);
            if (myContact.Email != null && myContact.FirstName != null) {
                System.debug('3rd step');
                // Step 1: Create a new Email
                Messaging.SingleEmailMessage mail = 
                    new Messaging.SingleEmailMessage();
                
                // Step 2: Set list of people who should get the email
                List<String> sendTo = new List<String>();
                sendTo.add(myContact.Email);
                mail.setToAddresses(sendTo);
                
                // Step 3: Set who the email is sent from
                mail.setSenderDisplayName('Test Survey');
                
                // Step 4. Set email contents - you can use variables!
                mail.setSubject(' Upcoming Survey Detail');
                String msg1 = myContact.Languages__c.contains('en') ? ',please fill out our survey: ' : ',bitte fülle unsere Umfrage aus:';

                String body = myContact.Languages__c+' : '+'Dear ' + myContact.FirstName + msg1+' http://n27.com/survey/'+myContact.id  ;
                system.debug('Email:  '+body);
                mail.setHtmlBody(body);
                
                // Step 5. Add your email to the master list
                mails.add(mail);
            }
        }
        try {
            // Check The maximum limit of sending email Per day
            Messaging.reserveSingleEmailCapacity(mails.size());
            
        } catch(Exception e) {
            msg = 'Mail limit for today exceeded!';
            limitErr = true;
        }
        If(!limitErr)
        {
            //send mail and update contact Survey date field to null
            Messaging.sendEmail(mails);
            update lstcontact;
        }
        else
            // This is only execute once Email Day limit will exceed .
            System.debug(msg);
        
    }   
    
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
    }
}