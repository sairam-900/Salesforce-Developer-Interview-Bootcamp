# Sprint 22 – Scheduled Apex

## Objective

Automatically execute batch processing every morning to close expired job postings.

---

## Business Requirement

Identify all open jobs whose application deadline has passed and update their status to Closed.

---

## Components

### Apex Classes

- ExpiredJobScheduler
- ExpiredJobBatch

---

## Flow

Scheduler
↓

Execute Batch
↓

Find Expired Jobs
↓

Update Status
↓

Batch Completion

---

## Features

- Scheduled Apex
- Batch Apex Integration
- Automatic Daily Execution
- Cron Scheduling

---

## Technologies Used

- Scheduled Apex
- Batch Apex
- SOQL
- DML

---

## Output

✔ Scheduler Executed Successfully

✔ Expired Jobs Identified

✔ Job Status Updated to Closed

✔ Batch Completed

---

## Learning Outcomes

- Schedule Apex jobs using Cron Expressions.
- Execute Batch Apex through Scheduled Apex.
- Automate recurring business processes.
- Build scalable asynchronous solutions.
