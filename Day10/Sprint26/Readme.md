Sprint 27 -- Job Details and Apply Communication

Sprint Overview

Sprint 27 focuses on extending the Eligible Jobs Lightning Web Componentwith working View Details and Apply actions using parent-childcomponent communication.

The parent component eligibleJobs is responsible for retrieving jobs,maintaining state, and coordinating actions, while the child componentjobCard is responsible for displaying an individual job and sendinguser actions to the parent through Custom Events.

Component Structure

eligibleJobs
    |
    └── jobCard

This structure keeps the UI reusable and maintains clear componentresponsibilities.

Sprint Objective

The objectives of Sprint 27 are:

Maintain the parent eligibleJobs component.

Maintain the child jobCard component.

Pass Job information from parent to child using @api.

Implement a working View Details button.

Send the selected Job Id from child to parent.

Display the selected Job Id.

Implement a working Apply button.

Send Apply events from child to parent.

Display a success notification after Apply.

Avoid unnecessary duplicate data retrieval.

Keep business logic outside the UI components.

Verify the complete user interaction flow.

Business Problem

The Eligible Jobs page contains individual Job Cards with actions such as:

View Details

Apply

The buttons are inside the child jobCard component, but the parenteligibleJobs component needs to know which Job the student selected.

The solution is to use Custom Events.

Student
   ↓
jobCard
   ↓
Custom Event
   ↓
eligibleJobs
   ↓
Parent handles the action

Component Architecture

Parent Component -- eligibleJobs

The eligibleJobs component is responsible for:

Retrieving eligible jobs

Maintaining the jobs list

Passing jobs to jobCard

Receiving View Details events

Receiving Apply events

Maintaining the selected Job Id

Displaying Job Id

Displaying success feedback

Child Component -- jobCard

The jobCard component is responsible for:

Displaying one job

Presenting Job information

Showing the View Details button

Showing the Apply button

Capturing user interaction

Communicating events to the parent

Project Structure

force-app/
└── main/
    └── default/
        ├── classes/
        │   ├── JobController.cls
        │   └── JobController.cls-meta.xml
        │
        └── lwc/
            ├── eligibleJobs/
            │   ├── eligibleJobs.html
            │   ├── eligibleJobs.js
            │   └── eligibleJobs.js-meta.xml
            │
            └── jobCard/
                ├── jobCard.html
                ├── jobCard.js
                └── jobCard.js-meta.xml

Data Flow

Salesforce Database
       ↓
JobController
       ↓
SOQL
       ↓
@wire
       ↓
eligibleJobs
       ↓
job={job}
       ↓
jobCard
       ↓
Job Information Displayed

The parent retrieves the Job records and passes individual Job recordsto the child.

The child does not independently retrieve the same Job information.

Component Communication

Parent → Child

The parent passes Job information to the child using @api.

@api job;

The parent uses:

<c-job-card
    job={job}
    onviewdetails={handleViewDetails}
    onapply={handleApply}>
</c-job-card>

Child → Parent -- View Details

When View Details is clicked, the child dispatches a Custom Event.

handleViewDetails() {

    this.dispatchEvent(
        new CustomEvent('viewdetails', {
            detail: {
                jobId: this.job.Id
            }
        })
    );

}

The parent receives the event through:

onviewdetails={handleViewDetails}

Child → Parent -- Apply

When Apply is clicked, the child dispatches another Custom Event.

handleApply() {

    this.dispatchEvent(
        new CustomEvent('apply', {
            detail: {
                jobId: this.job.Id
            }
        })
    );

}

The parent receives the event through:

onapply={handleApply}

Communication Flow

Student
   ↓
View Details / Apply
   ↓
jobCard
   ↓
Custom Event
   ↓
eligibleJobs
   ↓
handleViewDetails() / handleApply()
   ↓
Job Id / User Feedback

User Interaction Flow

Student opens Placement Portal
          ↓
Eligible Jobs component loads
          ↓
Apex retrieves jobs
          ↓
eligibleJobs receives jobs
          ↓
Jobs are passed to jobCard
          ↓
Job Cards are displayed
          ↓
Student clicks View Details
          ↓
jobCard dispatches View Details event
          ↓
eligibleJobs receives Job Id
          ↓
Selected Job Id is displayed

Apply flow:

Student clicks Apply
          ↓
jobCard dispatches Apply event
          ↓
eligibleJobs receives event
          ↓
Job Id is received
          ↓
Success notification is displayed

Engineering Decisions

1. Parent and Child Separation

The Eligible Jobs interface is divided into:

eligibleJobs
     ↓
jobCard

eligibleJobs manages overall state and coordination.

jobCard focuses on displaying and interacting with one Job.

2. Parent-to-Child Data Flow

The parent retrieves the jobs and passes each Job to the child.

<c-job-card job={job}>
</c-job-card>

This gives the parent clear ownership of retrieved data.

3. Child-to-Parent Custom Events

The View Details and Apply buttons exist inside jobCard.

The child does not directly modify the parent's internal state.

Instead:

jobCard
   ↓
Custom Event
   ↓
eligibleJobs

The parent receives the event and decides what action should be taken.

4. Job Id as Event Data

Only the required Job Id is passed through the event.

detail: {
    jobId: this.job.Id
}

This keeps the event payload simple and focused.

5. Business Logic Outside the UI

Business rules should not be duplicated inside JavaScript.

The LWC communicates the user's intention while the Apex/service layerremains responsible for business rules and validation.

Testing

Test Case 1 -- Jobs Display

Expected Result: Eligible jobs should be retrieved and displayed asseparate Job Cards.

Result: PASS

Test Case 2 -- Parent to Child Data

Expected Result: Each Job record should be passed fromeligibleJobs to jobCard.

Result: PASS

Test Case 3 -- View Details Event

Expected Result: Clicking View Details should generate aviewdetails event from jobCard to eligibleJobs.

Result: PASS

Test Case 4 -- View Details Job Id

Expected Result: The parent should receive and display the selectedJob Id.

Result: PASS

Test Case 5 -- Apply Event

Expected Result: Clicking Apply should generate an apply event fromjobCard to eligibleJobs.

Result: PASS

Test Case 6 -- Apply Notification

Expected Result: The parent should display a success notificationcontaining the selected Job Id.

Result: PASS

Test Case 7 -- Empty Jobs

Expected Result:

No eligible jobs available.

Result: PASS

Test Case 8 -- Error State

Expected Result: If Job retrieval fails, the component shoulddisplay an appropriate error message.

Result: PASS

Outputs / Screenshots

Dashboard Output

The dashboard screenshot demonstrates the Eligible Jobs interface andJob Card component structure.



View Details Success Output

![Success Output](Screenshots/Successful.png)


Apply Success Output

![ViewDetails Output](Screenshots/ViewDetails.png)



Challenges Faced

Challenge 1 -- Parent and Child Communication

The buttons are inside jobCard, but the parent needs to know when thestudent clicks them.

Solution: Custom Events were implemented.

jobCard
   ↓
Custom Event
   ↓
eligibleJobs

Challenge 2 -- Sending the Correct Job Id

The parent needs to know which Job the student selected.

Solution: The Job Id is passed through the event detail.

detail: {
    jobId: this.job.Id
}

Challenge 3 -- View Details Result

The View Details action needed to produce a visible result instead ofonly a console message.

Solution: The parent stores and displays the selected Job Id.

Challenge 4 -- Apply User Feedback

The Apply event needed visible feedback for the student.

Solution: The parent displays a success notification after receivingthe Apply event.

Reflections

Reflection 1 -- Component Design

This sprint demonstrated that a component can work correctly while stillrequiring clear communication architecture.

Breaking responsibilities between parent and child improvesmaintainability.

Reflection 2 -- Component Communication

The important communication pattern learned was:

Parent → Child
Data

Child → Parent
Event

Reflection 3 -- Custom Events

Custom Events allow a child component to communicate user intent withoutdirectly modifying the parent component's state.

Reflection 4 -- Data Ownership

The parent owns the retrieved Job data and passes it to child components.

This avoids unnecessary duplicate data retrieval.

Reflection 5 -- User Feedback

User actions should produce clear feedback.

View Details → Job Id displayed
Apply        → Success notification

Outcomes

After completing Sprint 27:

A reusable jobCard component is maintained.

eligibleJobs remains the parent component.

Job data flows from parent to child.

View Details actions flow from child to parent.

Apply actions flow from child to parent.

Custom Events are implemented.

Job Id is transferred through event.detail.

View Details displays the selected Job Id.

Apply displays a success notification.

Duplicate data retrieval is avoided.

Component responsibilities remain clear.

The Eligible Jobs workflow is easier to understand and maintain.

Before vs After

Before

eligibleJobs
│
├── Job Retrieval
├── Job Display
├── Job Details
├── Apply Button
└── User Interaction

After

eligibleJobs
│
├── Job Retrieval
├── Overall State
├── View Details Handling
└── Apply Coordination
        │
        ↓
     jobCard
        │
        ├── Job Display
        ├── View Details
        └── Apply

Deployment

Deploy Complete Salesforce Source

sf project deploy start --source-dir force-app/main/default

Check Deployment Status

sf project deploy report

Open Salesforce Org

sf org open

Lightning App Builder

The eligibleJobs component is exposed to Lightning App Builder.

Setup
   ↓
Lightning App Builder
   ↓
Open/Create App Page
   ↓
Find "Eligible Jobs"
   ↓
Drag component onto page
   ↓
Save
   ↓
Activate

The jobCard component is a child component and is not added separatelyto Lightning App Builder.

GitHub Evidence

The repository contains the Sprint 27 implementation and output evidence.

Sprint-27/
│
├── README.md
│
├── force-app/
│
└── Screenshots/
    ├── dashboard.png
    ├── success.png
    ├── apply-success.png
    └── failure.png

Screenshot Evidence

Screenshot

Purpose

Screenshots/dashboard.png

Eligible Jobs dashboard

Screenshots/success.png

View Details and Job Id

Screenshots/apply-success.png

Apply success notification

Screenshots/failure.png

Failure/error interaction

Sprint 27 Learning Summary

Sprint 27 demonstrated how a Lightning Web Component can use parent-childcommunication to handle Job Card actions.

The final architecture is:

                 STUDENT
                    ↓
              eligibleJobs
             ↙           ↘
       Job Data          Events
          ↓                ↑
       jobCard ────────────┘
          ↓
   ┌──────┴──────┐
   ↓             ↓
View Details    Apply
   ↓             ↓
Job Id        Notification

The main learning from this sprint is that the child component shouldcommunicate user intent through events while the parent coordinates theresulting behavior.

Sprint 27 Definition of Done

Parent responsibility is clear

Child responsibility is clear

Data flows from parent to child

@api is used for parent-to-child data

View Details event is implemented

Apply event is implemented

Events communicate from child to parent

Job Id is passed through event.detail

View Details displays Job Id

Apply displays success notification

Child does not directly modify parent state

Business logic remains outside the UI

Complete source can be deployed

Eligible Jobs can be displayed in Lightning App Builder

Dashboard output captured

Success output captured

Apply success output captured

Failure output captured

Challenges documented

Reflections documented

Outcomes documented

Final Status

Sprint 27 -- COMPLETED ✅

The Eligible Jobs interface now supports working View Details and Applyactions using controlled parent-child Lightning Web Componentcommunication.

The final workflow is:

Job Records
     ↓
eligibleJobs
     ↓
jobCard
     ↓
┌───────────────────────┐
│ [ View Details ]      │
│ [ Apply ]             │
└───────────────────────┘
     ↓
Custom Event
     ↓
eligibleJobs
     ↓
View Details → Job ID
Apply        → Success Notification
