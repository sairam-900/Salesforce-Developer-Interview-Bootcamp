import { LightningElement, wire } from 'lwc';
import getEligibleJobs from '@salesforce/apex/EligibleJobsController.getEligibleJobs';

export default class EligibleJobs extends LightningElement {

    // Temporary student CGPA for Task 6 demonstration
    studentCGPA = 8.0;

    jobs = [];
    error;

    @wire(getEligibleJobs, { studentCGPA: '$studentCGPA' })
    wiredJobs({ data, error }) {

        if (data) {
            this.jobs = data;
            this.error = undefined;

            console.log('Eligible Jobs:', data);
        } else if (error) {
            this.jobs = [];
            this.error = error;

            console.error('Error loading eligible jobs:', error);
        }
    }
}
