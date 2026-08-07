# Sprint 17 – Apex Data Access (SOQL & DML)

## Overview

Sprint 17 introduces Apex database operations using SOQL and DML. In this sprint, the Recruiting Management System retrieves, inserts, updates, and deletes records using Apex while following Salesforce governor limits and best practices.

---

## Learning Objectives

- Understand SOQL queries.
- Perform DML operations using Apex.
- Retrieve single and multiple records.
- Insert new records.
- Update existing records.
- Delete unnecessary records.
- Handle database exceptions.

---

## Business Problem

The recruitment team needs to manage candidate applications automatically instead of manually updating records.

The system should:

- Retrieve applications.
- Create new applications.
- Update application status.
- Remove invalid records.

---

## Topics Covered

- SOQL
- DML Statements
- Apex Classes
- Lists
- Variables
- Exception Handling

---

## Objects Used

### Student__c
Stores student details.

### Company__c
Stores company information.

### Application__c
Stores job applications.

Relationships:

Application → Student

Application → Company

---

## Features Implemented

✔ Retrieve records using SOQL

✔ Insert new Application records

✔ Update Application Status

✔ Delete unwanted records

✔ Bulk-safe Apex code

---

## Files

Apex Classes

- ApplicationService.cls
- StudentService.cls

Test Classes

- ApplicationServiceTest.cls

---

## Sample Operations

### Insert

- Create Application

### Update

- Change Status

### Delete

- Remove Application

### Query

- Fetch Student Applications

---

## Output

- Records successfully created
- Records updated
- Records deleted
- SOQL returns required data

---

## Skills Learned

- SOQL
- DML
- Apex Programming
- Salesforce Data Model
- Governor Limits
- Exception Handling

---

## Technologies

- Salesforce
- Apex
- SOQL
- DML

---

## Sprint Outcome

Successfully developed Apex programs to perform CRUD operations using SOQL and DML while following Salesforce best practices.
