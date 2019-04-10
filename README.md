Assignment Description:
Q1. 
Created a field on Contact object called ' survey_date__c' and using existing   'language__c' .
Created a workflow which will set the language to en, if user is entering except 'de'. 
Created a Batch apex which will get the list of all 'survey date' where value is not null.
Batch apex will process all the contact which have 'survey date' and also taking care of daily limit of email(e.g: if dev box have max limit is 10, and our batch apex have 50 records which have survey date field in this case only 10 records will be processed. once email will send successfully survey date field is setting null. as only 10 email is getting sent so not clearing the date of remaining 40).
Q2.
Created 'Product__c' (Lookup to Product Object) and 'Home_Country__c' (Global Picklist) field.
Created a Lightning component and added into case object Page layout to display the case and their related product.
To setup the data model of the product ,based on country and product option created a separate data model.
Product object(standard) will have the product detail.
‘Product option ‘object will have product option/specification like ‘cost per calendar ‘.
A new object (Product specification) will create which will hold the product and their specification from product option object. e.g one product can have multiple feature/behavior.
Now, will create a separate object ‘Pricing Matrix’ which will hold the Rate Country wise and will be linked to product ‘specification object’, which will have product and product option detail.

NOTE: As per my understanding there should be some changes in the requirement product and home country field is related to the Contact object. As, per my experience both fields should be present on the case object. 
As per existing design one customer can only hold one product (debit/credit card)
e.g: I am having two CITI bank Credit card. If I do complain to customer care for my both card two cases will be created and product detail will be tracked under cases only.


