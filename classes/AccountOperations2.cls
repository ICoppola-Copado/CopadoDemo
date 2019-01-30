public class AccountOperations2 {
    public static Account setDefaultDescription2(Account a) {
        a.Description = 'Default Description';
        return a;
    }
    public static Account setDefaultPhone2(Account a) {
        a.Phone = '123456789';
        return a;
    }
    public static Account setDefaultURL2(Account a) {
        a.Website = 'www.copa.do';
        return a;
    }
}