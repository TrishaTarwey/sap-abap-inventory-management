# SAP Table Definition: ZSUPPLIER

## 1. Overview

| Attribute | Value |
|---|---|
| **Table Name** | `ZSUPPLIER` |
| **Short Description** | Supplier Master Table |
| **Table Type** | Transparent Table |
| **Delivery Class** | `A` (Application table - master and transaction data) |
| **Data Browser/Table View Maint.** | Display/Maintenance Allowed |
| **Package** | `$TMP` (Local Object) or `ZINVENTORY` |
| **Software Component** | `HOME` |

The `ZSUPPLIER` table stores vendor and partner master details within the SAP ABAP Inventory Management system. It maintains core supplier profile attributes such as supplier identifier, company/vendor legal name, primary contact email address, telephone contact number, operational city location, and vendor lifecycle status (ACTIVE, INACTIVE, BLOCKED). It acts as the check table / parent entity for foreign keys defined in product master (`ZPRODUCT`).

---

## 2. Table Fields Definition

| Field Name | Key | Initial Values | Data Element | Domain | Data Type | Length | Decimals | Short Description |
|---|:---:|:---:|---|---|---|:---:|:---:|---|
| `MANDT` | **X** | X | `MANDT` | `MANDT` | CLNT | 3 | 0 | Client Identifier |
| `SUPPLIER_ID` | **X** | X | `ZSUPPLIER_ID` | `ZSUPPLIER_ID` | CHAR | 10 | 0 | Supplier Identifier |
| `SUPPLIER_NAME` | | | `ZSUPPLIER_NM` | `ZSUPPLIER_NM` | CHAR | 40 | 0 | Supplier / Vendor Name |
| `EMAIL` | | | `ZEMAIL` | `ZEMAIL` | CHAR | 50 | 0 | Contact Email Address |
| `PHONE` | | | `ZPHONE` | `ZPHONE` | CHAR | 15 | 0 | Contact Phone Number |
| `CITY` | | | `ZCITY` | `ZCITY` | CHAR | 20 | 0 | Supplier Location / City |
| `STATUS` | | | `ZSTATUS` | `ZSTATUS` | CHAR | 10 | 0 | Vendor Status (ACTIVE / INACTIVE / BLOCKED) |

---

## 3. Primary Key & Relationship Context

### Primary Key
- **Fields:** `MANDT` + `SUPPLIER_ID`
- Uniquely identifies each supplier record per SAP client.

### Dependent Tables
`ZSUPPLIER` acts as a check table for other application tables:
- **`ZPRODUCT`**: Field `ZPRODUCT-SUPPLIER_ID` references `ZSUPPLIER-SUPPLIER_ID`.

```
  +-----------------------+                    +--------------------+
  |       ZSUPPLIER       |                    |      ZPRODUCT      |
  +-----------------------+                    +--------------------+
  | MANDT       (PK)      |<--- 1:N Relation --| MANDT       (PK)   |
  | SUPPLIER_ID (PK)      |                    | PRODUCT_ID  (PK)   |
  | SUPPLIER_NAME         |                    | SUPPLIER_ID [FK]   |
  | EMAIL, PHONE, CITY... |                    | ...                |
  +-----------------------+                    +--------------------+
```

---

## 4. Technical Settings

Before activating `ZSUPPLIER`, configure the technical settings via SE11 (`Goto` -> `Technical Settings`):

| Setting Parameter | Value | Description / Rationale |
|---|---|---|
| **Data Class** | `APPL0` | Master data (transparent table, low mutation frequency) |
| **Size Category** | `0` | Expected record count: 0 to 8,000 records |
| **Buffering** | `Buffering not allowed` | Direct database reads/writes; no stale cache |
| **Buffering Type** | None | N/A |
| **Log Data Changes** | Optional / Checked | Enable if change tracking is needed |

---

## 5. Enhancement Category

To follow SAP dictionary standards:
- **Menu Path:** `Extras` -> `Enhancement Category...`
- **Option:** `Can be enhanced (character-type or numeric)`

---

## 6. Step-by-Step Creation Guide in Transaction SE11

### Step 1: Open ABAP Dictionary
1. Launch transaction `/nSE11` in the SAP GUI command field.
2. Select the **Database table** radio button.
3. Input table name: `ZSUPPLIER`.
4. Click the **Create** button (F5).

### Step 2: Set Attributes and Delivery Settings
1. In the **Short Description** field, enter: `Supplier Master Table`.
2. Navigate to the **Delivery and Maintenance** tab:
   - **Delivery Class**: Set to `A` (Application table - master and transaction data).
   - **Data Browser/Table View Maint.**: Select `Display/Maintenance Allowed`.

### Step 3: Populate Fields
1. Switch to the **Fields** tab.
2. Enter the field definitions:
   - Row 1: `MANDT` | Check `Key` | Check `Initial Values` | Data Element `MANDT`
   - Row 2: `SUPPLIER_ID` | Check `Key` | Check `Initial Values` | Data Element `ZSUPPLIER_ID`
   - Row 3: `SUPPLIER_NAME` | Data Element `ZSUPPLIER_NM`
   - Row 4: `EMAIL` | Data Element `ZEMAIL`
   - Row 5: `PHONE` | Data Element `ZPHONE`
   - Row 6: `CITY` | Data Element `ZCITY`
   - Row 7: `STATUS` | Data Element `ZSTATUS`
3. Save the table entries (`Ctrl+S`).

### Step 4: Configure Technical Settings
1. Click the **Technical Settings** icon (or press `Ctrl+Shift+F9`).
2. Specify the settings:
   - **Data class:** `APPL0`
   - **Size category:** `0`
   - **Buffering:** `Buffering not allowed`
3. Click **Save** (`Ctrl+S`) and press `F3` (Back).

### Step 5: Configure Enhancement Category
1. From the top menu bar, select `Extras` -> `Enhancement Category...`.
2. Choose **Can be enhanced (character-type or numeric)**.
3. Click **Copy** (Enter).

### Step 6: Consistency Check & Activation
1. Click the **Check** button (`Ctrl+F2`). Confirm that no syntax errors or warnings are reported.
2. Click the **Activate** button (`Ctrl+F3`).
3. In the activation popup dialog, confirm activation of `ZSUPPLIER`.
4. Verify the success message: `"Object ZSUPPLIER activated"`.

---

## 7. Optional: Table Maintenance Generator (TMG) Setup

To allow business users and administrators to maintain supplier records directly via transaction `SM30`:

1. In SE11, open `ZSUPPLIER` in display/change mode.
2. From the menu, select `Utilities` -> `Table Maintenance Generator`.
3. Enter parameters:
   - **Authorization Group:** `&NC&` (Without authorization group)
   - **Function Group:** `ZFG_SUPPLIER` (or create a dedicated function group)
   - **Maintenance Type:** `One step` (or `Two step`)
   - **Maintenance Screen No.:** Click **Find Screen Number(s)** or enter `100` (Overview screen).
4. Click **Create** (F6) and save.
5. Users can now maintain supplier data via Transaction `SM30` by entering table name `ZSUPPLIER`.

---

## 8. Equivalent ABAP Core Data Services (CDS) / DDL Definition

```sql
@EndUserText.label : 'Supplier Master Table'
@AbapCatalog.enhancement.category : #EXTENSIBLE_CHARACTER_NUMERIC
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zsupplier {
  key mandt        : mandt not null;
  key supplier_id  : zsupplier_id not null;
  supplier_name    : zsupplier_nm;
  email            : zemail;
  phone            : zphone;
  city             : zcity;
  status           : zstatus;
}
```
