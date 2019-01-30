public class AccountOperations2 {
    public static Account setDefaultDescription(Account a) {
        a.Description = 'Default Description';
        return a;
    }
    public static Account setDefaultPhone(Account a) {
        a.Phone = '987654321';
        return a;
    }
    public static Account setDefaultURL(Account a) {
        a.Website = 'www.copa.do.com';
        return a;
    }
    public static Account setDefaultName(Account a) {
        a.name = 'Test Account';
        return a;
    }
    public static Account setDefaultAnnualRevenue (Account a) {
        a.AnnualRevenue = 100000;
        return a;
    }
}