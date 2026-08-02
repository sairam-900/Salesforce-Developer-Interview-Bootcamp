# 🚀 Salesforce Developer Bridge Program – Day 2

## 📖 Overview
This repository contains my Day 2 learning activities from the **Salesforce Developer Bridge Program**. The focus was on writing production-ready Apex code by understanding Collections, Governor Limits, Bulkification, Asynchronous Apex, and Lightning Web Component (LWC) communication patterns. :contentReference[oaicite:0]{index=0}

---

## 🎯 Objectives
- Understand Apex Collections (List, Set, Map).
- Learn Governor Limits and why they exist.
- Implement Bulkified Apex code.
- Explore Asynchronous Apex using `@future`.
- Build Parent-to-Child and Child-to-Parent communication in LWC.

---

## 📚 Topics Covered
- Apex Collections
- List
- Set
- Map
- Governor Limits
- Bulkification
- Asynchronous Apex
- Future Methods
- Queueable Apex
- Batch Apex (Introduction)
- LWC Parent-to-Child Communication
- LWC Child-to-Parent Communication

---

## 📂 Repository Structure

```
Day2/
├── force-app/
│   ├── main/
│   │   ├── default/
│   │   │   ├── classes/
│   │   │   ├── triggers/
│   │   │   ├── lwc/
│   │   │   └── objects/
│
├── Screenshots/
│   ├── collections-output.png
│   ├── governor-limit-error.png
│   ├── bulkified-success.png
│   ├── future-method.png
│   ├── apex-jobs.png
│   ├── parent-child-lwc.png
│   └── child-parent-event.png
│
└── README.md
```

---

## ✅ Tasks Completed
- Practiced Apex Collections using List, Set, and Map.
- Executed collection operations in Execute Anonymous.
- Created a trigger with SOQL inside a loop to observe Governor Limit errors.
- Bulkified the trigger by moving SOQL and DML operations outside loops.
- Implemented an `@future` method and verified execution through Apex Jobs.
- Built two Lightning Web Components demonstrating Parent-to-Child and Child-to-Parent communication.
- Added project screenshots for all completed tasks.

---

## 📸 Screenshots
The **Screenshots** folder contains:

- Apex Collections Output
- Governor Limit Error
- Bulkified Trigger Success
- Future Method Execution
- Apex Jobs Verification
- Parent to Child Communication
- Child to Parent Communication

---

## 💡 What I Learned
Day 2 helped me understand how to write efficient and scalable Apex code. I learned how to use Apex Collections such as Lists, Sets, and Maps to manage records effectively. I explored Governor Limits by intentionally creating inefficient code and then bulkifying it to handle large data volumes. I also gained practical experience with Asynchronous Apex using `@future` methods and learned how to verify background jobs in Apex Jobs. Finally, I built Lightning Web Components that communicate between parent and child components using `@api` properties and custom events, improving my understanding of component interaction.

---

## ⚡ Challenges Faced
- Understanding when to use List, Set, and Map effectively.
- Identifying Governor Limit errors caused by SOQL and DML inside loops.
- Bulkifying Apex code to process hundreds of records efficiently.
- Learning the differences between Future, Queueable, and Batch Apex.
- Passing data between LWC parent and child components.
- Handling custom events correctly in Lightning Web Components.

---

## 🪞 Reflection
Day 2 focused on writing production-ready Salesforce code. Learning about Governor Limits and Bulkification showed me the importance of optimizing Apex for performance and scalability. Exploring Asynchronous Apex introduced me to background processing, while LWC component communication helped me understand how modern Salesforce user interfaces are built. These concepts strengthened my coding practices and prepared me for developing efficient, enterprise-level Salesforce applications.

---

## 🛠️ Technologies Used
- Salesforce Developer Org
- Apex
- SOQL
- Lightning Web Components (LWC)
- VS Code
- Salesforce CLI
- Developer Console
