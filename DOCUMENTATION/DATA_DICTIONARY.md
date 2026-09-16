# SAP Data Dictionary

## What is the SAP Data Dictionary?
The SAP Data Dictionary (DDIC) is the central repository of information about all the data in the SAP system. It allows us to manage and define database structures such as tables, views, and data types without writing database-specific SQL code. 

In this project, the Data Dictionary is used to define the tables that store our suppliers, products, and stock movements.

## Transparent Tables
Transparent tables are database tables defined in the SAP Data Dictionary. When you create a transparent table in SAP, it automatically creates a corresponding table in the underlying database with the exact same name and structure. We use transparent tables to store our business data.

The main tables in our project are:
- `ZSUPPLIER`: Stores supplier information.
- `ZPRODUCT`: Stores product details.
- `ZSTOCK_MOVEMENT`: Tracks inventory transactions (stock in/out).

## Domains
A Domain defines the technical attributes of a field, such as its data type and length. It can also define value ranges.
Examples from this project:
- **ZPRODUCT_ID**: Domain with type `CHAR` (Character string) and length `10`.
- **ZUNIT_PRICE**: Domain with type `DEC` (Decimal) and length `13` with `2` decimal places.

## Data Elements
A Data Element defines the semantic meaning of a field. It uses a Domain for its technical properties and adds descriptive text (labels) that appear on screens and reports.
For example, a Data Element `ZPRODUCT_NAME` might use a `CHAR 40` domain and have field labels like "Product Name" or "Prod.Name".

## Primary Keys
A Primary Key uniquely identifies a record in a table.
- In `ZSUPPLIER`, the primary key is `SUPPLIER_ID`.
- In `ZPRODUCT`, the primary key is `PRODUCT_ID`.
- In `ZSTOCK_MOVEMENT`, the primary key is `MOVEMENT_ID`.

## Foreign Key Relationships
Foreign keys link tables together to ensure data integrity. They guarantee that a value entered in one table must exist in another.

```
ZSUPPLIER (SUPPLIER_ID)
     |
     | 1:N
     ↓
ZPRODUCT (SUPPLIER_ID → ZSUPPLIER)
     |
     | 1:N
     ↓
ZSTOCK_MOVEMENT (PRODUCT_ID → ZPRODUCT)
```
- A Product must belong to a valid Supplier.
- A Stock Movement must reference a valid Product.

## Data Types Used
Common data types used in our tables:
- **CHAR**: Character string (e.g., Names, IDs).
- **DEC**: Decimal number (e.g., Prices, Amounts).
- **INT4**: 4-byte integer (e.g., Quantities).
- **DATS**: Date format (YYYYMMDD).
- **CLNT**: Client (used to separate data between different tenants in SAP, typically the `MANDT` field).

## How to Create These Objects in SE11
Transaction **SE11** is the ABAP Dictionary tool. To create an object:
1. Go to transaction SE11.
2. Select the object type (e.g., Domain, Data type, Database table).
3. Enter the name (starting with 'Z' or 'Y' for custom objects).
4. Click **Create**.
5. Fill in the required technical attributes and short descriptions.
6. Save and assign to a package (or save as Local Object).

## Activation Process
In SAP, creating an object is not enough; it must be **Activated** to be usable by other programs and to create the actual database objects.
1. Click the Activate button (or press `Ctrl+F3`) after saving.
2. Resolve any errors or warnings.
3. Once activated, the object is ready to be used.
