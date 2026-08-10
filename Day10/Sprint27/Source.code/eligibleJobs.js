import { LightningElement, wire } from 'lwc';
import getJobs from '@salesforce/apex/JobController.getJobs';

export default class EligibleJobs extends LightningElement {

    jobs = [];
    selectedJobId;
    notificationMessage;
    showNotification = false;

    @wire(getJobs)
    wiredJobs({ data, error }) {

        if (data) {
            this.jobs = data;
        } else if (error) {
            console.error('Error loading jobs:', error);
        }
    }

    handleViewDetails(event) {

        this.selectedJobId = event.detail.jobId;

        console.log('View Details event received');
        console.log('Job Id:', this.selectedJobId);
    }

    handleApply(event) {

        const jobId = event.detail.jobId;

        this.notificationMessage =
            `Application started successfully for Job ID: ${jobId}`;

        this.showNotification = true;

        console.log('Apply event received');
        console.log('Job Id:', jobId);

        // Hide notification after 3 seconds
        setTimeout(() => {
            this.showNotification = false;
        }, 3000);
    }
}