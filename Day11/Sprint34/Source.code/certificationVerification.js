import { LightningElement } from 'lwc';

import verifyCertification
    from '@salesforce/apex/CertificationVerificationController.verifyCertification';

export default class CertificationVerification
    extends LightningElement {

    certificationNumber = '';
    result;
    errorMessage;
    isLoading = false;

    handleChange(event) {

        this.certificationNumber =
            event.target.value;

        this.result = null;
        this.errorMessage = null;
    }

    verifyCertification() {

        if (!this.certificationNumber) {

            this.errorMessage =
                'Please enter a certification number.';

            return;
        }

        this.isLoading = true;
        this.result = null;
        this.errorMessage = null;

        verifyCertification({
            certificationNumber:
                this.certificationNumber
        })
        .then(response => {

            this.result =
                typeof response === 'string'
                    ? JSON.parse(response)
                    : response;

        })
        .catch(error => {

            this.errorMessage =
                this.getErrorMessage(error);

        })
        .finally(() => {

            this.isLoading = false;

        });
    }

    getErrorMessage(error) {

        if (
            error &&
            error.body &&
            error.body.message
        ) {

            return error.body.message;
        }

        return 'Certification verification failed.';
    }
}