public with sharing class CertificationVerificationController {

    @AuraEnabled
    public static String verifyCertification(
        String certificationNumber
    ) {

        if (String.isBlank(certificationNumber)) {
            throw new AuraHandledException(
                'Certification number is required.'
            );
        }

        HttpRequest request =
            new HttpRequest();

        request.setEndpoint(
            'callout:Certification_API/verify'
        );

        request.setMethod('POST');

        request.setHeader(
            'Content-Type',
            'application/json'
        );

        Map<String, Object> requestData =
            new Map<String, Object>();

        requestData.put(
            'certificationNumber',
            certificationNumber
        );

        request.setBody(
            JSON.serialize(requestData)
        );

        Http http = new Http();

        HttpResponse response;

        try {

            response = http.send(request);

        } catch (Exception e) {

            throw new AuraHandledException(
                'The callout failed: ' +
                e.getMessage()
            );
        }

        Integer statusCode =
            response.getStatusCode();

        String responseBody =
            response.getBody();

        System.debug(
            'Certification HTTP Status: ' +
            statusCode
        );

        System.debug(
            'Certification Response: ' +
            responseBody
        );

        if (statusCode == 200 ||
            statusCode == 201) {

            return responseBody;
        }

        if (statusCode == 400) {

            throw new AuraHandledException(
                'Bad certification request.'
            );
        }

        if (statusCode == 401) {

            throw new AuraHandledException(
                'Authentication failed.'
            );
        }

        if (statusCode == 403) {

            throw new AuraHandledException(
                'Access forbidden.'
            );
        }

        if (statusCode >= 500) {

            throw new AuraHandledException(
                'Certification service is temporarily unavailable.'
            );
        }

        throw new AuraHandledException(
            'Unexpected response: ' +
            statusCode
        );
    }
}
