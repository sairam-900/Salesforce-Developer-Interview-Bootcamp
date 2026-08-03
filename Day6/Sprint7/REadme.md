# Engineering Sprint 7 – Retrieving Student Information

## 📌 Objective

Retrieve the student information before processing an application.

---

## 📖 Business Requirement

Before validating an application, the software must identify the student and retrieve only the information required for eligibility validation.

---

## 📂 Source Code Files

```
ApplicationService.cls
Execute Anonymous
Student__c
```

---

## ⚙️ Apex Class

```apex
public with sharing class ApplicationService {

    public static Student__c getStudent(Id studentId) {

        return [
            SELECT CGPA__c,
                   Backlogs__c,
                   Branch__c,
                   Graduation_Year__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];
    }

}
```

---

## ▶️ Execute Anonymous

```apex
Id studentId = 'a04WU00000DWEbRYAX';

Student__c student = ApplicationService.getStudent(studentId);

System.debug(student);
```

---

# Debug Output

The following debug log confirms that the student record was successfully retrieved from the **Student__c** object using the provided Student Id.

> **Execution Log**

![Sprint 7 Debug Output](images/sprint7_debug_output.png)

**Observed Output**

```
USER_DEBUG
Student__c:{Id=a04WU00000DWEbRYAX}
```

The debug output verifies that:

- Student record was retrieved successfully.
- SOQL query executed successfully.
- Student Id matched the requested record.
- The service is ready for the next validation step.

---

## ✅ Expected Behaviour

- Student information retrieved successfully.
- Required fields available for eligibility validation.
- No unnecessary fields queried.

---

## 🚧 Challenges

- Understanding which Student fields were required.
- Writing an efficient SOQL query.
- Avoiding unnecessary field retrieval.

---

## 💡 Reflection

This sprint demonstrated the importance of retrieving only the information required for business decisions. Efficient SOQL queries improve application performance and help stay within Salesforce governor limits.

---

## 📚 Engineering Lesson

> Retrieve only the information your business requires.

---

## 🛠 Technologies Used

- Salesforce Apex
- SOQL
- Developer Console
- Execute Anonymous

---

## 📖 Key Learning Outcomes

- Learned how to retrieve Salesforce records using SOQL.
- Queried only the fields required by the business.
- Verified query execution using Debug Logs.
- Understood the importance of efficient database access.
