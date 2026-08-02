import { LightningElement } from 'lwc';

export default class PlacementHome extends LightningElement {

    studentName = 'Rahul';

    rollNumber = '22B81A0501';

    department = 'CSE';

    todayDate = new Date().toLocaleDateString();

    welcomeMessage = '';

    displayMessage = false;

    status = 'Not Applied';

    showWelcome() {

        this.welcomeMessage = 'Welcome to Salesforce Development';

        this.displayMessage = true;
    }

    applyJob() {

        this.status = 'Applied';
    }

    changeStudent() {

        this.studentName = 'Leela Sai Ram';

        this.rollNumber = '23PA1A04A7';

        this.department = 'ECE';
    }

}