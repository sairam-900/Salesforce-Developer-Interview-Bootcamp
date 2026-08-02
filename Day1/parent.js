import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {

    recordId = 'YOUR_RECORD_ID';

    message = 'Waiting for Child Event...';

    handleButtonClick(event) {
        this.message = event.detail;
    }

}