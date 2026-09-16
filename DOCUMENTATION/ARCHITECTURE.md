# Project Architecture

## Overall Flow

The inventory management system follows a simple report-based architecture in SAP ABAP. Here is how the data flows from the user to the database and back:

```text
User
 ↓
Selection Screen (Parameters/Checkboxes)
 ↓
ABAP Report (ZINVENTORY_REPORT)
 ↓
Open SQL (SELECT statements)
 ↓
SAP Data Dictionary Tables (ZPRODUCT, ZSUPPLIER, ZSTOCK_MOVEMENT)
 ↓
Internal Tables (lt_product, lt_supplier, etc.)
 ↓
Business Logic (FORM routines / Class methods)
 ↓
Inventory Report Output (WRITE statements)
```

### Explanation of the Layers

1. **User / Selection Screen**: The user runs the program and is presented with a selection screen. They can enter parameters like Product ID ranges or Suppliers to filter the data.
2. **ABAP Report**: The main program starts executing based on the user's inputs.
3. **Open SQL**: The report uses ABAP Open SQL to request data. Open SQL is database-independent, meaning SAP translates it into the native SQL of the underlying database.
4. **Data Dictionary Tables**: These are the physical database tables where the inventory data is stored.
5. **Internal Tables**: The retrieved data is brought into the program's memory and stored in Internal Tables. These are temporary data structures that exist only while the program is running.
6. **Business Logic**: The program processes the internal tables. It calculates totals, checks stock levels, and prepares the data for display. This logic is separated into modular units like FORM routines or Classes.
7. **Output**: Finally, the processed data is displayed to the user using the classic ABAP `WRITE` statements (or modern ALV grids in advanced scenarios).

## Database Relationship

The system relies on three core tables linked in a hierarchical manner:

```text
ZSUPPLIER
    ↓ (SUPPLIER_ID)
ZPRODUCT
    ↓ (PRODUCT_ID)
ZSTOCK_MOVEMENT
```
- **ZSUPPLIER**: Master data for suppliers.
- **ZPRODUCT**: Master data for products. Each product is linked to one supplier.
- **ZSTOCK_MOVEMENT**: Transactional data for inventory. Every movement (in or out) is linked to a specific product.

## Programs Included in the Project

- **ZINVENTORY_TEST_DATA**: A utility program used to insert sample (dummy) data into the database tables for testing purposes.
- **ZINVENTORY_REPORT**: The main inventory report that displays current stock levels and calculates statistics such as total inventory value.
- **ZLOW_STOCK_REPORT**: A specialized report that alerts the user about products whose stock has fallen below a safe threshold.
- **ZSTOCK_MOVEMENT_REPORT**: A report to track all historical stock movements (goods receipts and issues) for specific products or timeframes.
- **ZCATEGORY_REPORT**: An analytical report that breaks down inventory levels and values by product category.
