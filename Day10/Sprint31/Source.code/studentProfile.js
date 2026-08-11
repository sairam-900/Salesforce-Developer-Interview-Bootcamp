import { LightningElement, api } from 'lwc';

export default class StudentProfile extends LightningElement {

    @api recordId;

    isSaving = false;

    showSuccess = false;
    showError = false;

    errorMessage = '';


    handleSubmit(event) {

        event.preventDefault();

        this.isSaving = true;

        this.showSuccess = false;
        this.showError = false;

        const fields = event.detail.fields;

        this.template
            .querySelector(
                'lightning-record-edit-form'
            )
            .submit(fields);

    }


    handleSuccess(event) {

        this.isSaving = false;

        this.showSuccess = true;

        this.showError = false;

        console.log(
            'Profile updated successfully'
        );

        console.log(
            'Record Id:',
            event.detail.id
        );


        setTimeout(() => {

            this.showSuccess = false;

        }, 3000);

    }


    handleError(event) {

        this.isSaving = false;

        this.showError = true;

        this.showSuccess = false;

        this.errorMessage =
            'We could not update your profile. Please review the highlighted fields.';

        console.error(
            'Profile update error:',
            event.detail
        );

    }

}