public class CandidateSyncQueueable
    implements Queueable, Database.AllowsCallouts {

    private Id applicationId;
    private Boolean isRetry;


    // =========================================
    // CONSTRUCTOR
    // =========================================

    public CandidateSyncQueueable(Id applicationId) {

        this(applicationId, false);
    }


    // =========================================
    // RETRY CONSTRUCTOR
    // =========================================

    public CandidateSyncQueueable(
        Id applicationId,
        Boolean isRetry
    ) {

        this.applicationId = applicationId;
        this.isRetry = isRetry;
    }


    // =========================================
    // EXECUTE
    // =========================================

    public void execute(QueueableContext context) {

        Application__c application = [
            SELECT
                Id,
                Student__c,
                Job__c,
                Status__c,
                Application_ID__c,
                Selection_date__c,
                Integration_Status_c__c,
                External_Candidate_Id__c,
                Last_Integration_Attempt__c,
                Integration_Error__c

            FROM Application__c

            WHERE Id = :applicationId

            LIMIT 1
        ];


        // =========================================
        // CHECK APPLICATION STATUS
        // =========================================

        if (application.Status__c != 'Selected') {

            System.debug(
                'Application is not Selected. Sync skipped.'
            );

            return;
        }


        // =========================================
        // CHECK STUDENT LOOKUP
        // =========================================

        if (application.Student__c == null) {

            markFailed(
                application,
                'Student is not assigned to this Application.'
            );

            return;
        }


        // =========================================
        // CHECK JOB LOOKUP
        // =========================================

        if (application.Job__c == null) {

            markFailed(
                application,
                'Job is not assigned to this Application.'
            );

            return;
        }


        try {

            // =========================================
            // GET STUDENT SAFELY
            // =========================================

            List<Student__c> studentList = [

                SELECT
                    Id,
                    Email__c,
                    Branch__c,
                    CGPA__c

                FROM Student__c

                WHERE Id = :application.Student__c

                LIMIT 1
            ];


            if (studentList.isEmpty()) {

                markFailed(
                    application,
                    'Student record was not found for Student Id: '
                    + application.Student__c
                );

                return;
            }


            Student__c student =
                studentList[0];


            // =========================================
            // GET JOB SAFELY
            // =========================================

            List<Job__c> jobList = [

                SELECT
                    Id,
                    Name,
                    Company__c,
                    Job_Id__c,
                    Job_Status__c,
                    Role__c

                FROM Job__c

                WHERE Id = :application.Job__c

                LIMIT 1
            ];


            if (jobList.isEmpty()) {

                markFailed(
                    application,
                    'Job record was not found for Job Id: '
                    + application.Job__c
                );

                return;
            }


            Job__c job =
                jobList[0];


            // =========================================
            // BUILD CANDIDATE JSON
            // =========================================

            Map<String, Object> candidateData =
                new Map<String, Object>();


            candidateData.put(
                'applicationId',
                String.valueOf(application.Id)
            );


            candidateData.put(
                'studentId',
                String.valueOf(student.Id)
            );


            candidateData.put(
                'email',
                student.Email__c
            );


            candidateData.put(
                'branch',
                student.Branch__c
            );


            candidateData.put(
                'cgpa',
                student.CGPA__c
            );


            candidateData.put(
                'jobId',
                String.valueOf(job.Id)
            );


            candidateData.put(
                'company',
                job.Company__c
            );


            candidateData.put(
                'role',
                job.Role__c
            );


            // Use Application Selection Date
            if (application.Selection_date__c != null) {

                candidateData.put(
                    'selectionDate',
                    String.valueOf(
                        application.Selection_date__c
                    )
                );

            } else {

                candidateData.put(
                    'selectionDate',
                    String.valueOf(Date.today())
                );
            }


            // =========================================
            // CONVERT TO JSON
            // =========================================

            String requestBody =
                JSON.serialize(candidateData);


            System.debug(
                'Candidate Request: '
                + requestBody
            );


            // =========================================
            // HTTP REQUEST
            // =========================================

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


            request.setBody(requestBody);


            // =========================================
            // SEND API REQUEST
            // =========================================

            Http http =
                new Http();


            HttpResponse response =
                http.send(request);


            Integer statusCode =
                response.getStatusCode();


            String responseBody =
                response.getBody();


            System.debug(
                'HTTP Status: '
                + statusCode
            );


            System.debug(
                'HTTP Response: '
                + responseBody
            );


            // =========================================
            // SUCCESS
            // =========================================

            if (
                statusCode == 200 ||
                statusCode == 201 ||
                statusCode == 204
            ) {

                application.Integration_Status_c__c =
                    'Sent';


                application.Last_Integration_Attempt__c =
                    DateTime.now();


                application.Integration_Error__c =
                    null;


                // =====================================
                // READ EXTERNAL CANDIDATE ID
                // =====================================

                if (
                    String.isNotBlank(responseBody)
                ) {

                    try {

                        Map<String, Object> responseData =
                            (Map<String, Object>)
                            JSON.deserializeUntyped(
                                responseBody
                            );


                        if (
                            responseData.containsKey(
                                'externalCandidateId'
                            )
                        ) {

                            application.External_Candidate_Id__c =
                                String.valueOf(
                                    responseData.get(
                                        'externalCandidateId'
                                    )
                                );


                            System.debug(
                                'External Candidate Id: '
                                + application.External_Candidate_Id__c
                            );
                        }

                    } catch (Exception jsonError) {

                        System.debug(
                            'Could not parse API response: '
                            + jsonError.getMessage()
                        );
                    }
                }


                update application;


                System.debug(
                    'SUCCESS: Candidate synchronized.'
                );


                return;
            }


            // =========================================
            // CLIENT ERROR
            // =========================================

            if (
                statusCode == 400 ||
                statusCode == 401 ||
                statusCode == 403
            ) {

                application.Integration_Status_c__c =
                    'Failed';


                application.Last_Integration_Attempt__c =
                    DateTime.now();


                application.Integration_Error__c =
                    'HTTP '
                    + statusCode
                    + ': '
                    + responseBody;


                update application;

                return;
            }


            // =========================================
            // SERVER ERROR
            // =========================================

            if (
                statusCode >= 500 &&
                statusCode <= 599
            ) {

                handleRetry(
                    application,
                    'HTTP '
                    + statusCode
                    + ': '
                    + responseBody
                );

                return;
            }


            // =========================================
            // UNEXPECTED RESPONSE
            // =========================================

            markFailed(
                application,
                'Unexpected HTTP status '
                + statusCode
                + ': '
                + responseBody
            );

        }


        // =========================================
        // EXCEPTION
        // =========================================

        catch (Exception error) {

            handleRetry(
                application,
                'Integration Exception: '
                + error.getMessage()
            );
        }
    }


    // =========================================
    // MARK FAILED
    // =========================================

    private void markFailed(
        Application__c application,
        String errorMessage
    ) {

        application.Integration_Status_c__c =
            'Failed';

        application.Last_Integration_Attempt__c =
            DateTime.now();

        application.Integration_Error__c =
            errorMessage;

        update application;
    }


    // =========================================
    // RETRY HANDLER
    // =========================================

    private void handleRetry(
        Application__c application,
        String errorMessage
    ) {

        if (!isRetry) {

            application.Integration_Status_c__c =
                'Retry Required';

            application.Last_Integration_Attempt__c =
                DateTime.now();

            application.Integration_Error__c =
                errorMessage;

            update application;


            System.enqueueJob(
                new CandidateSyncQueueable(
                    application.Id,
                    true
                )
            );

            return;
        }


        application.Integration_Status_c__c =
            'Failed';

        application.Last_Integration_Attempt__c =
            DateTime.now();

        application.Integration_Error__c =
            'Retry failed: '
            + errorMessage;

        update application;
    }
}
