public class ApplicationService {

    // =========================================
    // VALIDATE APPLICATIONS
    // =========================================

    public static void validateApplications(
        List<Application__c> applications
    ) {

        Set<Id> studentIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();


        // =========================================
        // COLLECT STUDENT AND JOB IDS
        // =========================================

        for (Application__c app : applications) {

            if (app.Student__c != null) {
                studentIds.add(app.Student__c);
            }

            if (app.Job__c != null) {
                jobIds.add(app.Job__c);
            }

            // Set Application Date
            if (app.Application_Date__c == null) {

                app.Application_Date__c =
                    Date.today();
            }
        }


        // =========================================
        // GET STUDENTS
        // =========================================

        Map<Id, Student__c> students =
            new Map<Id, Student__c>([

                SELECT
                    Id,
                    CGPA__c,
                    Backlogs__c,
                    Branch__c

                FROM Student__c

                WHERE Id IN :studentIds
            ]);


        // =========================================
        // GET JOBS
        // =========================================

        Map<Id, Job__c> jobs =
            new Map<Id, Job__c>([

                SELECT
                    Id,
                    Name,
                    Company__c,
                    Job_Id__c,
                    Job_Status__c,
                    Last_Date__c,
                    Minimum_CGPA__c,
                    Package__c,
                    Role__c

                FROM Job__c

                WHERE Id IN :jobIds
            ]);


        // =========================================
        // VALIDATE EACH APPLICATION
        // =========================================

        for (Application__c app : applications) {

            Student__c student =
                students.get(app.Student__c);

            Job__c job =
                jobs.get(app.Job__c);


            // Skip if Student or Job is missing
            if (
                student == null ||
                job == null
            ) {
                continue;
            }


            // =========================================
            // CGPA VALIDATION
            // =========================================

            if (
                student.CGPA__c != null &&
                job.Minimum_CGPA__c != null &&
                student.CGPA__c <
                job.Minimum_CGPA__c
            ) {

                app.addError(
                    'Student CGPA is below the minimum requirement.'
                );
            }


            // =========================================
            // JOB DEADLINE VALIDATION
            // =========================================

            if (
                job.Last_Date__c != null &&
                job.Last_Date__c < Date.today()
            ) {

                app.addError(
                    'Applications for this job are now closed.'
                );
            }
        }
    }


    // =========================================
    // GET ELIGIBLE JOBS
    // =========================================

    public static List<Job__c> getEligibleJobs(
        Id studentId
    ) {

        // =========================================
        // VALIDATE STUDENT ID
        // =========================================

        if (studentId == null) {

            throw new AuraHandledException(
                'Student Id is required.'
            );
        }


        // =========================================
        // GET STUDENT
        // =========================================

        Student__c student = [

            SELECT
                Id,
                CGPA__c,
                Backlogs__c,
                Branch__c

            FROM Student__c

            WHERE Id = :studentId

            LIMIT 1
        ];


        // =========================================
        // GET OPEN JOBS
        // =========================================

        List<Job__c> jobs = [

            SELECT
                Id,
                Name,
                Company__c,
                Job_Id__c,
                Job_Status__c,
                Last_Date__c,
                Minimum_CGPA__c,
                Package__c,
                Role__c

            FROM Job__c
        ];


        List<Job__c> eligibleJobs =
            new List<Job__c>();


        // =========================================
        // CHECK EACH JOB
        // =========================================

        for (Job__c job : jobs) {


            // =====================================
            // JOB STATUS
            // =====================================

            if (
                job.Job_Status__c != null &&
                job.Job_Status__c != 'Open'
            ) {
                continue;
            }


            // =====================================
            // CGPA
            // =====================================

            if (
                student.CGPA__c != null &&
                job.Minimum_CGPA__c != null &&
                student.CGPA__c <
                job.Minimum_CGPA__c
            ) {

                continue;
            }


            // =====================================
            // LAST DATE
            // =====================================

            if (
                job.Last_Date__c != null &&
                job.Last_Date__c < Date.today()
            ) {

                continue;
            }


            // =====================================
            // ELIGIBLE JOB
            // =====================================

            eligibleJobs.add(job);
        }


        return eligibleJobs;
    }


    // =========================================
    // SUBMIT APPLICATION
    // =========================================
    // Sprint 24
    // =========================================

    public static Id submitApplication(
        Id studentId,
        Id jobId
    ) {

        // =========================================
        // VALIDATE INPUT
        // =========================================

        if (
            studentId == null ||
            jobId == null
        ) {

            throw new AuraHandledException(
                'Student and Job are required.'
            );
        }


        // =========================================
        // GET STUDENT
        // =========================================

        Student__c student = [

            SELECT
                Id

            FROM Student__c

            WHERE Id = :studentId

            LIMIT 1
        ];


        // =========================================
        // GET JOB
        // =========================================

        Job__c job = [

            SELECT
                Id,
                Job_Status__c,
                Last_Date__c

            FROM Job__c

            WHERE Id = :jobId

            LIMIT 1
        ];


        // =========================================
        // CHECK JOB STATUS
        // =========================================

        if (
            job.Job_Status__c != null &&
            job.Job_Status__c != 'Open'
        ) {

            throw new AuraHandledException(
                'This job is not currently open for applications.'
            );
        }


        // =========================================
        // CHECK LAST DATE
        // =========================================

        if (
            job.Last_Date__c != null &&
            job.Last_Date__c < Date.today()
        ) {

            throw new AuraHandledException(
                'Applications for this job are now closed.'
            );
        }


        // =========================================
        // CHECK DUPLICATE APPLICATION
        // =========================================

        List<Application__c>
            existingApplications = [

                SELECT
                    Id

                FROM Application__c

                WHERE Student__c = :studentId

                AND Job__c = :jobId

                LIMIT 1
            ];


        if (
            !existingApplications.isEmpty()
        ) {

            throw new AuraHandledException(
                'You have already applied for this opportunity.'
            );
        }


        // =========================================
        // CREATE APPLICATION
        // =========================================

        Application__c application =
            new Application__c();


        application.Student__c =
            student.Id;


        application.Job__c =
            job.Id;


        application.Application_Date__c =
            Date.today();


        // Initial Application Status
        application.Status__c =
            'Applied';


        // Integration Status
        application.Integration_Status_c__c =
            'Pending';


        // =========================================
        // INSERT APPLICATION
        // =========================================

        insert application;


        return application.Id;
    }
}
