# Sprint 18 – Apex Triggers and Trigger Context Variables

## Overview

Sprint 18 focuses on Apex Triggers that automate business processes whenever Salesforce records are inserted, updated, deleted, or restored.

This sprint also introduces Trigger Context Variables for handling different trigger events efficiently.

---

## Learning Objectives

- Understand Apex Triggers.
- Learn Trigger Events.
- Use Trigger Context Variables.
- Automate business logic.
- Write bulkified trigger code.
- Follow Trigger Best Practices.

---

## Business Problem

Whenever an Application record is updated, the related Student record should automatically reflect the latest placement status and company.

This eliminates manual updates and ensures data consistency.

---

## Topics Covered

- Before Insert
- After Insert
- Before Update
- After Update
- Before Delete
- After Delete
- After Undelete

Trigger Context Variables

- Trigger.new
- Trigger.old
- Trigger.newMap
- Trigger.oldMap
- Trigger.isInsert
- Trigger.isUpdate
- Trigger.isDelete
- Trigger.isBefore
- Trigger.isAfter

---

## Objects Used

### Student__c

Stores student information.

### Company__c

Stores company details.

### Application__c

Stores placement applications.

Relationships:

Application → Student

Application → Company

---

## Features Implemented

✔ Auto-update Student Placement Status

✔ Auto-update Student Company

✔ Handle Bulk Updates

✔ Trigger Handler Pattern

✔ Prevent Duplicate Logic

---

## Files

Triggers

- ApplicationTrigger.trigger

Handler Classes

- ApplicationTriggerHandler.cls

Test Classes

- ApplicationTriggerTest.cls

---

## Trigger Flow

Application Updated

↓

Trigger Fires

↓

Handler Executes

↓

Student Record Updated

↓

Placement Status Changed

↓

Company Assigned

---

## Output

- Student status automatically updated.
- Company automatically assigned.
- No manual intervention required.
- Bulk records processed successfully.

---

## Skills Learned

- Apex Triggers
- Trigger Context Variables
- Trigger Handler Pattern
- Bulkification
- Best Practices
- Data Synchronization

---

## Technologies

- Salesforce
- Apex
- SOQL
- DML
- Triggers

---

## Sprint Outcome

Successfully automated business processes using Apex Triggers and Trigger Context Variables, ensuring synchronized student placement information whenever application records are modified.
