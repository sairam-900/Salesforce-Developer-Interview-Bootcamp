public with sharing class AccountContactController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {

        return [
            SELECT Id,
                   Name,
                   Industry,
                   Phone
            FROM Account
            ORDER BY Name
            LIMIT 50
        ];
    }


    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {

        if (accountId == null) {
            return new List<Contact>();
        }

        return [
            SELECT Id,
                   FirstName,
                   LastName,
                   Email,
                   Phone,
                   Title
            FROM Contact
            WHERE AccountId = :accountId
            ORDER BY LastName
        ];
    }
}