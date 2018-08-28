@isTest
public class AccountOtherOperationsTest {
    @isTest static void testAccountHasDefaultDescription() {       
        // Perform test
        Test.startTest();
        Account acc = new Account(Name='Test Account',Site='Madrid');
        Database.SaveResult result = Database.insert(acc);
        Test.stopTest();
        // Verify
        Account savedAcc = [SELECT Description, Site FROM Account WHERE Id = :result.getId()];
        System.assertEquals('Default Description', savedAcc.Description);
        System.assertEquals('Barcelona', savedAcc.Site);

    }
}