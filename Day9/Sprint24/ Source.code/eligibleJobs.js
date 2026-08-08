import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getEligibleJobs
    from '@salesforce/apex/EligibleJobsController.getEligibleJobs';

import submitApplication
    from '@salesforce/apex/ApplicationController.submitApplication';

export default class EligibleJobs extends LightningElement {

    studentCGPA = 8.0;

    jobs = [];
    error;

    @wire(getEligibleJobs, { studentCGPA: '$studentCGPA' })
    wiredJobs({ data, error }) {

        if (data) {

            this.jobs = data.map(job => ({
                ...job,
                isApplying: false,
                isApplied: false,
                buttonLabel: 'Apply'
            }));

            this.error = undefined;

        } else if (error) {

            this.jobs = [];
            this.error = error;

            console.error('Error loading jobs:', error);
        }
    }

    async handleApply(event) {

        const jobId = event.currentTarget.dataset.jobId;

        if (!jobId) {

            this.showToast(
                'Error',
                'Job ID was not found.',
                'error'
            );

            return;
        }

        const index = this.jobs.findIndex(
            job => job.Id === jobId
        );

        if (index === -1) {
            return;
        }

        // Processing state
        this.updateJob(index, {
            isApplying: true,
            buttonLabel: 'Submitting...'
        });

        try {

            const applicationId =
                await submitApplication({
                    jobId: jobId
                });

            console.log(
                'Application Created:',
                applicationId
            );

            // Success state
            this.updateJob(index, {
                isApplying: false,
                isApplied: true,
                buttonLabel: '✓ Applied'
            });

            this.showToast(
                'Success',
                'Application submitted successfully!',
                'success'
            );

        } catch (error) {

            console.error(
                'Application Error:',
                error
            );

            let message =
                'We could not submit your application. Please try again.';

            if (
                error.body &&
                error.body.message
            ) {
                message = error.body.message;
            }

            // Return to Apply state
            this.updateJob(index, {
                isApplying: false,
                isApplied: false,
                buttonLabel: 'Apply'
            });

            this.showToast(
                'Application Failed',
                message,
                'error'
            );
        }
    }

    updateJob(index, changes) {

        this.jobs = this.jobs.map(
            (job, i) => {

                if (i === index) {
                    return {
                        ...job,
                        ...changes
                    };
                }

                return job;
            }
        );
    }

    showToast(title, message, variant) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }
}
