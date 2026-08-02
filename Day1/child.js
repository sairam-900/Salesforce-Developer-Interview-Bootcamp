import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Book__c.Name'];

export default class Child extends LightningElement {

    @api recordId;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: FIELDS
    })
    book;

    get bookName() {
        return this.book.data
            ? this.book.data.fields.Name.value
            : '';
    }

    sendMessage() {

        const event = new CustomEvent('buttonclick', {
            detail: 'Button clicked successfully!'
        });

        this.dispatchEvent(event);
    }

}