# Engineering Sprint 3 – Preventing Duplicate Applications

## Objective

Prevent a student from applying to the same company more than once.

---

## Business Requirement

Before saving an application, verify whether an existing application already exists.

---

## Source Code Files

```
ApplicationService.cls
Execute Anonymous
```

---

## Implementation

Used SOQL to check duplicate records.

Example

```apex
SELECT Id
FROM Application__c
WHERE Student__c=:studentId
AND Job__c=:jobId
LIMIT 1
```

Returned

```
Application already exists.
```

---

## Challenges

The Application object initially did not contain the required Job lookup field.

---

## Resolution

Created the required relationship field.

---

## Reflection

Validating before saving prevents duplicate records and improves data quality.

---

## Engineering Lesson

Always validate before performing DML.
