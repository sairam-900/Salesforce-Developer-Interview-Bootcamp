# Engineering Sprint 8 – Understanding the Opportunity

## 📌 Objective

Retrieve the selected Job record before processing the application and collect the eligibility criteria required for decision-making.

---

## 📖 Business Requirement

Every company defines its own eligibility criteria. Before validating a student's application, the software must retrieve the Job information required for eligibility checking.

The application retrieves only the information needed for the current business decision.

---

## 📂 Source Code Files

```
ApplicationService.cls
Job__c
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

        if(student.CGPA__c < job.Minimum_CGPA__c){
            return 'Rejected: CGPA is below the minimum requirement.';
        }

        if(student.Backlogs__c > 0){
            return 'Rejected: Student has active backlogs.';
        }

        return 'Submitted: Student details and job eligibility verified successfully.';
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

The following execution log confirms that the student information and job eligibility criteria were successfully retrieved and validated.

> **Execution Log**

![Sprint 8 Debug Output](images/sprint8_debug.png)

**Observed Output**

```
USER_DEBUG

Submitted: Student details and job eligibility verified successfully.
```

The debug output verifies that:

- Student record retrieved successfully.
- Job eligibility information retrieved successfully.
- Eligibility validation completed successfully.
- Application request passed all current validations.
- The service is ready for duplicate validation in the next sprint.

---

## ✅ Expected Behaviour

- Student information retrieved successfully.
- Job eligibility criteria retrieved successfully.
- Eligibility validation completed.
- Meaningful success or rejection message returned.

---

## 🚧 Challenges

- Identifying only the required Job fields.
- Writing efficient SOQL queries.
- Returning meaningful validation messages.
- Following Salesforce governor limits.

---

## 💡 Reflection

This sprint demonstrated how business decisions depend on retrieving accurate information before performing any database operations. Efficient SOQL queries improve performance while keeping the code clean and maintainable.

---

## 📚 Engineering Principle

> Retrieve only the information required for today's business decision.

---

## 🛠 Technologies Used

- Salesforce Apex
- SOQL
- Custom Objects
- Developer Console
- Execute Anonymous

---

## 📖 Key Learning Outcomes

- Retrieved Job records using SOQL.
- Retrieved only the fields required for eligibility validation.
- Applied business rules before processing applications.
- Returned meaningful feedback messages.
- Verified execution using Debug Logs.

---

## 📁 Source Code Files

```
ApplicationService.cls
Student__c
Job__c
Execute Anonymous
README.md
```

---

## 🎯 Engineering Lesson Learned

Business software should retrieve accurate information before making decisions. Clear validation messages improve usability, while efficient SOQL queries improve performance and maintainability.
