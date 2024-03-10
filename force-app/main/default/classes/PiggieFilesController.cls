public with sharing class PiggieFilesController {
    @AuraEnabled(cacheable=true)
    public static List<ContentDocumentLink> getPiggiePhoto(String recordId) {
        return [
            SELECT ContentDocumentId, ContentDocument.Title, ContentDocument.FileExtension, ContentDocument.ContentSize
            FROM ContentDocumentLink
            WHERE LinkedEntityId = :recordId
            LIMIT 1 // Assuming you only want one image, adjust as necessary
        ];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<String> getPhotoDescription(String recordId){
        
        List<String> photoDescriptions = new List<String>();
        
        // Query ContentDocumentLink to get related ContentDocument for the record
        List<ContentDocumentLink> links = [
            SELECT ContentDocument.Description
            FROM ContentDocumentLink 
            WHERE LinkedEntityId = :recordId
        ];
        
        for (ContentDocumentLink link : links) {
            if(link.ContentDocument.Description != null) {
                photoDescriptions.add(link.ContentDocument.Description);
            }
        }
        
        return photoDescriptions;
    }
}