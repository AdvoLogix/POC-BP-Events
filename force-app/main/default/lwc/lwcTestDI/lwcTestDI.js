import { LightningElement, api } from 'lwc';

export default class LwcTestDI extends LightningElement {
    @api eventLabel;
    @api eventType;
    @api eventData;
    
    get eventDataJSON() {
        return this.eventData ? JSON.parse(this.eventData) : '';
    }
}