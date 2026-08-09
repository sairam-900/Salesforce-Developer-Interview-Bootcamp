import { LightningElement, wire } from 'lwc';

import getEligibleJobs
    from '@salesforce/apex/EligibleJobsController.getEligibleJobs';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EligibleJobs extends LightningElement {

    jobs = [];
    error;
    isLoading = true;

    @wire(getEligibleJobs)
    wiredJobs(result) {

        this.wiredJobsResult = result;

        const { data, error } = result;

        this.isLoading = false;

        if (data) {

            this.jobs = data;
            this.error = undefined;

        } else if (error) {

            this.jobs = [];
            this.error = error;
        }
    }

    handleApply(event) {

        const jobId = event.detail.jobId;

        console.log('Apply event received');
        console.log('Job Id:', jobId);

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Application',
                message: 'Application request received for Job: ' + jobId,
                variant: 'success'
            })
        );
    }
}