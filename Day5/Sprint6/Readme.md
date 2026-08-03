# Engineering Sprint 6 – Completing the Workflow

## Objective

Complete the end-to-end application workflow.

---

## Workflow

```
Receive Application
        │
        ▼
Duplicate Validation
        │
        ▼
Eligibility Validation
        │
        ▼
Save Application
        │
        ▼
Display Result
```

---

## Source Code Files

```
ApplicationService.cls
Execute Anonymous
```

---

## Implementation

Organized the business logic into reusable methods.

```
submitApplication()

checkDuplicate()

checkEligibility()

saveApplication()
```

---

## Challenges

Understanding how to separate responsibilities into smaller methods.

---

## Reflection

Smaller methods improve readability, testing, and maintenance.

---

## Debugging Learnings

### Avoid SOQL inside loops

Improves performance and prevents governor limit exceptions.

### Avoid duplicate validation logic

Create reusable helper methods.

### Use meaningful method names

Examples

```
submitApplication()

checkDuplicate()

checkEligibility()

saveApplication()
```

### Split large methods

Large methods should be divided into smaller reusable methods.

---

## Engineering Lesson

Clean code is easier to read, test, maintain, and extend.
