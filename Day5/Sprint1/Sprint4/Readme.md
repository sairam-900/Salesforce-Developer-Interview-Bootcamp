# Engineering Sprint 4 – Validating Eligibility

## Objective

Ensure only eligible students can apply for jobs.

---

## Business Requirement

Validate

- Minimum CGPA
- Active Backlogs
- Branch
- Graduation Year

---

## Source Code Files

```
ApplicationService.cls
Student__c
Job__c
```

---

## Implementation

Validated

- CGPA
- Backlogs
- Branch
- Graduation Year

Displayed meaningful messages whenever validation failed.

---

## Challenges

Some eligibility fields were unavailable on the Job object and required additional configuration.

---

## Reflection

Breaking validation into helper methods makes the code easier to understand and maintain.

---

## Engineering Lesson

One method should perform one responsibility.
