# SAP Table Definition: ZSTOCK_MOVEMENT

## 1. Overview

| Attribute | Value |
|---|---|
| **Table Name** | `ZSTOCK_MOVEMENT` |
| **Short Description** | Stock Movement / Goods Transaction Table |
| **Table Type** | Transparent Table |
| **Delivery Class** | `A` (Application table - master and transaction data) |
| **Data Browser/Table View Maint.** | Display/Maintenance Allowed |
| **Package** | `$TMP` (Local Object) or `ZINVENTORY` |
| **Software Component** | `HOME` |

The `ZSTOCK_MOVEMENT` table captures transactional inventory activity in the SAP ABAP Inventory Management system. It maintains an immutable audit log of all goods movements (e.g., goods receipts, goods issues, internal transfers, and physical inventory adjustments), recording movement identifiers, involved product references, movement types, moved quantities, posting dates, and external reference document numbers (e.g., PO numbers, delivery notes, or manual adjustment slips).

---

## 2. Table Fields Definition

| Field Name | Key | Initial Values | Data Element | Domain | Data Type | Length | Decimals | Short Description |
|---|:---:|:---:|---|---|---|:---:|:---:|---|
| `MANDT` | **X** | X | `MANDT` | `MANDT` | CLNT | 3 | 0 | Client Identifier |
| `MOVEMENT_ID` | **X** | X | `ZMOVEMENT_ID` | `ZMOVEMENT_ID` | CHAR | 10 | 0 | Unique Movement Transaction ID |
| `PRODUCT_ID` | | | `ZPRODUCT_ID` | `ZPRODUCT_ID` | CHAR | 10 | 0 | Referenced Product Identifier |
| `MOVEMENT_TYPE` | | | `ZMOV_TYPE` | `ZMOV_TYPE` | CHAR | 3 | 0 | Movement Type (`IN` / `OUT` / `ADJ`) |
| `QUANTITY` | | | `ZQUANTITY` | `ZQUANTITY` | INT4 | 10 | 0 | Quantity Moved |
| `MOVEMENT_DATE` | | | `ZMOV_DATE` | `ZMOV_DATE` | DATS | 8 | 0 | Posting / Transaction Date |
| `REFERENCE_NO` | | | `ZREF_NO` | `ZREF_NO` | CHAR | 15 | 0 | Reference Document Number |

---

## 3. Primary Key & Foreign Key Relationships

### Primary Key
- **Fields:** `MANDT` + `MOVEMENT_ID`
- Uniquely identifies each movement entry per client.

### Foreign Key: `PRODUCT_ID` -> `ZPRODUCT`
Maintains referential integrity with the Product Master Table (`ZPRODUCT`):

- **Check Table:** `ZPRODUCT`
- **Short Text:** Foreign key link to Product Master Table
- **Field Assignment:**
  - `ZSTOCK_MOVEMENT-MANDT` -> `ZPRODUCT-MANDT`
  - `ZSTOCK_MOVEMENT-PRODUCT_ID` -> `ZPRODUCT-PRODUCT_ID`
- **Cardinality:**
  - Check Table: `1` (Exactly one product per ID in check table)
  - Dependent Table: `CN` (Zero, one, or many movements per product)
- **Foreign Key Field Type:** `Key fields/candidates`
- **Error Message:** `Product & does not exist in master table ZPRODUCT`

```
  +-----------------------+                    +--------------------+
  |    ZSTOCK_MOVEMENT    |                    |      ZPRODUCT      |
  +-----------------------+                    +--------------------+
  | MANDT       (PK)      |                    | MANDT       (PK)   |
  | MOVEMENT_ID (PK)      |                    | PRODUCT_ID  (PK)   |
  | PRODUCT_ID  [FK] -----+--- N:1 Relation -->| PRODUCT_NAME       |
  | MOVEMENT_TYPE         |                    | ...                |
  | QUANTITY              |                    +--------------------+
  | MOVEMENT_DATE         |
  | REFERENCE_NO          |
  +-----------------------+
```

---

## 4. Technical Settings

Before activating `ZSTOCK_MOVEMENT`, configure technical settings via SE11 (`Goto` -> `Technical Settings`):

| Setting Parameter | Value | Description / Rationale |
|---|---|---|
| **Data Class** | `APPL1` (or `APPL0`) | `APPL1` is standard for transaction data (frequently updated/appended) |
| **Size Category** | `0` or `1` | Expected record count: `0` (0 to 8,000) or `1` (8,000 to 30,000 records) |
| **Buffering** | `Buffering not allowed` | Transactional data must never be buffered to prevent stale stock updates |
| **Buffering Type** | None | N/A |
| **Log Data Changes** | Optional | Can be activated if individual audit logging is required |

---

## 5. Secondary Indexes (Performance Optimization)

Because transaction queries frequently aggregate or retrieve movement history by `PRODUCT_ID` and `MOVEMENT_DATE`, a secondary database index is recommended:

- **Index Name:** `Z01`
- **Short Description:** Index by Product and Movement Date
- **Fields:**
  1. `MANDT`
  2. `PRODUCT_ID`
  3. `MOVEMENT_DATE`
- **Unique Index:** No (Non-unique index)
- **Database System:** Selected for all database systems

---

## 6. Domain Specifications: `ZMOV_TYPE`

For data consistency, domain `ZMOV_TYPE` can be defined with fixed values:

| Fixed Value | Description |
|---|---|
| `IN` | Goods Receipt (Stock Inward) |
| `OUT` | Goods Issue (Stock Outward / Dispatch) |
| `ADJ` | Inventory Adjustment (Stock Reconcile) |

---

## 7. Step-by-Step Creation Guide in Transaction SE11

### Step 1: Open ABAP Dictionary
1. Launch transaction `/nSE11` in the SAP GUI command field.
2. Select the **Database table** radio button.
3. Input table name: `ZSTOCK_MOVEMENT`.
4. Click the **Create** button (F5).

### Step 2: Set Attributes and Delivery Settings
1. In the **Short Description** field, enter: `Stock Movement Table`.
2. Select the **Delivery and Maintenance** tab:
   - **Delivery Class**: `A` (Application table: Master and transaction data).
   - **Data Browser/Table View Maint.**: `Display/Maintenance Allowed`.

### Step 3: Populate Table Fields
1. Switch to the **Fields** tab.
2. Enter the field definitions:
   - Row 1: `MANDT` | Check `Key` | Check `Initial Values` | Data Element `MANDT`
   - Row 2: `MOVEMENT_ID` | Check `Key` | Check `Initial Values` | Data Element `ZMOVEMENT_ID`
   - Row 3: `PRODUCT_ID` | Data Element `ZPRODUCT_ID`
   - Row 4: `MOVEMENT_TYPE` | Data Element `ZMOV_TYPE`
   - Row 5: `QUANTITY` | Data Element `ZQUANTITY`
   - Row 6: `MOVEMENT_DATE` | Data Element `ZMOV_DATE`
   - Row 7: `REFERENCE_NO` | Data Element `ZREF_NO`
3. Save the table entries (`Ctrl+S`).

### Step 4: Configure Foreign Key for PRODUCT_ID
1. Position the cursor on the `PRODUCT_ID` field row.
2. Click the **Foreign Keys** button (Shift+F4 or key icon).
3. In the popup, enter check table: `ZPRODUCT`.
4. Click **Generate proposal**. The system maps:
   - `ZSTOCK_MOVEMENT-MANDT` = `ZPRODUCT-MANDT`
   - `ZSTOCK_MOVEMENT-PRODUCT_ID` = `ZPRODUCT-PRODUCT_ID`
5. Select Cardinality: `1 : CN`.
6. Confirm and click **Copy** (Enter).

### Step 5: Configure Technical Settings
1. Click the **Technical Settings** icon (or press `Ctrl+Shift+F9`).
2. Enter technical attributes:
   - **Data class:** `APPL1` (Transaction Data)
   - **Size category:** `0` (or `1`)
   - **Buffering:** Select `Buffering not allowed`
3. Click **Save** (`Ctrl+S`) and press `F3` (Back).

### Step 6: Configure Enhancement Category
1. From the top menu, choose `Extras` -> `Enhancement Category...`.
2. Select **Can be enhanced (character-type or numeric)**.
3. Click **Copy** (Enter).

### Step 7: Consistency Check & Activation
1. Click the **Check** button (`Ctrl+F2`). Verify message: `"Table ZSTOCK_MOVEMENT is consistent"`.
2. Click the **Activate** button (`Ctrl+F3`).
3. Confirm activation in the inactive objects list.
4. Verify the success message: `"Object ZSTOCK_MOVEMENT activated"`.

---

## 8. Equivalent ABAP Core Data Services (CDS) / DDL Definition

```sql
@EndUserText.label : 'Stock Movement Table'
@AbapCatalog.enhancement.category : #EXTENSIBLE_CHARACTER_NUMERIC
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zstock_movement {
  key mandt        : mandt not null;
  key movement_id  : zmovement_id not null;
  product_id       : zproduct_id;
  movement_type    : zmov_type;
  quantity         : zquantity;
  movement_date    : zmov_date;
  reference_no     : zref_no;
}
```
