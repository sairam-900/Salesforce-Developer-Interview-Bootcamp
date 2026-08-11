import { LightningElement, api } from 'lwc';

export default class EmptyState extends LightningElement {

    @api title = 'No Records Found';

    @api message =
        'There are no records available right now.';

    @api actionLabel;


    get showAction() {
        return !!this.actionLabel;
    }


    handleAction() {

        this.dispatchEvent(
            new CustomEvent('action')
        );

    }
}