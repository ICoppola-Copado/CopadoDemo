@isTest
public class AccountOperationsTest2 {
    @isTest static void testAccountHasDefaultDescription() {       
        // Perform test
        Test.startTest();
        Account acc = new Account(Name='Test Account');
        Database.SaveResult result = Database.insert(acc);
        Test.stopTest();
        // Verify
        Account savedAcc = [SELECT Description FROM Account WHERE Id = :result.getId()];
        System.assertEquals('Default Description', savedAcc.Description); 
    }
    @isTest static void testAccountHasDefaultPhone() {       
        // Perform test
        Test.startTest();
        Account acc = new Account(Name='Test Account');
        Database.SaveResult result = Database.insert(acc);
        Test.stopTest();
        // Verify
        Account savedAcc = [SELECT phone FROM Account WHERE Id = :result.getId()];
        System.assertEquals('123456789', savedAcc.phone); 
    }
}