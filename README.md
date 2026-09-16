# SAP ABAP Inventory & Stock Management System

> **This project is a learning/portfolio project developed to demonstrate SAP ABAP fundamentals. It is NOT a production SAP system.**

A beginner-friendly SAP ABAP project built as an academic/portfolio piece for an MCA student applying for SAP ABAP Trainee/Intern positions. The project demonstrates core SAP ABAP concepts through a simple Inventory & Stock Management System.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Problem Statement](#2-problem-statement)
3. [Objectives](#3-objectives)
4. [Features](#4-features)
5. [Technology](#5-technology)
6. [SAP Components Used](#6-sap-components-used)
7. [Database Design](#7-database-design)
8. [ABAP Concepts Demonstrated](#8-abap-concepts-demonstrated)
9. [Project Architecture](#9-project-architecture)
10. [Data Processing Flow](#10-data-processing-flow)
11. [How to Create the Tables](#11-how-to-create-the-tables)
12. [How to Run the Programs](#12-how-to-run-the-programs)
13. [Sample Output](#13-sample-output)
14. [Screenshots](#14-screenshots)
15. [Learning Outcomes](#15-learning-outcomes)
16. [Future Enhancements](#16-future-enhancements)
17. [SAP BTP ABAP Environment Notes](#17-sap-btp-abap-environment-notes)

---

## 1. Project Overview

This project implements a simple Inventory & Stock Management System using SAP ABAP. It manages product information, supplier data, and stock movements through custom database tables and multiple ABAP reports.

The project is designed to be:
- **Simple** — Beginner-level ABAP code
- **Well-documented** — Every concept is explained
- **Interview-ready** — Demonstrates skills expected from an ABAP fresher
- **Honest** — No fake screenshots or false claims

---

## 2. Problem Statement

Businesses need to track their inventory — what products they have, how many are in stock, which suppliers provide them, and when stock moves in or out. This project builds a simplified version of such a system to demonstrate how SAP ABAP can be used for data management and reporting.

---

## 3. Objectives

1. Design custom database tables using SAP Data Dictionary
2. Insert and manage sample inventory data using Open SQL
3. Build interactive reports with Selection Screens
4. Retrieve and process data using Internal Tables and Work Areas
5. Implement business logic (low-stock detection, inventory valuation)
6. Demonstrate modularization using FORM routines
7. Show basic Object-Oriented ABAP with a local class
8. Provide documentation for debugging and ABAP concepts

---

## 4. Features

| # | Feature | Program |
|---|---------|---------|
| 1 | Store product information | ZPRODUCT table |
| 2 | Store supplier information | ZSUPPLIER table |
| 3 | View available inventory | ZINVENTORY_REPORT |
| 4 | Search products by ID | ZINVENTORY_REPORT |
| 5 | Filter products by category | ZINVENTORY_REPORT |
| 6 | Check low-stock products | ZLOW_STOCK_REPORT |
| 7 | Record stock movements | ZSTOCK_MOVEMENT table |
| 8 | View stock movement history | ZSTOCK_MOVEMENT_REPORT |
| 9 | Generate category-wise reports | ZCATEGORY_REPORT |
| 10 | Calculate inventory statistics | ZINVENTORY_REPORT |

---

## 5. Technology

| Component | Technology |
|-----------|-----------|
| Programming Language | SAP ABAP |
| Database | SAP HANA / Any SAP-supported DB |
| Development Environment | SAP GUI (SE38, SE11, SE80) or SAP BTP ABAP Environment |
| SQL | Open SQL (ABAP SQL) |
| Reporting | ABAP List Processing (WRITE statements) |

---

## 6. SAP Components Used

- **SAP Data Dictionary (SE11)** — Table, Domain, Data Element creation
- **ABAP Editor (SE38)** — Program development
- **ABAP Debugger** — Testing and verification
- **Open SQL** — Database operations (SELECT, INSERT)
- **Selection Screens** — User input for report filtering
- **Internal Tables & Work Areas** — In-memory data processing
- **FORM/PERFORM** — Procedural modularization
- **ABAP Objects** — Basic OOP (local class)

---

## 7. Database Design

### Tables

| Table | Purpose | Primary Key |
|-------|---------|-------------|
| ZSUPPLIER | Supplier master data | SUPPLIER_ID |
| ZPRODUCT | Product/inventory data | PRODUCT_ID |
| ZSTOCK_MOVEMENT | Stock IN/OUT records | MOVEMENT_ID |

### Relationships

```
ZSUPPLIER
    │
    │ SUPPLIER_ID (1:N)
    ▼
ZPRODUCT
    │
    │ PRODUCT_ID (1:N)
    ▼
ZSTOCK_MOVEMENT
```

### ZPRODUCT Fields

| Field | Type | Description |
|-------|------|-------------|
| PRODUCT_ID | CHAR 10 | Product ID (Key) |
| PRODUCT_NAME | CHAR 40 | Product Name |
| CATEGORY | CHAR 20 | Category (Electronics, Furniture, etc.) |
| SUPPLIER_ID | CHAR 10 | FK → ZSUPPLIER |
| UNIT_PRICE | DEC 13,2 | Unit Price |
| STOCK_QTY | INT4 | Current Stock Quantity |
| REORDER_LEVEL | INT4 | Minimum Stock Level |
| LOCATION | CHAR 20 | Storage Location |
| STATUS | CHAR 10 | ACTIVE / INACTIVE |
| CREATED_DATE | DATS | Date Created |

### ZSUPPLIER Fields

| Field | Type | Description |
|-------|------|-------------|
| SUPPLIER_ID | CHAR 10 | Supplier ID (Key) |
| SUPPLIER_NAME | CHAR 40 | Supplier Name |
| EMAIL | CHAR 50 | Email Address |
| PHONE | CHAR 15 | Phone Number |
| CITY | CHAR 20 | City |
| STATUS | CHAR 10 | ACTIVE / INACTIVE |

### ZSTOCK_MOVEMENT Fields

| Field | Type | Description |
|-------|------|-------------|
| MOVEMENT_ID | CHAR 10 | Movement ID (Key) |
| PRODUCT_ID | CHAR 10 | FK → ZPRODUCT |
| MOVEMENT_TYPE | CHAR 3 | IN or OUT |
| QUANTITY | INT4 | Quantity Moved |
| MOVEMENT_DATE | DATS | Date of Movement |
| REFERENCE_NO | CHAR 15 | Reference Number |

> See [TABLE/](TABLE/) directory for detailed SE11 creation instructions.

---

## 8. ABAP Concepts Demonstrated

| # | Concept | Where Used |
|---|---------|-----------|
| 1 | Data Dictionary | ZPRODUCT, ZSUPPLIER, ZSTOCK_MOVEMENT tables |
| 2 | Transparent Tables | All 3 custom Z tables |
| 3 | Domains & Data Elements | Field definitions for all tables |
| 4 | Open SQL | SELECT, INSERT in all programs |
| 5 | Internal Tables | `lt_product`, `lt_supplier`, etc. |
| 6 | Work Areas | `ls_product` in LOOP processing |
| 7 | Selection Screens | ZINVENTORY_REPORT, ZSTOCK_MOVEMENT_REPORT |
| 8 | ABAP Reports | All 5 executable programs |
| 9 | Modularization (FORM) | ZINVENTORY_REPORT |
| 10 | Basic OOP ABAP | `lcl_inventory` class |
| 11 | Debugging | Breakpoints, variable inspection |
| 12 | Data Processing | Category aggregation, inventory valuation |

> See [DOCUMENTATION/ABAP_CONCEPTS.md](DOCUMENTATION/ABAP_CONCEPTS.md) for detailed explanations.

---

## 9. Project Architecture

```
User
 ↓
Selection Screen (Parameters / Checkboxes)
 ↓
ABAP Report Program
 ↓
Open SQL (SELECT / INSERT)
 ↓
SAP Data Dictionary Tables
 ↓
Internal Tables (in-memory)
 ↓
Business Logic (FORM routines / Class methods)
 ↓
Report Output (WRITE statements)
```

> See [DOCUMENTATION/ARCHITECTURE.md](DOCUMENTATION/ARCHITECTURE.md) for detailed architecture documentation.

---

## 10. Data Processing Flow

```
Source Data (ZPRODUCT, ZSUPPLIER, ZSTOCK_MOVEMENT)
 ↓
Extraction (Open SQL SELECT)
 ↓
Validation (Status checks, data filtering)
 ↓
Transformation (Inventory Value = Unit Price × Stock Qty)
 ↓
Aggregation (Category totals, stock summaries)
 ↓
Report Output (Formatted inventory reports)
```

> See [DOCUMENTATION/DATA_PROCESSING.md](DOCUMENTATION/DATA_PROCESSING.md) for how this relates to SAP BW concepts.

---

## 11. How to Create the Tables

### Prerequisites
- Access to an SAP ABAP development system (SAP GUI or SAP BTP ABAP Environment)
- A development user with authorization to create objects in package `$TMP` or a custom package

### Step-by-Step

1. **Open SE11** (Data Dictionary)
2. **Create Domains** for each field type (e.g., ZPRODUCT_ID → CHAR 10)
3. **Create Data Elements** using the domains
4. **Create Transparent Tables:**
   - First create **ZSUPPLIER** (no foreign key dependencies)
   - Then create **ZPRODUCT** (has FK to ZSUPPLIER)
   - Finally create **ZSTOCK_MOVEMENT** (has FK to ZPRODUCT)
5. **Activate** all objects
6. **Set Technical Settings** (Data Class: APPL0, Size Category: 0)

> See [TABLE/](TABLE/) directory for detailed field-by-field instructions.

---

## 12. How to Run the Programs

### Step 1: Create Tables
Follow the instructions in [How to Create the Tables](#11-how-to-create-the-tables).

### Step 2: Create Programs
1. Open **SE38** (ABAP Editor)
2. Create each program by entering the program name and clicking "Create"
3. Copy the source code from the [ABAP/](ABAP/) directory
4. Save and activate each program

### Step 3: Insert Sample Data
1. Execute **ZINVENTORY_TEST_DATA** (SE38 → enter program name → F8)
2. Leave the "Reset Data" checkbox unchecked
3. Click Execute
4. Verify: "Sample data inserted successfully" message appears

### Step 4: Run Reports
| Program | Transaction | Description |
|---------|-------------|-------------|
| ZINVENTORY_REPORT | SE38 → F8 | Main inventory report |
| ZLOW_STOCK_REPORT | SE38 → F8 | Low stock alert report |
| ZSTOCK_MOVEMENT_REPORT | SE38 → F8 | Stock movement history |
| ZCATEGORY_REPORT | SE38 → F8 | Category-wise analysis |

### Step 5: Test with Filters
- In ZINVENTORY_REPORT, try:
  - Enter "Electronics" in Category field
  - Check the "Low Stock Only" checkbox
  - Enter a specific Product ID like "P1001"

---

## 13. Sample Output

### Main Inventory Report
```
============================================================
        SAP ABAP Inventory Management Report
============================================================

Product ID  Product Name         Category         Stock   Price
--------------------------------------------------------------
P1001       Laptop               Electronics      25      55,000.00
P1002       Keyboard             Electronics      8       1,200.00
P1003       Office Chair         Furniture        15      6,500.00
P1004       Monitor              Electronics      12      18,000.00
P1005       Printer              Office Equipment 6       12,000.00
--------------------------------------------------------------

============================================================
        Inventory Statistics
============================================================
Total Products:        15
Total Stock Units:     490
Total Inventory Value: 2,847,750.00
============================================================
```

### Low Stock Report
```
============================================================
           Low Stock Inventory Report
============================================================

Product ID  Product Name         Stock    Reorder Level
--------------------------------------------------------------
P1002       Keyboard             8        10
P1005       Printer              6        10
P1008       Mouse                5        15
P1012       Projector            3        5
P1014       Scanner              4        5
--------------------------------------------------------------

Low stock items found: 5
============================================================
```

### Category-Wise Report
```
============================================================
         Category-Wise Stock Report
============================================================

Category           Products   Total Stock   Avg Price     Total Value
---------------------------------------------------------------------
Electronics        5          53            22,140.00     1,107,000.00
Furniture          3          42            6,500.00      273,000.00
Office Equipment   3          20            4,100.00      82,000.00
Stationery         4          375           250.00        93,750.00
---------------------------------------------------------------------

Total Categories: 4
Grand Total Stock: 490
Grand Total Value: 1,555,750.00
============================================================
```

> **Note:** The above outputs are expected/illustrative samples. Actual output should be verified after running the programs in an SAP system.

---

## 14. Screenshots

No screenshots are included because the programs have not been executed in a live SAP system yet.

> **Important:** This project does not include fake SAP screenshots. Screenshots should only be added after actual execution in an SAP ABAP development environment.

See [SCREENSHOTS/README.md](SCREENSHOTS/README.md) for a list of recommended screenshots to capture.

---

## 15. Learning Outcomes

By building this project, you will learn:

1. ✅ How to design database tables in SAP Data Dictionary (SE11)
2. ✅ How to create Domains and Data Elements
3. ✅ How to write Open SQL statements (SELECT, INSERT)
4. ✅ How to use Internal Tables and Work Areas
5. ✅ How to build Selection Screens with parameters and checkboxes
6. ✅ How to create executable ABAP reports
7. ✅ How to implement business logic (low-stock detection)
8. ✅ How to calculate inventory statistics
9. ✅ How to modularize code using FORM/PERFORM
10. ✅ How to use basic Object-Oriented ABAP (CLASS/METHOD)
11. ✅ How to debug ABAP programs
12. ✅ How to aggregate data by categories

---

## 16. Future Enhancements

If you want to extend this project further:

1. **ALV Grid Display** — Replace WRITE statements with `cl_salv_table` for better formatting
2. **Stock Update Program** — Allow users to update stock quantities
3. **Supplier Report** — Join ZPRODUCT and ZSUPPLIER for a supplier-wise report
4. **Date Range Filtering** — Add date range parameters to stock movement report
5. **Authority Checks** — Add authorization objects for data access control
6. **SAP Smart Forms** — Generate printable inventory reports
7. **BDC/BAPI Integration** — Upload inventory data from Excel files
8. **CDS Views** — Create Core Data Services views on top of the tables (for SAP BTP)

---

## 17. SAP BTP ABAP Environment Notes

If running this project in SAP BTP ABAP Environment (Steampunk) instead of classic SAP GUI, the following adjustments may be needed:

| Area | Classic ABAP | SAP BTP ABAP | Change Needed |
|------|-------------|--------------|---------------|
| Table Creation | SE11 | ADT (Eclipse) or CDS | Use ABAP CDS to define tables |
| Program Creation | SE38 | ADT (Eclipse) | Create ABAP classes instead of reports |
| WRITE Statements | Supported | Not supported | Use `cl_salv_table` or Fiori UI |
| FORM/PERFORM | Supported | Deprecated | Use methods in classes |
| Selection Screen | Supported | Limited | Use ABAP classes with parameters |
| Debugger | SAP GUI Debugger | ADT Debugger | Same concepts, different tool |
| Package | $TMP | Custom ABAP Cloud package | Create a proper package |

> **Note:** The code in this project uses classic ABAP syntax. For SAP BTP ABAP Environment, the programs would need to be refactored into ABAP Cloud-compatible syntax (released APIs only, no WRITE, no FORM).

---

## Project Structure

```
SAP-ABAP-Inventory-Management/
│
├── README.md                              ← You are here
├── .gitignore
├── INTERVIEW_QUESTIONS.md                 ← 15 Q&As + Resume Description
│
├── ABAP/
│   ├── ZINVENTORY_TEST_DATA.abap          ← Sample data insertion
│   ├── ZINVENTORY_REPORT.abap             ← Main inventory report
│   ├── ZLOW_STOCK_REPORT.abap             ← Low stock alert report
│   ├── ZSTOCK_MOVEMENT_REPORT.abap        ← Stock movement report
│   └── ZCATEGORY_REPORT.abap              ← Category-wise analysis
│
├── TABLE/
│   ├── ZPRODUCT.md                        ← Product table definition
│   ├── ZSUPPLIER.md                       ← Supplier table definition
│   └── ZSTOCK_MOVEMENT.md                 ← Stock movement table definition
│
├── DOCUMENTATION/
│   ├── ABAP_CONCEPTS.md                   ← 16 ABAP concepts explained
│   ├── ARCHITECTURE.md                    ← Project architecture
│   ├── DATA_DICTIONARY.md                 ← Data Dictionary guide
│   ├── MODULARIZATION.md                  ← FORM/PERFORM explained
│   ├── OOP_ABAP.md                        ← Basic OOP ABAP explained
│   ├── DEBUGGING.md                       ← Step-by-step debugging guide
│   └── DATA_PROCESSING.md                 ← Data processing concepts
│
└── SCREENSHOTS/
    └── README.md                          ← Screenshot guidelines
```

---

## Author

**MCA Student** — SAP ABAP Trainee/Intern Candidate

This project was developed as a learning and portfolio project to demonstrate understanding of SAP ABAP fundamentals including Data Dictionary, Open SQL, Internal Tables, Modularization, and basic Object-Oriented ABAP.

---

## License

This project is for educational/portfolio purposes. Feel free to use it as a reference for learning SAP ABAP.

---

*Last updated: September 2026*
