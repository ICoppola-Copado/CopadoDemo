@isTest
private class TestAccountTrigger {
    
    @isTest static void TestDescription() {
        
        Account acc = new Account();
        acc.Name = 'Test';
        
        Test.startTest();
        insert acc;
        
        acc = [SELECT Description FROM Account WHERE Id = :acc.Id LIMIT 1];
        
        System.assertEquals('Test Copado', acc.Description);
        Test.stopTest();
    }
}