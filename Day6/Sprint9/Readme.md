# Engineering Sprint 9 – Preventing Duplicate Applications

## 📌 Objective

Prevent duplicate job applications by checking whether the student has already submitted an application before continuing the process.

---

## 📖 Business Requirement

Students should not accidentally submit multiple applications for the same company.

Before creating a new application, the software must verify whether an application already exists.

If a duplicate application is found, the process should stop immediately and display an appropriate message.

---

## 📂 Source Code Files

```
ApplicationService.cls
Application__c
Execute Anonymous
```

---

## ⚙️ Apex Class

```apex
public with sharing class ApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {

        Student__c student = [
            SELECT CGPA__c,
                   Backlogs__c,
                   Branch__c,
                   Graduation_Year__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        Job__c job = [
            SELECT Minimum_CGPA__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        List<Application__c> existingApplications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
            LIMIT 1
        ];

        if(!existingApplications.isEmpty()){
            return 'Rejected: Duplicate application already exists.';
        }

        if(student.CGPA__c < job.Minimum_CGPA__c){
            return 'Rejected: CGPA is below the minimum requirement.';
        }

        if(student.Backlogs__c > 0){
            return 'Rejected: Student has active backlogs.';
        }

        return 'Submitted: No duplicate application found.';
    }

}
```

---

## ▶️ Execute Anonymous

```apex
Id studentId = 'a04WU00000DWEbRYAX';
Id jobId = 'a06WU00000R7V5xYAF';

String result = ApplicationService.submitApplication(studentId, jobId);

System.debug(result);
```

---

#  Debug Output

The following execution log confirms that the duplicate validation and eligibility validation were executed successfully.

> **Execution Log**

![Sprint 9 Debug Output](images/sprint9_Duplicates.png)

**Observed Output**

```
USER_DEBUG

Rejected: Student has active backlogs.
```

The debug output verifies that:

- Student record retrieved successfully.
- Job eligibility information retrieved successfully.
- Duplicate validation executed.
- Eligibility validation detected active backlogs.
- Application processing stopped before creating a duplicate record.
- Meaningful feedback returned to the user.

---

## ✅ Expected Behaviour

| Scenario | Result |
|----------|--------|
| First Application | Continue |
| Duplicate Application | Rejected |
| Different Company | Continue |

---

## 🚧 Challenges

- Understanding duplicate validation logic.
- Preventing unnecessary DML operations.
- Writing efficient SOQL queries.
- Returning meaningful validation messages.

---

## 💡 Reflection

This sprint highlighted the importance of validating business rules before modifying Salesforce data. Preventing duplicate applications improves data integrity and reduces administrative effort.

---

## 📚 Engineering Principle

> Validate business rules before changing business data.

---

## 🛠 Technologies Used

- Salesforce Apex
- SOQL
- Developer Console
- Execute Anonymous
- Custom Objects

---

## 📖 Key Learning Outcomes

- Retrieved existing Application records using SOQL.
- Implemented duplicate application validation.
- Prevented unnecessary database operations.
- Returned meaningful business messages.
- Verified execution using Salesforce Debug Logs.

---

## 📁 Source Code Files

```
ApplicationService.cls
Application__c
Student__c
Job__c
Execute Anonymous
README.md
```

---

## 🎯 Engineering Lesson Learned

Preventing invalid business transactions before they reach the database is more efficient than correcting incorrect data later. Business validation should always occur before DML operations.
