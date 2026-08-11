Sprint 30 — Student Profile & Eligible Jobs

1. Sprint Overview

Sprint 30 implements the Student Profile and Eligible Jobs flow for the Student Placement Portal.

The user enters the student profile information first. After clicking Save Profile, the system checks the student's CGPA against the eligibility criteria of the available jobs.

The application supports two main outcomes:

Eligible jobs are displayed when the student's CGPA satisfies the job criteria.

No Eligible Jobs is displayed when the student's CGPA does not satisfy any available job criteria.

2. Objectives

Create a Student Profile form.

Capture Student Name.

Capture Student CGPA.

Capture Skills.

Capture Preferred Location.

Capture Graduation Year.

Capture Backlogs.

Save the student profile.

Check job eligibility using CGPA.

Display all matching eligible jobs.

Display a reusable empty state when no jobs match.

Support View Details and Apply actions for eligible jobs.

Maintain parent-child communication between eligibleJobs and jobCard.

3. Student Profile Fields

The Student Profile contains:

Field

Purpose

Student Name

Identifies the student

Student CGPA

Used for job eligibility

Skills

Stores the student's skills

Preferred Location

Stores the student's preferred location

Graduation Year

Stores graduation information

Backlogs

Stores the number of backlogs

Example:

Student Name: Leela Sai Ram
Student CGPA: 8.50
Skills: HTML CSS JAVA
Preferred Location: Bengaluru
Graduation Year: 2027
Backlogs: 0

4. Eligibility Logic

The main eligibility condition is:

WHERE Minimum_CGPA__c <= :studentCGPA

Example — Eligible

Student CGPA = 8.50

Job A Minimum CGPA = 7.50
Job B Minimum CGPA = 8.00
Job C Minimum CGPA = 8.50

All three jobs can be displayed because the student's CGPA satisfies their minimum CGPA requirement.

Example — No Eligible Jobs

Student CGPA = 7.00

Job A Minimum CGPA = 8.00
Job B Minimum CGPA = 8.50
Job C Minimum CGPA = 9.00

No job satisfies the condition, so the UI displays:

No Eligible Jobs

No eligible opportunities are available for your current eligibility criteria.

5. Application Flow

Student Profile
       |
       v
Enter Student Details
       |
       v
Save Profile
       |
       v
Read Student CGPA
       |
       v
Job Eligibility Check
       |
       +----------------------+
       |                      |
       v                      v
Eligible Jobs             No Matching Jobs
       |                      |
       v                      v
Display Job Cards        No Eligible Jobs
       |
       +----------------+
       |                |
       v                v
View Details          Apply
       |                |
       v                v
Show Job ID          Success Message

6. Component Structure

eligibleJobs
│
├── Student Profile Form
│
├── Eligible Jobs
│     │
│     └── jobCard
│           ├── View Details
│           └── Apply
│
└── Empty State
      └── No Eligible Jobs

7. LWC Communication

Parent → Child

eligibleJobs passes the selected job to jobCard:

<c-job-card
    key={job.Id}
    job={job}
    onviewdetails={handleViewDetails}
    onapply={handleApply}>
</c-job-card>

Child → Parent

jobCard sends the Job Id through Custom Events:

this.dispatchEvent(
    new CustomEvent('viewdetails', {
        detail: {
            jobId: this.job.Id
        }
    })
);

For Apply:

this.dispatchEvent(
    new CustomEvent('apply', {
        detail: {
            jobId: this.job.Id
        }
    })
);

8. Eligible Jobs Output

When the student's CGPA matches the job criteria, the Eligible Jobs section displays the available job cards.

Each job card contains information such as:

Job Name
Job ID
Company
Role
Package
Minimum CGPA
Status
Last Date

The card provides:

[ View Details ]    [ Apply ]

9. No Eligible Jobs Output

When the student's CGPA does not match any job's eligibility criteria, the page displays:

Eligible Jobs

        No Eligible Jobs

No eligible opportunities are available
for your current eligibility criteria.

This prevents non-eligible jobs from being displayed.

10. Output Screenshots

Available Eligible Jobs

The first screenshot demonstrates the Student Profile with CGPA 8.50 and the Eligible Jobs section displaying a matching job.



No Eligible Jobs

The second screenshot demonstrates the Student Profile with CGPA 7.00 and the Eligible Jobs section displaying the empty state because no job matches the eligibility criteria.



11. Files

force-app/
└── main/
    └── default/
        ├── classes/
        │   └── JobController.cls
        │
        └── lwc/
            ├── eligibleJobs/
            │   ├── eligibleJobs.html
            │   ├── eligibleJobs.js
            │   └── eligibleJobs.js-meta.xml
            │
            ├── jobCard/
            │   ├── jobCard.html
            │   ├── jobCard.js
            │   └── jobCard.js-meta.xml
            │
            └── emptyState/
                ├── emptyState.html
                ├── emptyState.js
                └── emptyState.js-meta.xml

12. Deployment

Deploy the complete Salesforce source:

sf project deploy start --source-dir force-app/main/default

Check deployment status:

sf project deploy report

Open the Salesforce org:

sf org open

After deployment, refresh the Salesforce page using:

Ctrl + Shift + R

13. Testing

Test Case 1 — Eligible Jobs

Input:

Student CGPA: 8.50

Expected Result:

Eligible jobs are displayed.

Test Case 2 — No Eligible Jobs

Input:

Student CGPA: 7.00

If all available jobs require a CGPA greater than 7.00:

Expected Result:

No Eligible Jobs

Test Case 3 — View Details

Click:

View Details

Expected Result:

Job Details
Job ID: <selected Job Id>

Test Case 4 — Apply

Click:

Apply

Expected Result:

Application submitted successfully.

14. Definition of Done

Student Profile form created.

Student Name added.

Student CGPA added.

Skills added.

Preferred Location added.

Graduation Year added.

Backlogs added.

Save Profile functionality implemented.

CGPA-based eligibility implemented.

Eligible jobs displayed.

No Eligible Jobs empty state displayed.

Job Card component used.

View Details event implemented.

Apply event implemented.

Job ID passed through Custom Event.

Success notification implemented.

Output screenshots captured.

Deployment verified.

15. Sprint 30 Final Outcome

Sprint 30 provides a complete flow from:

Student Profile
       ↓
Save Profile
       ↓
Eligibility Check
       ↓
┌──────────────────┴──────────────────┐
↓                                     ↓
Eligible Jobs                     No Eligible Jobs
↓
Job Cards
↓
View Details / Apply

The result is a cleaner Student Placement Portal where only jobs matching the student's eligibility criteria are displayed.

## 10. Output Screenshots

### Available Eligible Jobs

The first screenshot demonstrates the Student Profile with CGPA **8.50** and the Eligible Jobs section displaying a matching job.

![Available Eligible Jobs](Screenshots/Availabilityofjobs.png)

### No Eligible Jobs

The second screenshot demonstrates the Student Profile with CGPA **7.00** and the Eligible Jobs section displaying the empty state because no job matches the eligibility criteria.

![No Eligible Jobs](Screenshots/NoAvailableofjobs.png)
