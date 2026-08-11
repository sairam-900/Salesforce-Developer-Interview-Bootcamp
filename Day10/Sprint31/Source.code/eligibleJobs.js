import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getEligibleJobs
    from '@salesforce/apex/JobController.getEligibleJobs';

export default class EligibleJobs extends LightningElement {

    // Student Profile
    studentName = '';
    studentCGPA = '';
    skills = '';
    preferredLocation = '';
    graduationYear = '';
    backlogs = '';

    // Jobs
    jobs = [];

    // UI state
    isLoading = false;
    profileSaved = false;
    errorMessage;

    selectedJob;
    showDetails = false;


    // =========================
    // LOCATION OPTIONS
    // =========================

    get locationOptions() {

        return [
            {
                label: 'Hyderabad',
                value: 'Hyderabad'
            },
            {
                label: 'Bengaluru',
                value: 'Bengaluru'
            },
            {
                label: 'Chennai',
                value: 'Chennai'
            },
            {
                label: 'Pune',
                value: 'Pune'
            },
            {
                label: 'Mumbai',
                value: 'Mumbai'
            },
            {
                label: 'Delhi',
                value: 'Delhi'
            },
            {
                label: 'Noida',
                value: 'Noida'
            },
            {
                label: 'Gurugram',
                value: 'Gurugram'
            },
            {
                label: 'Kolkata',
                value: 'Kolkata'
            },
            {
                label: 'Any Location',
                value: 'Any'
            }
        ];

    }


    // =========================
    // STUDENT NAME
    // =========================

    handleNameChange(event) {

        this.studentName =
            event.target.value;

    }


    // =========================
    // CGPA
    // =========================

    handleCGPAChange(event) {

        this.studentCGPA =
            event.target.value;

    }


    // =========================
    // SKILLS
    // =========================

    handleSkillsChange(event) {

        this.skills =
            event.target.value;

    }


    // =========================
    // LOCATION
    // =========================

    handleLocationChange(event) {

        this.preferredLocation =
            event.target.value;

    }


    // =========================
    // GRADUATION YEAR
    // =========================

    handleGraduationYearChange(event) {

        this.graduationYear =
            event.target.value;

    }


    // =========================
    // BACKLOGS
    // =========================

    handleBacklogsChange(event) {

        this.backlogs =
            event.target.value;

    }


    // =========================
    // SAVE PROFILE
    // =========================

    async handleSaveProfile() {

        if (!this.studentName) {

            this.showToast(
                'Error',
                'Please enter Student Name.',
                'error'
            );

            return;
        }


        if (!this.studentCGPA) {

            this.showToast(
                'Error',
                'Please enter Student CGPA.',
                'error'
            );

            return;
        }


        const cgpa =
            Number(this.studentCGPA);


        if (cgpa < 0 || cgpa > 10) {

            this.showToast(
                'Error',
                'CGPA must be between 0 and 10.',
                'error'
            );

            return;
        }


        this.isLoading = true;

        this.profileSaved = true;

        this.errorMessage = undefined;


        try {

            this.jobs =
                await getEligibleJobs({
                    studentCGPA: cgpa
                });


            if (this.jobs.length === 0) {

                this.showToast(
                    'Information',
                    'No eligible jobs available for your current CGPA.',
                    'info'
                );

            } else {

                this.showToast(
                    'Success',
                    'Profile saved successfully. Eligible jobs loaded.',
                    'success'
                );

            }

        } catch (error) {

            this.jobs = [];

            this.errorMessage =
                this.getErrorMessage(error);

            this.showToast(
                'Error',
                this.errorMessage,
                'error'
            );

        } finally {

            this.isLoading = false;

        }

    }


    // =========================
    // VIEW DETAILS
    // =========================

    handleViewDetails(event) {

        const jobId =
            event.detail.jobId;


        this.selectedJob =
            this.jobs.find(
                job => job.Id === jobId
            );


        if (this.selectedJob) {

            this.showDetails = true;

        }

    }


    // =========================
    // CLOSE DETAILS
    // =========================

    handleCloseDetails() {

        this.showDetails = false;

        this.selectedJob = undefined;

    }


    // =========================
    // APPLY
    // =========================

    handleApply(event) {

        const jobId =
            event.detail.jobId;


        this.showToast(
            'Success',
            'Application submitted successfully. Job ID: ' + jobId,
            'success'
        );

    }


    // =========================
    // ERROR MESSAGE
    // =========================

    getErrorMessage(error) {

        if (
            error &&
            error.body &&
            error.body.message
        ) {

            return error.body.message;

        }

        return 'Something went wrong while loading eligible jobs.';

    }


    // =========================
    // TOAST
    // =========================

    showToast(
        title,
        message,
        variant
    ) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );

    }

}