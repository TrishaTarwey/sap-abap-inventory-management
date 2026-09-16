# SAP Table Definition: ZPRODUCT

## 1. Overview

| Attribute | Value |
|---|---|
| **Table Name** | `ZPRODUCT` |
| **Short Description** | Product Master Table |
| **Table Type** | Transparent Table |
| **Delivery Class** | `A` (Application table - master and transaction data) |
| **Data Browser/Table View Maint.** | Display/Maintenance Allowed |
| **Package** | `$TMP` (Local Object) or `ZINVENTORY` |
| **Software Component** | `HOME` |

The `ZPRODUCT` table serves as the primary master data entity in the SAP ABAP Inventory Management system. It stores master records for all inventoried items, including SKU identifiers, naming, categorical classification, supplier associations, financial valuation (unit price), current on-hand quantities, reorder thresholds, physical warehouse storage locations, and operational statuses.

---

## 2. Table Fields Definition

| Field Name | Key | Initial Values | Data Element | Domain | Data Type | Length | Decimals | Short Description |
|---|:---:|:---:|---|---|---|:---:|:---:|---|
| `MANDT` | **X** | X | `MANDT` | `MANDT` | CLNT | 3 | 0 | Client Identifier |
| `PRODUCT_ID` | **X** | X | `ZPRODUCT_ID` | `ZPRODUCT_ID` | CHAR | 10 | 0 | Unique Product Identifier |
| `PRODUCT_NAME` | | | `ZPRODUCT_NAME` | `ZPRODUCT_NAME` | CHAR | 40 | 0 | Product Description / Name |
| `CATEGORY` | | | `ZCATEGORY` | `ZCATEGORY` | CHAR | 20 | 0 | Product Category (e.g., RAW, FIN, SEMI) |
| `SUPPLIER_ID` | | | `ZSUPPLIER_ID` | `ZSUPPLIER_ID` | CHAR | 10 | 0 | Associated Supplier ID |
| `UNIT_PRICE` | | | `ZUNIT_PRICE` | `ZUNIT_PRICE` | DEC | 13 | 2 | Standard Unit Price |
| `STOCK_QTY` | | | `ZSTOCK_QTY` | `ZSTOCK_QTY` | INT4 | 10 | 0 | Current On-Hand Stock Quantity |
| `REORDER_LEVEL` | | | `ZREORDER_LVL` | `ZREORDER_LVL` | INT4 | 10 | 0 | Minimum Reorder Level Threshold |
| `LOCATION` | | | `ZLOCATION` | `ZLOCATION` | CHAR | 20 | 0 | Storage Location / Bin |
| `STATUS` | | | `ZSTATUS` | `ZSTATUS` | CHAR | 10 | 0 | Status (ACTIVE/INACTIVE) |
| `CREATED_DATE` | | | `ZCREATED_DT` | `ZCREATED_DT` | DATS | 8 | 0 | Record Creation Date |

---

## 3. Primary Key & Foreign Key Relationships

### Primary Key
- **Fields:** `MANDT` + `PRODUCT_ID`
- Uniquely identifies each product record per client instance.

### Foreign Key: `SUPPLIER_ID` -> `ZSUPPLIER`
To maintain referential integrity with the Supplier Master Table (`ZSUPPLIER`):

- **Check Table:** `ZSUPPLIER`
- **Short Text:** Foreign key link to Supplier Master Table
- **Field Assignment:**
  - `ZPRODUCT-MANDT` -> `ZSUPPLIER-MANDT`
  - `ZPRODUCT-SUPPLIER_ID` -> `ZSUPPLIER-SUPPLIER_ID`
- **Cardinality:**
  - Check Table: `1` (Exactly one supplier per ID in check table)
  - Dependent Table: `CN` (Zero, one, or many products per supplier)
- **Foreign Key Field Type:** `Key fields/candidates`
- **Error Message:** `Supplier & does not exist in master table ZSUPPLIER`

```
  +--------------------+                     +--------------------+
  |      ZPRODUCT      |                     |     ZSUPPLIER      |
  +--------------------+                     +--------------------+
  | MANDT       (PK)   |                     | MANDT       (PK)   |
  | PRODUCT_ID  (PK)   |                     | SUPPLIER_ID (PK)   |
  | ...                |                     | SUPPLIER_NAME      |
  | SUPPLIER_ID [FK] --+--- 1:N Relation --->| ...                |
  +--------------------+                     +--------------------+
```

---

## 4. Technical Settings

Before table activation, technical settings must be maintained in SE11 (`Goto` -> `Technical Settings`):

| Setting Parameter | Value | Description / Rationale |
|---|---|---|
| **Data Class** | `APPL0` | Master data (transparent tables, infrequently modified structure) |
| **Size Category** | `0` | Expected record count: 0 to 8,000 records |
| **Buffering** | `Buffering not allowed` | Direct database read/write consistency |
| **Buffering Type** | None | N/A |
| **Log Data Changes** | Unchecked / Optional | Table logging for audit requirements |

---

## 5. Enhancement Category

To ensure standard SAP upgrade compliance:
- **Menu Path:** `Extras` -> `Enhancement Category...`
- **Selection:** `Can be enhanced (character-type or numeric)`

---

## 6. Step-by-Step Creation Guide in Transaction SE11

### Step 1: Access ABAP Dictionary
1. In the SAP GUI Command field, enter transaction code `/nSE11` and press `Enter`.
2. Select the **Database table** radio button.
3. Enter table name: `ZPRODUCT`.
4. Click the **Create** button (F5).

### Step 2: Maintain Delivery and Maintenance Attributes
1. In the **Short Description** field, enter: `Product Master Table`.
2. Navigate to the **Delivery and Maintenance** tab:
   - Set **Delivery Class**: `A` (Application table: Master and transaction data).
   - Set **Data Browser/Table View Maint.**: `Display/Maintenance Allowed`.

### Step 3: Define Table Fields
1. Switch to the **Fields** tab.
2. Enter the field rows sequentially:
   - Row 1: `MANDT` | Check `Key` | Check `Initial Values` | Data Element `MANDT`
   - Row 2: `PRODUCT_ID` | Check `Key` | Check `Initial Values` | Data Element `ZPRODUCT_ID`
   - Row 3: `PRODUCT_NAME` | Data Element `ZPRODUCT_NAME`
   - Row 4: `CATEGORY` | Data Element `ZCATEGORY`
   - Row 5: `SUPPLIER_ID` | Data Element `ZSUPPLIER_ID`
   - Row 6: `UNIT_PRICE` | Data Element `ZUNIT_PRICE`
   - Row 7: `STOCK_QTY` | Data Element `ZSTOCK_QTY`
   - Row 8: `REORDER_LEVEL` | Data Element `ZREORDER_LVL`
   - Row 9: `LOCATION` | Data Element `ZLOCATION`
   - Row 10: `STATUS` | Data Element `ZSTATUS`
   - Row 11: `CREATED_DATE` | Data Element `ZCREATED_DT`
3. Save your entries (`Ctrl+S`).

### Step 4: Configure Foreign Key for SUPPLIER_ID
1. On the **Fields** tab, position cursor on the `SUPPLIER_ID` row.
2. Click the **Foreign Keys** button (Shift+F4 or key icon).
3. In the popup dialog, enter check table: `ZSUPPLIER`.
4. Click **Generate proposal**. Verify field mapping:
   - `ZPRODUCT-MANDT` = `ZSUPPLIER-MANDT`
   - `ZPRODUCT-SUPPLIER_ID` = `ZSUPPLIER-SUPPLIER_ID`
5. Set Cardinality: `1 : CN`.
6. Click **Copy** (Enter).

### Step 5: Maintain Technical Settings
1. Click the **Technical Settings** icon on the application toolbar (or menu `Goto` -> `Technical Settings` / `Ctrl+Shift+F9`).
2. Enter the following parameters:
   - **Data class:** `APPL0`
   - **Size category:** `0`
   - **Buffering:** Select `Buffering not allowed`
3. Click **Save** (Ctrl+S) and return (F3).

### Step 6: Maintain Enhancement Category
1. From the top menu, choose `Extras` -> `Enhancement Category...`.
2. Acknowledge the information dialog.
3. Select **Can be enhanced (character-type or numeric)**.
4. Click **Copy** (Enter).

### Step 7: Consistency Check and Activation
1. Click the **Check** button (Ctrl+F2) to perform syntax verification. Confirm message: `"Table ZPRODUCT is consistent"`.
2. Click the **Activate** button (Ctrl+F3).
3. If prompted with the inactive objects list, ensure `ZPRODUCT` is checked and press **Continue** (Enter).
4. Verify status bar displays: `"Object ZPRODUCT activated"`.

---

## 7. Equivalent ABAP Core Data Services (CDS) / DDL Definition

```sql
@EndUserText.label : 'Product Master Table'
@AbapCatalog.enhancement.category : #EXTENSIBLE_CHARACTER_NUMERIC
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zproduct {
  key mandt        : mandt not null;
  key product_id   : zproduct_id not null;
  product_name     : zproduct_name;
  category         : zcategory;
  supplier_id      : zsupplier_id;
  unit_price       : zunit_price;
  stock_qty        : zstock_qty;
  reorder_level    : zreorder_lvl;
  location         : zlocation;
  status           : zstatus;
  created_date     : zcreated_dt;
}
```
