# ABAP Concepts Reference

**1. Data Dictionary**
- **Meaning:** Central repository for data definitions.
- **Used:** `ZPRODUCT`, `ZSUPPLIER`, `ZSTOCK_MOVEMENT` tables.
- **Example:** Accessed via transaction SE11.

**2. Transparent Table**
- **Meaning:** Database table created via SE11, directly mapping to the database.
- **Used:** All 3 custom Z tables in this project.
- **Example:** Table `ZPRODUCT` storing product details.

**3. Data Element**
- **Meaning:** Describes the semantic meaning of a field.
- **Used:** `ZPRODUCT_ID`, `ZSUPPLIER_ID`.
- **Example:** A data element `ZPRODUCT_ID` associated with domain `CHAR 10`.

**4. Domain**
- **Meaning:** Defines technical attributes like data type and length.
- **Used:** `CHAR 10` for IDs, `DEC 13,2` for prices.
- **Example:** Domain for price defines 13 digits with 2 decimal places.

**5. Open SQL**
- **Meaning:** ABAP's database-independent SQL interface.
- **Used:** `SELECT` statements in all reports.
- **Example:** `SELECT * FROM zproduct...`

**6. Internal Table**
- **Meaning:** In-memory table in ABAP used to hold multiple records during execution.
- **Used:** `lt_product` to store fetched product data.
- **Example:** `DATA: lt_product TYPE TABLE OF zproduct.`

**7. Work Area**
- **Meaning:** Single-row structure used for row-by-row processing of internal tables.
- **Used:** `ls_product` in `LOOP` processing.
- **Example:** `DATA: ls_product TYPE zproduct.`

**8. Selection Screen**
- **Meaning:** User input screen for providing parameters to reports.
- **Used:** `ZINVENTORY_REPORT` parameters.
- **Example:** `PARAMETERS: p_categ TYPE zproduct-category.`

**9. SELECT**
- **Meaning:** Open SQL statement to read data from database tables.
- **Used:** Fetching data into internal tables.
- **Example:** `SELECT * FROM zproduct INTO TABLE lt_product.`

**10. WHERE**
- **Meaning:** Filter condition in a `SELECT` statement.
- **Used:** Filtering data by category.
- **Example:** `SELECT * ... WHERE category = p_categ.`

**11. LOOP**
- **Meaning:** Statement that iterates over rows of an internal table.
- **Used:** Processing each fetched product.
- **Example:** `LOOP AT lt_product INTO ls_product. ... ENDLOOP.`

**12. Modularization**
- **Meaning:** Breaking code into smaller, reusable units.
- **Used:** `FORM` routines in `ZINVENTORY_REPORT`.
- **Example:** Separating logic into data retrieval and output blocks.

**13. FORM**
- **Meaning:** Subroutine definition used for modularization.
- **Used:** `FORM get_inventory_data`.
- **Example:** `FORM get_data. ... ENDFORM.`

**14. PERFORM**
- **Meaning:** Statement used to call a `FORM` subroutine.
- **Used:** Calling subroutines from the main program block.
- **Example:** `PERFORM get_data.`

**15. Basic OOP ABAP**
- **Meaning:** Object-oriented programming using classes and methods in ABAP.
- **Used:** `lcl_inventory` class encapsulating logic.
- **Example:** `CLASS lcl_inventory DEFINITION. ... ENDCLASS.`

**16. Debugging**
- **Meaning:** Finding and fixing errors by stepping through code.
- **Used:** Setting breakpoints, inspecting variables during execution.
- **Example:** Setting a breakpoint at `SELECT` and checking `sy-subrc`.
