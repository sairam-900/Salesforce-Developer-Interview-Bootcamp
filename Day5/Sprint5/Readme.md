# Engineering Sprint 5 – Saving the Application

## Objective

Save the application record into Salesforce after all validations succeed.

---

## Business Requirement

Store the application and inform the user whether the operation succeeds or fails.

---

## Source Code Files

```
ApplicationService.cls
Application__c
Execute Anonymous
```

---

## Implementation

Used DML

```apex
insert application;
```

Handled exceptions

```apex
try{

insert application;

}catch(DmlException e){

}
```

Displayed meaningful success and error messages.

---

## Challenges

Encountered restricted picklist errors while inserting records.

---

## Resolution

Updated the code to use valid picklist values.

---

## Reflection

Meaningful error handling improves the user experience and simplifies debugging.

---

## Engineering Lesson

Always handle DML exceptions properly.
