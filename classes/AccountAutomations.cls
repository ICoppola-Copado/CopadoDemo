public class AccountAutomations {
    Public static Account setDefaultDescription(Account a){
        If (a.Description != null) return a;
        Else {
            a.Description = 'Default description';
            return a;
            //test
            //test2
            //test3
            //{!Environment.EnvironmentName}
        }
    }
    public static Account setDefaultBillingAddress(Account a){
        a.billingstreet = 'Comandante, 6'; 
        a.billingstate = 'Madrid'; 
        a.billingpostalcode ='99012'; 
        return a;
    }
    public static Account setDefaultShippingAddress(Account a){
        a.shippingstreet = 'Basauri, 6'; 
        a.shippingstate = 'Barcelona';
        a.shippingpostalcode ='32123';
        return a;
    }
    public static Account setDefaultPhone(Account a) {
        a.Phone='688456789';
        return a;
    }
    public static Account setDefaultURL(Account a) {
        a.website = 'www.copa.do'; 
        return a;
    }
}