public class AccountOperations {
    public static Account setDefaultDescription(Account a) {
        a.Description = 'Default Description';
        return a;
    }
    public static Account setDefaultPhone(Account a) {//Dev01
        a.Phone = '98798798771';
        return a;
    }
    public static Account setDefaultURL(Account a) {//DEV2
        a.Website = 'www.copa.do.com';//DEV2
        return a;
    }
    public static Account setDefaultName(Account a) {
        a.name = 'Test Account';
        return a;
    }
}