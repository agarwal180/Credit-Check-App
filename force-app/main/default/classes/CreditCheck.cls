/* Class Name: CreditCheck
* Rev. History:
* Sno.		Date			Updated By			Changes Made
* 1		23/09/2019		Subham Agarwal		CreditCheck class Created.
* @Author: Subham Agarwal
* @Created Date: 23/09/2019
*/

public class CreditCheck {

    // This method is to create case and update Credit Check Status field on Account
    @AuraEnabled
    public static String createCase(String accid,String subject,String CreditCheckStatus)
    {
            String message;
            Case cs = new Case();
            cs.Subject = subject;
            cs.Credit_Check_Status__c = CreditCheckStatus;
            cs.Accountid = accid;
        Database.saveResult sr = Database.insert(cs,false);
        if(!sr.isSuccess()){
            for(Database.error err : sr.getErrors()){
                message += err.getMessage();
            }
        }
            List<Account> accListupdate=new List<Account>();
            List<Account> accList = [Select id,Name,Credit_Check_Status__c from Account Where id = :accid limit 1];
            for(Account acc:accList){
            acc.Credit_Check_Status__c=cs.Credit_Check_Status__c;
            accListupdate.add(acc);
            }
            update accListupdate;
         
    return message;
    }
        
}
