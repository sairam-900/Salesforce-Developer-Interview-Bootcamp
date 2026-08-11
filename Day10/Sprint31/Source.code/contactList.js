import {
    LightningElement,
    api,
    wire
} from 'lwc';

import getContacts
    from '@salesforce/apex/AccountContactController.getContacts';

export default class ContactList extends LightningElement {

    @api accountId;

    @api accountName;

    contacts = [];

    isLoading = true;

    errorMessage;


    @wire(getContacts, {
        accountId: '$accountId'
    })
    wiredContacts({ data, error }) {

        this.isLoading = false;

        if (data) {

            this.contacts = data;

            this.errorMessage = undefined;

        } else if (error) {

            this.contacts = [];

            this.errorMessage =
                'Unable to load Contacts.';

            console.error(
                'Contact Error:',
                error
            );

        }

    }


    handleContactClick(event) {

        const contactId =
            event.currentTarget.dataset.id;


        this.dispatchEvent(

            new CustomEvent(
                'contactselected',
                {
                    detail: {
                        contactId: contactId
                    }
                }
            )

        );

    }

}