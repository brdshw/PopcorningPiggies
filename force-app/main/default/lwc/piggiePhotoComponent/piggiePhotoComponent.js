import { LightningElement, api, wire } from 'lwc';
import getPiggiePhoto from '@salesforce/apex/PiggieFilesController.getPiggiePhoto';
import getPhotoDescription from '@salesforce/apex/PiggieFilesController.getPhotoDescription';


export default class PiggiePhotoComponent extends LightningElement {
    @api recordId;
    imageUrl;
    

    @wire(getPiggiePhoto, { recordId: '$recordId' })
    
    wiredPhotos({ error, data }) {
        
        if (data && data.length > 0) {
            
            this.imageUrl = `/sfc/servlet.shepherd/document/download/${data[0].ContentDocumentId}`;

               // Call the description method
        getPhotoDescription({recordId: this.recordId})
        .then(description => {
            // Do something with the description, e.g., store it in a property
            this.piggieDescription = description; 
        })
        .catch(error => {
            console.error(error);
        });  


        } else if (error) {
            console.error(error);
        }
    }
}
