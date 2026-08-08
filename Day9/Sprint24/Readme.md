# Sprint 24 – Interactive Eligible Jobs LWC (The Apply Workflow)[cite: 1]

## 📌 Overview

Sprint 24 focuses on building the interactive Apply workflow for the Eligible Jobs Lightning Web Component (LWC) in the Student Placement Portal[cite: 1]. 

The implementation was completed incrementally through six tasks, starting with event handling and progressing to imperative Apex integration, state management, parent-child component refactoring, and real-time UI data refresh[cite: 1].

---

## 🎯 Sprint Objective

Build an interactive Apply workflow that allows students to apply for placement opportunities directly from the portal with important features such as[cite: 1]:

* Apply Action Button[cite: 1]
* Imperative Apex Execution[cite: 1]
* UI Processing States & Spinners[cite: 1]
* Prevention of Duplicate Submissions[cite: 1]
* Parent-Child Component Hierarchy (`eligibleJobs` & `jobCard`)[cite: 1]
* Clear Success and Error Handling[cite: 1]

---

## 🔄 Development Flow
Task 1
  ↓
Apply Button & Event
  ↓
Task 2
  ↓
Imperative Apex Integration
  ↓
Task 3
  ↓
UI States & Double-Click Protection
  ↓
Task 4
  ↓
Parent-Child Refactoring (jobCard)
  ↓
Task 5
  ↓
Error Handling & Validation Feedback
  ↓
Task 6
  ↓
Real-Time Data Refresh & Final Workflow
```[cite: 1]

---

## 🛠️ Task 1 – Implement the Apply Button & Event Handler

### Objective
Create the initial Apply button in the LWC and pass the contextual `jobId` from HTML to JavaScript using data attributes[cite: 1].

### Work Done
* Added `<lightning-button>` to the job card HTML[cite: 1].
* Configured `data-job-id` binding[cite: 1].
* Implemented `handleApply` in JavaScript[cite: 1].

```html
<lightning-button
    label="Apply"
    data-job-id={job.Id}
    onclick={handleApply}>
</lightning-button>
```[cite: 1]

```javascript
handleApply(event) {
    const jobId = event.target.dataset.jobId;
    console.log('Selected Job ID:', jobId);
}
```[cite: 1]

### Output
The job card rendered the new Apply action button, and clicking it captured the exact Job ID in JavaScript[cite: 1].

![Task 1 Output](Screenshots/Task-1.png)

### Result
* ✅ Apply button displayed on job card[cite: 1]
* ✅ Click event successfully captured[cite: 1]
* ✅ Job ID correctly extracted via dataset[cite: 1]

---

## 🛠️ Task 2 – Imperative Apex Integration

### Objective
Call the server-side Apex application service imperatively when the user clicks the Apply button[cite: 1].

### Concept
```text
User Click → LWC Event Handler → Imperative Apex Call → ApplicationService → Database
```[cite: 1]

```javascript
import submitApplication from '@salesforce/apex/ApplicationController.submitApplication';

async handleApply(event) {
    const jobId = event.target.dataset.jobId;
    try {
        const applicationId = await submitApplication({ jobId: jobId });
        console.log('Application Created:', applicationId);
    } catch (error) {
        console.error('Submission Error:', error);
    }
}
```[cite: 1]

### Output
Clicking Apply triggered the server call and successfully created an `Application__c` record in Salesforce[cite: 1].

![Task 2 Output](Screenshots/Task-2.png)

### Result
* ✅ Imperative Apex method connected[cite: 1]
* ✅ Backend service invoked on user action[cite: 1]
* ✅ Salesforce record created on click[cite: 1]

---

## 🛠️ Task 3 – UI States & Double-Click Protection

### Objective
Prevent duplicate application requests by disabling the Apply button and displaying loading indicators during request execution[cite: 1].

### States Implemented
* **Ready:** Button active `[ APPLY ]`[cite: 1]
* **Processing:** Button disabled `[ SUBMITTING... ]` with `<lightning-spinner>`[cite: 1]

### Output
When clicked, the button disabled immediately and displayed processing feedback to protect data integrity[cite: 1].

![Task 3 Output](Screenshots/Task-3.png)

### Result
* ✅ Double-clicks prevented[cite: 1]
* ✅ Spinner indicator displayed during async call[cite: 1]
* ✅ User experience improved with clear activity states[cite: 1]

---

## 🛠️ Task 4 – Parent-Child Component Refactoring (`jobCard`)

### Objective
Refactor the monolithic component by creating a dedicated child component (`jobCard`) to isolate card UI responsibilities[cite: 1].

### Architecture
* **Parent (`eligibleJobs`):** Fetches job lists, handles state, executes Apex calls[cite: 1].
* **Child (`jobCard`):** Renders individual job card UI, exposes `@api job`, and dispatches custom events[cite: 1].

```javascript
// Child: jobCard.js
const event = new CustomEvent('apply', {
    detail: { jobId: this.job.Id }
});
this.dispatchEvent(event);
```[cite: 1]

```html
<!-- Parent: eligibleJobs.html -->
<template for:each={jobs} for:item="job">
    <c-job-card key={job.Id} job={job} onapply={handleApply}></c-job-card>
</template>
```[cite: 1]

### Output
The UI rendered seamlessly through the new child component structure while passing custom events upward to the parent[cite: 1].

![Task 4 Output](Screenshots/Task-4.png)

### Result
* ✅ Modular LWC structure achieved[cite: 1]
* ✅ Downward data flow (`@api`) verified[cite: 1]
* ✅ Upward communication (`CustomEvent`) verified[cite: 1]

---

## 🛠️ Task 5 – Error Handling & Validation Feedback

### Objective
Intercept backend exceptions (e.g., duplicate applications or passed deadlines) and display friendly toast/message UI states[cite: 1].

### Error Handling Matrix

| Scenario | System Error | User Feedback |
| :--- | :--- | :--- |
| **Duplicate Application** | `DUPLICATE_VALUE` | *You have already applied for this opportunity.*[cite: 1] |
| **Expired Deadline** | `VALIDATION_EXCEPTION` | *Applications for this job are now closed.*[cite: 1] |

### Output
Errors returned from the business layer were translated into clean notifications without showing raw system logs[cite: 1].

![Task 5 Output](Screenshots/Task-5.png)

### Result
* ✅ User-friendly error messaging active[cite: 1]
* ✅ System exceptions masked safely[cite: 1]
* ✅ Toast notifications integrated[cite: 1]

---

## 🛠️ Task 6 – Real-Time Data Refresh & Final Workflow

### Objective
Refresh wired job data post-submission so the screen reflects the latest database state without a page reload[cite: 1].

### Flow
```text
Apply Success → DML Complete → refreshApex / Notify LDS → UI Re-evaluates → Status Updated
```[cite: 1]

### Output
Upon successful submission, the job card instantly updated its state to show a completed status badge[cite: 1].

![Task 6 Output](Screenshots/Task-6.png)

### Result
* ✅ Stale data eliminated via Apex refresh[cite: 1]
* ✅ Real-time UI synchronization verified[cite: 1]
* ✅ Complete end-to-end Apply flow finalized[cite: 1]

---

## 📊 Sprint 24 Task Summary

| Task | Main Work | Output |
| :--- | :--- | :--- |
| **Task 1** | Apply Button & Event Handler | Click event capturing `jobId`[cite: 1] |
| **Task 2** | Imperative Apex Integration | Server-side `submitApplication` execution[cite: 1] |
| **Task 3** | UI States & Double-Click | Disabled buttons and spinner indicators[cite: 1] |
| **Task 4** | Parent-Child Refactoring | Modular `jobCard` child component[cite: 1] |
| **Task 5** | Error Handling & Feedback | Toast alerts for duplicate/deadline checks[cite: 1] |
| **Task 6** | Real-Time Data Refresh | Dynamic UI update post-submission[cite: 1] |

---

## 🔄 Complete Architecture

```text
Student
  ↓
jobCard LWC (Child)
  ↓ CustomEvent ('apply')
eligibleJobs LWC (Parent)
  ↓ Imperative Call
ApplicationController (Apex)
  ↓
ApplicationService
  ↓ Validates Rules
DML / SOQL
  ↓
Salesforce Database
  ↓
UI Refresh & Toast Notification
```[cite: 1]

---

## 🧩 Technologies Used

* Salesforce Lightning Web Components (LWC)[cite: 1]
* HTML Template Directives[cite: 1]
* JavaScript ES6 (Promises & `async/await`)[cite: 1]
* Imperative Apex & `@AuraEnabled`[cite: 1]
* LWC Custom Events (`CustomEvent`)[cite: 1]
* Component Communication (`@api`)[cite: 1]
* Toast Notifications (`ShowToastEvent`)[cite: 1]
* Salesforce Developer Edition & VS Code[cite: 1]

---

## 🐛 Challenges Faced

1. **Double Submission on Rapid Clicks**
   * *Issue:* Users could double-click Apply before the server responded, creating redundant execution calls[cite: 1].
   * *Solution:* Managed a local `isProcessing` property to disable controls immediately on click[cite: 1].

2. **Stale UI State Post-Submission**
   * *Issue:* Application succeeded in the database, but UI still allowed re-applying[cite: 1].
   * *Solution:* Triggered server data refresh (`refreshApex`) after successful DML execution[cite: 1].

3. **Handling Child-to-Parent Event Data**
   * *Issue:* Parent did not receive the `jobId` parameter from the child card[cite: 1].
   * *Solution:* Bundled data in the `detail` object of `CustomEvent` (`detail: { jobId: this.job.Id }`)[cite: 1].

---

## 💡 Reflections

* **Separation of Concerns:** Business logic belongs in backend Apex service layers, not in JavaScript handlers[cite: 1].
* **User Experience Matters:** Clear states (loading, success, error) give users confidence during system actions[cite: 1].
* **Modular Architecture:** Splitting components into parent-child relationships keeps code clean and maintainable[cite: 1].

---

## 🎯 Interview Preparation

**When do you use imperative Apex over `@wire`?**  
Use imperative Apex when executing server calls in response to explicit user actions (e.g., clicking a button)[cite: 1]. Use `@wire` for passive, reactive data reading[cite: 1].

**How do child components pass data to parents?**  
Child components dispatch custom events containing data payloads in the `detail` property[cite: 1].

**How do you prevent duplicate submissions in LWC?**  
Disable action elements immediately upon event capture and re-enable them only after promise completion[cite: 1].

---

## 🏆 Sprint 24 Final Outcome

```text
Task 1 → Task 2 → Task 3 → Task 4 → Task 5 → Task 6 → Sprint 24 Completed ✅
```[cite: 1]
