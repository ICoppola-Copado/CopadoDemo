public class AccountAutomations {
    Public static Account setDefaultDescription(Account a){
        If (a.Description != null) return a;
        Else {
            a.Description = 'Default description';
            return a;
        }
        //Test22-6
        //Test22-6.2
        //Test
        //Test 1 july
    }
    public static Account setDefaultBillingAddress(Account a){
        a.billingstreet = 'Basauri, 6'; 
        a.billingstate = 'Madrid'; 
        a.billingpostalcode ='28023'; 
        return a;
    }
    public static Account setDefaultShippingAddress(Account a){
        a.shippingstreet = 'Basauri, 6'; 
        a.shippingstate = 'Madrid';
        a.shippingpostalcode ='28023';
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