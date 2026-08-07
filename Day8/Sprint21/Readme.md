# Sprint 21 – Batch Apex

## Objective

Process a large number of Application records efficiently using Batch Apex.

---

## Business Requirement

Update Placement_Category__c for historical application records based on package details.

---

## Components

### Apex Class

- PlacementCategoryBatch

---

## Features

- Batch Apex
- Bulk Processing
- start()
- execute()
- finish()

---

## Flow

Start Batch
↓

Retrieve Records
↓

Process Records in Batches
↓

Update Placement Category
↓

Finish Batch

---

## Technologies Used

- Batch Apex
- SOQL
- DML

---

## Output

✔ Historical Applications Processed

✔ Placement Categories Updated

✔ Batch Completed Successfully

---

## Learning Outcomes

- Process large datasets.
- Bulkify Apex code.
- Understand Batch Apex lifecycle.
- Improve performance for large-scale operations.
