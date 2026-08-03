# Engineering Sprint 2 – Receiving an Application

## Objective

Receive a student's application request and begin processing.

---

## Business Requirement

A student selects a company and clicks **Apply**.

The application request should be received successfully.

---

## Source Code Files

```
ApplicationService.cls
Execute Anonymous
```

---

## Implementation

Created

```apex
submitApplication(Id studentId, Id jobId)
```

Accepted

- Student Id
- Job Id

Displayed

```
Application received successfully.
```

---

## Challenges

Choosing only the required parameters without adding unnecessary information.

---

## Reflection

Methods should accept only the data required to complete their task.

---

## Engineering Lesson

Build one capability at a time.
