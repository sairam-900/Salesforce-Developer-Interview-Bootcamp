Sprint 23 – Eligible Jobs LWC

📌 Overview

Sprint 23 focuses on building the Eligible Jobs Lightning Web Component (LWC) for the Student Placement Portal.

The implementation was completed incrementally through six tasks, starting with a basic LWC screen and progressing to dynamic job display and Salesforce data integration.

🎯 Sprint Objective

Build an Eligible Jobs LWC that allows students to view placement opportunities with important information such as:

Company

Job Title

Job ID

Role

Package

Location

Minimum CGPA

Job Status

Last Date

View Details action

Development Flow

Task 1
   ↓
Create LWC
   ↓
Task 2
   ↓
Display One Job
   ↓
Task 3
   ↓
JavaScript Data Binding
   ↓
Task 4
   ↓
Display Multiple Jobs
   ↓
Task 5
   ↓
Retrieve Real Salesforce Data
   ↓
Task 6
   ↓
Eligible Jobs Display

🛠️ Task 1 – Create the Eligible Jobs LWC

Objective

Create the initial eligibleJobs Lightning Web Component and verify that it is displayed successfully in Salesforce.

Work Done

Created the LWC files:

eligibleJobs/
├── eligibleJobs.html
├── eligibleJobs.js
└── eligibleJobs.js-meta.xml

Output

The initial component displayed the following screen:

Eligible Jobs

Your eligible opportunities will appear here.

📸 Task 1 Output

![Task 1 Output](screenshots/Task-1.png)



Result

✅ LWC created successfully✅ Component deployed successfully✅ Component displayed in Salesforce

🛠️ Task 2 – Display One Hard-Coded Job

Objective

Display one job using hard-coded values and verify the job-card UI.

Job Displayed

Microsoft

Software Engineer
Package: 12 LPA
Location: Hyderabad
Deadline: 18 August

[ View Details ]

Output

The Microsoft job was displayed successfully as a job card.

📸 Task 2 Output



![Task 1 Output](screenshots/Task-2.png)

Result

✅ One job card displayed✅ Company information displayed✅ Role displayed✅ Package displayed✅ Location displayed✅ Deadline displayed✅ View Details button displayed

🛠️ Task 3 – JavaScript Data Binding

Objective

Move job information into JavaScript properties and display those values dynamically in the HTML using LWC data binding.

Concept

JavaScript Properties
        ↓
HTML Data Binding
        ↓
Lightning Web Component UI

Example JavaScript properties:

companyName = 'Microsoft';
jobRole = 'Software Engineer';
packageOffered = '12 LPA';
location = 'Hyderabad';
deadline = '18 August';

Example HTML binding:

{companyName}
{jobRole}
{packageOffered}
{location}
{deadline}

Output

The Microsoft job information was rendered through JavaScript data binding.

Microsoft

Software Engineer
Package: 12 LPA
Location: Hyderabad
Deadline: 18 August

[ View Details ]

📸 Task 3 Output



![Task 1 Output](screenshots/Task-3.png)

Result

✅ JavaScript properties created✅ HTML data binding implemented✅ Dynamic job information displayed

🛠️ Task 4 – Display Multiple Jobs

Objective

Extend the component to display multiple job records instead of a single job.

Jobs Displayed

Job 1

Microsoft

Software Engineer
Package: 12 LPA
Location: Hyderabad
Deadline: 18 August

[ View Details ]

Job 2

Salesforce Partner

Associate Developer
Package: 7 LPA
Location: Bengaluru
Deadline: 21 August

[ View Details ]

Concept Used

Jobs were represented as an array and rendered using LWC iteration.

jobs = [
    {
        companyName: 'Microsoft',
        jobRole: 'Software Engineer',
        packageOffered: '12 LPA',
        location: 'Hyderabad',
        deadline: '18 August'
    },
    {
        companyName: 'Salesforce Partner',
        jobRole: 'Associate Developer',
        packageOffered: '7 LPA',
        location: 'Bengaluru',
        deadline: '21 August'
    }
];

HTML iteration:

<template for:each={jobs} for:item="job">

Output

Multiple job cards were displayed successfully.

📸 Task 4 Output



![Task 1 Output](screenshots/Task-4.png)

Result

✅ Multiple jobs displayed✅ for:each used✅ Job cards rendered dynamically✅ Each job displayed independently

🛠️ Task 5 – Retrieve Real Salesforce Data

Objective

Replace hard-coded job information with actual records stored in Salesforce.

Data Flow

LWC
 ↓
@wire
 ↓
EligibleJobsController
 ↓
SOQL
 ↓
Job__c
 ↓
Salesforce Records
 ↓
LWC

Salesforce Object

The component retrieves records from:

Job__c

Important fields used include:

Name
Job_id__c
Job_Status__c
Last_Date__c
Minimum_CGPA__c
Package__c
Role__c
Company__c

Output

The LWC successfully displayed real Salesforce Job records.

The screenshot shows records including:

Salesforce
java
Salesforce
Sai Solutions

with job information retrieved from Salesforce.

📸 Task 5 Output



![Task 1 Output](screenshots/Task-5.png)

Result

✅ Real Salesforce records retrieved✅ Apex connected with LWC✅ SOQL used for data retrieval✅ Multiple Job__c records displayed

🛠️ Task 6 – Eligible Jobs Display

Objective

Connect the job display with the eligibility-oriented flow so that the LWC represents jobs relevant to the student's eligibility.

Flow

Student Information
        ↓
Eligibility Logic
        ↓
Eligible Job Records
        ↓
Apex
        ↓
@wire
        ↓
eligibleJobs LWC
        ↓
Student

Output

The final component displayed multiple job records in the Eligible Jobs section.

The output includes job records such as:

Salesforce

Job Title: Software Engineer
Job ID: ...
Role: developer
Package: ...
Location: ...
Minimum CGPA: ...
Status: ...
Last Date: ...

[ View Details ]

Other records were also displayed in the final component.

📸 Task 6 Output



![Task 1 Output](screenshots/Task-6.png)

Result

✅ Eligible Jobs component displayed successfully✅ Multiple job records displayed✅ Job information rendered in the LWC✅ Final Salesforce UI verified

📊 Sprint 23 Task Summary

Task

Main Work

Output

Task 1

Create LWC

Initial Eligible Jobs screen

Task 2

Display one hard-coded job

Microsoft job card

Task 3

JavaScript data binding

Dynamic Microsoft job card

Task 4

Display multiple jobs

Microsoft + Salesforce Partner

Task 5

Retrieve Salesforce data

Real Job__c records

Task 6

Eligible Jobs display

Multiple Salesforce job records

🔄 Complete Architecture

Student
   ↓
Eligible Jobs LWC
   ↓
eligibleJobs.js
   ↓
@wire
   ↓
EligibleJobsController
   ↓
Eligibility / Service Layer
   ↓
SOQL
   ↓
Job__c
   ↓
Salesforce Data
   ↓
Eligible Jobs
   ↓
eligibleJobs.html
   ↓
Student UI

🧩 Technologies Used

Salesforce

Lightning Web Components (LWC)

HTML

JavaScript

Apex

SOQL

Salesforce CLI

VS Code

Salesforce Developer Edition

🐛 Challenges Faced

1. Salesforce Field API Name Error

An initial query used:

Location__c

Salesforce returned:

No such column 'Location__c' on entity 'Job__c'

Solution

The actual Job__c fields were checked in Salesforce Object Manager and the SOQL query was updated to use only fields that existed in the org.

Learning

Salesforce field labels and API names must be checked carefully before using them in Apex/SOQL.

2. Apex Controller Deployment Dependency

The LWC initially reported:

Unable to find Apex action class referenced as
'EligibleJobsController'

Solution

The Apex controller was deployed first and verified in the target org before deploying the LWC.

Apex Controller
      ↓
Deploy
      ↓
Verify
      ↓
Deploy LWC

Learning

LWC components that import Apex methods depend on the Apex class being available and successfully deployed.

3. Empty Eligibility Result

At one point the component displayed:

No eligible jobs available.

Learning

A component can be working correctly while the returned Salesforce data is empty.

This helped distinguish between:

UI Problem

and:

Data / Query / Eligibility Problem

4. Moving from Hard-Coded Data to Salesforce Data

The project started with static job information and progressively moved to Salesforce data.

Hard-Coded Data
      ↓
JavaScript Properties
      ↓
Multiple Job Array
      ↓
Apex
      ↓
SOQL
      ↓
Job__c

This provided practical understanding of the frontend-to-backend data flow.

💡 Reflections

Reflection 1 – LWC Is More Than HTML

I learned that a Lightning Web Component combines:

HTML
+
JavaScript
+
Salesforce Data
+
Apex

Each part has a different responsibility.

Reflection 2 – Understanding Data Flow

I learned to trace data from the Salesforce database to the user interface:

Salesforce Database
        ↓
SOQL
        ↓
Apex
        ↓
@wire
        ↓
JavaScript
        ↓
HTML
        ↓
User

This makes debugging much easier.

Reflection 3 – Incremental Development

Building the feature task by task made the implementation easier to understand.

Simple UI
   ↓
One Job
   ↓
Data Binding
   ↓
Multiple Jobs
   ↓
Real Salesforce Data
   ↓
Eligibility-Oriented Display

Each stage was verified before moving to the next stage.

Reflection 4 – Business Logic Separation

I learned that business/eligibility rules should not unnecessarily be duplicated inside the UI.

A better architecture is:

LWC
 ↓
Apex Controller
 ↓
Service / Business Logic
 ↓
Salesforce Data

🎯 Interview Preparation

Sprint 23 helped prepare me for Salesforce Developer interview questions.

What is LWC?

Lightning Web Components is Salesforce's framework for building reusable user interfaces using standard web technologies such as HTML and JavaScript.

What is @wire?

@wire provides a reactive way for an LWC to receive data from Salesforce or invoke an Apex method.

Example:

@wire(getEligibleJobs)
wiredJobs({ data, error }) {
    // Handle response
}

Why use Apex with LWC?

Apex is used when server-side processing, SOQL, custom business logic, or complex data operations are required.

How do you display multiple records?

Using an array and the LWC for:each directive:

<template for:each={jobs} for:item="job">

What is SOQL?

SOQL (Salesforce Object Query Language) is used to retrieve records and fields from Salesforce objects.

How does LWC communicate with Apex?

LWC
 ↓
Apex Method
 ↓
SOQL / Business Logic
 ↓
Salesforce
 ↓
Apex Response
 ↓
LWC

🎓 Interview Preparation Outcome

After completing Sprint 23, I can explain the complete flow:

User
 ↓
Lightning Web Component
 ↓
JavaScript
 ↓
@wire
 ↓
Apex Controller
 ↓
Service / Business Logic
 ↓
SOQL
 ↓
Job__c
 ↓
Salesforce Database
 ↓
Response
 ↓
LWC
 ↓
User

I can also explain the responsibility of each layer:

HTML
→ Presentation

JavaScript
→ Component behaviour

@wire
→ Reactive data communication

Apex
→ Server-side logic

SOQL
→ Salesforce data retrieval

Service Layer
→ Business rules

Salesforce Objects
→ Data storage

🏆 Sprint 23 Final Outcome

Sprint 23 established the Eligible Jobs feature of the Student Placement Portal.

The implementation progressed from a basic LWC screen to a Salesforce-connected job listing.

Task 1 → Create LWC
   ↓
Task 2 → One Job
   ↓
Task 3 → Data Binding
   ↓
Task 4 → Multiple Jobs
   ↓
Task 5 → Real Salesforce Data
   ↓
Task 6 → Eligible Jobs Display
   ↓
Sprint 23 Completed ✅

The sprint provided practical experience in:

LWC development

HTML templates

JavaScript data binding

@wire

Apex

SOQL

Salesforce custom objects

Salesforce field API names

Apex-LWC communication

Business logic separation

Salesforce CLI deployment

Debugging deployment issues
