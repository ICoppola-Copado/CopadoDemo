public class AccountOperations2 {
    public static Account setDefaultDescription(Account a) {
        a.Description = 'Default Description';
        return a;
    }
    public static Account setDefaultPhone(Account a) {
        a.Phone = '123456789';
        return a;
    }
    public static Account setDefaultURL(Account a) {
        a.Website = 'www.copa.do';
        return a;
    }
}