import { LightningElement, api } from 'lwc';

export default class JobCard extends LightningElement {

    @api job;

    handleApply() {

        const applyEvent = new CustomEvent('apply', {
            detail: {
                jobId: this.job.Id
            }
        });

        this.dispatchEvent(applyEvent);
    }
}