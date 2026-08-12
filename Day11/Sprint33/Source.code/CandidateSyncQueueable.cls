public class CandidateSyncQueueable
    implements Queueable, Database.AllowsCallouts {

    private Id applicationId;

    public CandidateSyncQueueable(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        Application__c app = [
            SELECT Id,
                   Status__c,
                   Student__c,
                   Student__r.Name,
                   Student__r.Email__c,
                   Student__r.Branch__c,
                   Student__r.CGPA__c,
                   Job__c,
                   Job__r.Name,
                   Job__r.Company__c,
                   Job__r.Role__c,
                   Integration_Status_c__c,
                   External_Candidate_Id__c,
                   Last_Integration_Attempt__c,
                   Integration_Error__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        try {

            /*
             * CHECK JOB
             */
            if (app.Job__c == null) {

                app.Integration_Status_c__c =
                    'Failed';

                app.Last_Integration_Attempt__c =
                    System.now();

                app.Integration_Error__c =
                    'Job is not assigned to this Application.';

                update app;

                return;
            }


            /*
             * BUILD CANDIDATE REQUEST
             */
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
                '=== SPRINT 33 REQUEST ==='
            );

            System.debug(
                'Application Id: ' +
                app.Id
            );

            System.debug(
                'Candidate Request: ' +
                JSON.serialize(candidate)
            );


            /*
             * HTTP REQUEST
             */
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


            /*
             * CALLOUT
             */
            Http http = new Http();

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


            /*
             * SUCCESS
             */
            if (
                statusCode == 200 ||
                statusCode == 201
            ) {

                Map<String, Object> result =
                    (Map<String, Object>)
                    JSON.deserializeUntyped(
                        responseBody
                    );


                /*
                 * GET EXTERNAL CANDIDATE ID
                 */
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


                /*
                 * UPDATE SUCCESS STATUS
                 */
                app.Integration_Status_c__c =
                    'Sent';

                app.Last_Integration_Attempt__c =
                    System.now();

                app.Integration_Error__c =
                    null;


                /*
                 * SAVE AFTER CALLOUT
                 */
                update app;


                System.debug(
                    '=== SPRINT 33 SUCCESS ==='
                );

                System.debug(
                    'Integration Status: ' +
                    app.Integration_Status_c__c
                );

                System.debug(
                    'External Candidate Id: ' +
                    app.External_Candidate_Id__c
                );

            }


            /*
             * 400
             */
            else if (statusCode == 400) {

                saveFailure(
                    app,
                    'Bad Request: ' +
                    responseBody,
                    'Failed'
                );

            }


            /*
             * 401
             */
            else if (statusCode == 401) {

                saveFailure(
                    app,
                    'Authentication Failed: ' +
                    responseBody,
                    'Failed'
                );

            }


            /*
             * 403
             */
            else if (statusCode == 403) {

                saveFailure(
                    app,
                    'Forbidden: ' +
                    responseBody,
                    'Failed'
                );

            }


            /*
             * 500+
             */
            else if (statusCode >= 500) {

                saveFailure(
                    app,
                    'Server Error: ' +
                    responseBody,
                    'Retry Required'
                );

            }


            /*
             * UNEXPECTED
             */
            else {

                saveFailure(
                    app,
                    'Unexpected Response ' +
                    statusCode +
                    ': ' +
                    responseBody,
                    'Failed'
                );
            }


        }
        catch (Exception e) {

            app.Integration_Status_c__c =
                'Failed';

            app.Last_Integration_Attempt__c =
                System.now();

            app.Integration_Error__c =
                'Callout Exception: ' +
                e.getMessage();

            update app;


            System.debug(
                '=== SPRINT 33 EXCEPTION ==='
            );

            System.debug(
                'Error: ' +
                e.getMessage()
            );
        }
    }


    /*
     * SAVE FAILURE
     */
    private void saveFailure(
        Application__c app,
        String errorMessage,
        String status
    ) {

        app.Integration_Status_c__c =
            status;

        app.Last_Integration_Attempt__c =
            System.now();

        app.Integration_Error__c =
            errorMessage;

        update app;


        System.debug(
            '=== SPRINT 33 FAILURE ==='
        );

        System.debug(
            'Integration Status: ' +
            status
        );

        System.debug(
            'Integration Error: ' +
            errorMessage
        );
    }
}
