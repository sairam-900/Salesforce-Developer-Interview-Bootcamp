public class CandidateSyncQueueable
    implements Queueable, Database.AllowsCallouts {

    private Id applicationId;

    public CandidateSyncQueueable(
        Id applicationId
    ) {
        this.applicationId =
            applicationId;
    }

    public void execute(
        QueueableContext context
    ) {

        Application__c app = [
            SELECT
                Id,
                Student__c,
                Student__r.Name,
                Student__r.Email__c,
                Student__r.Branch__c,
                Student__r.CGPA__c,
                Job__c,
                Job__r.Name,
                Job__r.Company__c,
                Job__r.Role__c,
                Status__c,
                Integration_Status__c,
                External_Candidate_Id__c,
                Last_Integration_Attempt__c,
                Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        System.debug(
            '=== SPRINT 34 CANDIDATE SYNC ==='
        );

        System.debug(
            'Application Id: ' +
            app.Id
        );

        app.Integration_Status__c =
            'Pending';

        app.Last_Integration_Attempt__c =
            System.now();

        app.Integration_Error__c =
            null;

        update app;

        try {

            Map<String, Object> candidate =
                new Map<String, Object>();

            candidate.put(
                'salesforceApplicationId',
                String.valueOf(app.Id)
            );

            candidate.put(
                'studentId',
                String.valueOf(app.Student__c)
            );

            candidate.put(
                'name',
                app.Student__r.Name
            );

            candidate.put(
                'email',
                app.Student__r.Email__c
            );

            candidate.put(
                'branch',
                app.Student__r.Branch__c
            );

            candidate.put(
                'cgpa',
                app.Student__r.CGPA__c
            );

            candidate.put(
                'jobId',
                String.valueOf(app.Job__c)
            );

            candidate.put(
                'jobName',
                app.Job__r.Name
            );

            candidate.put(
                'company',
                app.Job__r.Company__c
            );

            candidate.put(
                'role',
                app.Job__r.Role__c
            );

            candidate.put(
                'selectionDate',
                String.valueOf(Date.today())
            );

            System.debug(
                'Candidate Request: ' +
                JSON.serialize(candidate)
            );

            HttpRequest request =
                new HttpRequest();

            request.setEndpoint(
                'callout:Recruitment_API/candidates'
            );

            request.setMethod('POST');

            request.setHeader(
                'Content-Type',
                'application/json'
            );

            request.setBody(
                JSON.serialize(candidate)
            );

            Http http =
                new Http();

            HttpResponse response =
                http.send(request);

            Integer statusCode =
                response.getStatusCode();

            String responseBody =
                response.getBody();

            System.debug(
                'HTTP Status: ' +
                statusCode
            );

            System.debug(
                'API Response: ' +
                responseBody
            );

            if (
                statusCode == 200 ||
                statusCode == 201
            ) {

                handleSuccess(
                    app,
                    responseBody
                );

            } else if (
                statusCode == 400
            ) {

                handleFailure(
                    app,
                    'Bad Request: ' +
                    responseBody,
                    false
                );

            } else if (
                statusCode == 401
            ) {

                handleFailure(
                    app,
                    'Authentication Failed: ' +
                    responseBody,
                    false
                );

            } else if (
                statusCode == 403
            ) {

                handleFailure(
                    app,
                    'Forbidden: ' +
                    responseBody,
                    false
                );

            } else if (
                statusCode >= 500
            ) {

                handleFailure(
                    app,
                    'Server Error: ' +
                    responseBody,
                    true
                );

            } else {

                handleFailure(
                    app,
                    'Unexpected Response ' +
                    statusCode +
                    ': ' +
                    responseBody,
                    false
                );
            }

        } catch (Exception e) {

            handleFailure(
                app,
                'Callout Exception: ' +
                e.getMessage(),
                true
            );
        }
    }

    private void handleSuccess(
        Application__c app,
        String responseBody
    ) {

        app.Integration_Status__c =
            'Sent';

        app.Last_Integration_Attempt__c =
            System.now();

        app.Integration_Error__c =
            null;

        try {

            Map<String, Object> result =
                (Map<String, Object>)
                JSON.deserializeUntyped(
                    responseBody
                );

            if (
                result.containsKey(
                    'externalCandidateId'
                )
            ) {

                app.External_Candidate_Id__c =
                    String.valueOf(
                        result.get(
                            'externalCandidateId'
                        )
                    );
            }

        } catch (Exception e) {

            System.debug(
                'Response parsing error: ' +
                e.getMessage()
            );
        }

        update app;

        System.debug(
            '=== SPRINT 34 SUCCESS ==='
        );

        System.debug(
            'Integration Status: ' +
            app.Integration_Status__c
        );

        System.debug(
            'External Candidate Id: ' +
            app.External_Candidate_Id__c
        );
    }

    private void handleFailure(
        Application__c app,
        String errorMessage,
        Boolean retryRequired
    ) {

        if (retryRequired) {

            app.Integration_Status__c =
                'Retry Required';

        } else {

            app.Integration_Status__c =
                'Failed';
        }

        app.Last_Integration_Attempt__c =
            System.now();

        app.Integration_Error__c =
            errorMessage;

        update app;

        System.debug(
            'Integration Status: ' +
            app.Integration_Status__c
        );

        System.debug(
            'Integration Error: ' +
            errorMessage
        );
    }
}
