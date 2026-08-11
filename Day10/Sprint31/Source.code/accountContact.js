import { LightningElement, wire } from 'lwc';

import getAccounts
    from '@salesforce/apex/AccountContactController.getAccounts';

export default class AccountContact extends LightningElement {

    accounts = [];

    selectedAccountId;

    selectedAccountName;

    isLoading = true;

    errorMessage;


    @wire(getAccounts)
    wiredAccounts({ data, error }) {

        this.isLoading = false;

        if (data) {

            this.accounts = data;

            this.errorMessage = undefined;

        } else if (error) {

            this.accounts = [];

            this.errorMessage =
                'Unable to load Accounts.';

            console.error(
                'Account Error:',
                error
            );
        }
    }


    handleAccountSelect(event) {

        this.selectedAccountId =
            event.currentTarget.dataset.id;

        this.selectedAccountName =
            event.currentTarget.dataset.name;

        console.log(
            'Selected Account Id:',
            this.selectedAccountId
        );

    }


    handleContactSelected(event) {

        const contactId =
            event.detail.contactId;

        console.log(
            'Selected Contact Id:',
            contactId
        );

    }

}