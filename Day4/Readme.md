# 🚀 Salesforce Interview Readiness Bootcamp – Day 4

## 📖 Overview
This repository contains my Day 4 learning activities from the **Salesforce Interview Readiness Bootcamp**. The focus was on building my first **Lightning Web Component (LWC)** and understanding how the Salesforce user interface interacts with Apex, SOQL, and the Salesforce database. I created simple UI components, implemented data binding, handled button click events, and learned the structure of an LWC. :contentReference[oaicite:0]{index=0}

---

# 🎯 Objectives
- Understand Lightning Web Components (LWC).
- Create and deploy the first Lightning Web Component.
- Learn the structure of an LWC.
- Implement data binding.
- Handle button click events using JavaScript.
- Understand how LWC communicates with Apex.
- Build the first UI for the Placement Management System.

---

# 📚 Topics Covered

- Lightning Web Components (LWC)
- HTML Template
- JavaScript Controller
- Meta XML Configuration
- Data Binding
- Event Handling
- Lightning App Builder
- Component Deployment
- Placement Management System UI

---

# 📂 Repository Structure

```
Day4/
├── force-app/
│   ├── main/
│   │   ├── default/
│   │   │   ├── lwc/
│   │   │   │   ├── placementHome/
│   │   │   │   │   ├── placementHome.html
│   │   │   │   │   ├── placementHome.js
│   │   │   │   │   └── placementHome.js-meta.xml
│
├── Screenshots/
│   ├── placement-home.png
│   ├── variables-display.png
│   ├── welcome-message.png
│   ├── status-update.png
│   ├── placement-dashboard.png
│   └── lightning-page.png
│
└── README.md
```

---

# ✅ Tasks Completed

- Created the first Lightning Web Component (`placementHome`).
- Deployed the component to a Lightning Page.
- Displayed Student Name, Roll Number, and Department.
- Implemented dynamic data binding.
- Added a button to display a welcome message.
- Added another button to update the application status.
- Built the initial Placement Management System dashboard.
- Added screenshots of all completed activities.

---

# 📸 Screenshots

The **Screenshots** folder contains:

- Placement Home Component
- Student Details Display
- Welcome Message
- Status Update
- Placement Dashboard
- Lightning App Builder Deployment

---

# ❓ Interview Questions & Answers

### 1. What is Lightning Web Components (LWC)?
Lightning Web Components (LWC) is Salesforce's modern UI framework built using web standards such as HTML, JavaScript, and CSS. It is used to build fast, reusable, and maintainable user interfaces.

### 2. Why did Salesforce introduce LWC?
Salesforce introduced LWC to improve performance, use modern web standards, encourage code reusability, and provide a better developer experience compared to Aura Components.

### 3. Difference between LWC and Aura

| LWC | Aura |
|------|------|
| Uses modern web standards | Uses Salesforce-specific framework |
| Better performance | Comparatively slower |
| Easier to learn | More complex |
| Lightweight | Heavier framework |

### 4. What are the three files inside an LWC?

- **HTML** – Defines the user interface.
- **JavaScript** – Handles logic, variables, and events.
- **Meta XML** – Makes the component available in Lightning App Builder.

### 5. Why is JavaScript required?
JavaScript is responsible for handling component logic, variables, user interactions, events, and communication with Apex.

### 6. What is Data Binding?
Data Binding automatically updates the UI whenever the value of a JavaScript variable changes.

### 7. Can LWC directly execute SOQL?
No. LWC cannot execute SOQL directly because it runs on the client side. SOQL must be executed through Apex on the server.

### 8. Why does LWC need Apex?
LWC uses Apex to perform server-side operations such as querying Salesforce records, inserting data, updating records, deleting records, and executing business logic.

### 9. Where is the component deployed?
The component is deployed using **Lightning App Builder** on pages such as Home Page, App Page, or Record Page.

### 10. Explain the component you built today.
I created a Lightning Web Component named **placementHome** that displays a welcome message, student information, application status, and a simple Placement Management dashboard. I also implemented button click events and data binding using JavaScript.

---

# 💡 What I Learned

Today I learned the fundamentals of Lightning Web Components and how Salesforce user interfaces are built. I understood the purpose of HTML, JavaScript, and Meta XML files, implemented data binding, handled button click events, and deployed my first component using Lightning App Builder. I also learned how LWC communicates with Apex to access Salesforce data while keeping business logic separate from the user interface.

---

# ⚡ Challenges Faced

- Understanding the structure of Lightning Web Components.
- Learning the responsibilities of HTML, JavaScript, and Meta XML files.
- Implementing data binding correctly.
- Handling button click events.
- Deploying the component in Lightning App Builder.
- Understanding why LWC cannot directly execute SOQL.

---

# 🪞 Reflection

Day 4 marked my transition from backend Salesforce development to frontend development using Lightning Web Components. Building my first interactive UI helped me understand how users interact with Salesforce applications. I learned that LWC focuses on presentation while Apex handles business logic and database operations. This session strengthened my understanding of Salesforce architecture and improved my confidence in developing modern Salesforce applications.

---

# 🛠️ Technologies Used

- Salesforce Developer Org
- Lightning Web Components (LWC)
- HTML
- JavaScript
- XML
- Lightning App Builder
- VS Code
- Salesforce CLI
