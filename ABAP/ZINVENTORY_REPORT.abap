*&---------------------------------------------------------------------*
*& Report ZINVENTORY_REPORT
*&---------------------------------------------------------------------*
*& Description: Main executable ABAP report for Inventory Management.
*& It features dynamic selection, modularization with FORM routines,
*& and Object-Oriented ABAP (OO ABAP) for statistics calculation.
*&---------------------------------------------------------------------*
REPORT ZINVENTORY_REPORT.

*----------------------------------------------------------------------*
* Data Types Definition
*----------------------------------------------------------------------*
* Define a local structure matching the ZPRODUCT table fields
TYPES: BEGIN OF ty_product,
         product_id    TYPE c LENGTH 10,
         product_name  TYPE c LENGTH 40,
         category      TYPE c LENGTH 20,
         supplier_id   TYPE c LENGTH 10,
         unit_price    TYPE p LENGTH 8 DECIMALS 2,
         stock_qty     TYPE i,
         reorder_level TYPE i,
         location      TYPE c LENGTH 20,
         status        TYPE c LENGTH 10,
         created_date  TYPE dats,
       END OF ty_product.

* Define table type for internal table
TYPES: tt_product TYPE STANDARD TABLE OF ty_product WITH DEFAULT KEY.

*----------------------------------------------------------------------*
* Global Data Declarations
*----------------------------------------------------------------------*
* Internal table and work area for product data
DATA: gt_product TYPE tt_product,
      gs_product TYPE ty_product.

* Variables for statistics
DATA: gv_total_products TYPE i,
      gv_total_stock    TYPE i,
      gv_total_value    TYPE p LENGTH 15 DECIMALS 2.

*----------------------------------------------------------------------*
* Selection Screen
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  PARAMETERS: p_prodid TYPE c LENGTH 10,
              p_categ  TYPE c LENGTH 20,
              p_status TYPE c LENGTH 10,
              p_low    TYPE c AS CHECKBOX. " Low Stock Only
SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* Local Classes (OO ABAP Demonstration)
*----------------------------------------------------------------------*
* Class Definition
CLASS lcl_inventory DEFINITION.
  PUBLIC SECTION.
    " Constructor accepts internal table of products
    METHODS: constructor IMPORTING it_product TYPE tt_product,
             get_total_products RETURNING VALUE(rv_count) TYPE i,
             get_total_stock RETURNING VALUE(rv_stock) TYPE i,
             calculate_total_value RETURNING VALUE(rv_value) TYPE p LENGTH 15 DECIMALS 2.
  PRIVATE SECTION.
    DATA: mt_product TYPE tt_product. " Class attribute to hold data
ENDCLASS.

* Class Implementation
CLASS lcl_inventory IMPLEMENTATION.
  METHOD constructor.
    mt_product = it_product.
  ENDMETHOD.

  METHOD get_total_products.
    DESCRIBE TABLE mt_product LINES rv_count.
  ENDMETHOD.

  METHOD get_total_stock.
    DATA: ls_prod TYPE ty_product.
    rv_stock = 0.
    LOOP AT mt_product INTO ls_prod.
      rv_stock = rv_stock + ls_prod-stock_qty.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculate_total_value.
    DATA: ls_prod TYPE ty_product.
    rv_value = 0.
    LOOP AT mt_product INTO ls_prod.
      rv_value = rv_value + ( ls_prod-unit_price * ls_prod-stock_qty ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

* Object reference for the class
DATA: go_inventory TYPE REF TO lcl_inventory.

*----------------------------------------------------------------------*
* Main Program Execution
*----------------------------------------------------------------------*
START-OF-SELECTION.

  " 1. Get Inventory Data using FORM routine
  PERFORM get_inventory_data.

  " 2. Display the inventory list
  PERFORM display_inventory.

  " 3. Calculate statistics using Object-Oriented approach
  CREATE OBJECT go_inventory
    EXPORTING
      it_product = gt_product.

  gv_total_products = go_inventory->get_total_products( ).
  gv_total_stock    = go_inventory->get_total_stock( ).
  gv_total_value    = go_inventory->calculate_total_value( ).

  " 4. Display Statistics
  PERFORM display_statistics.

*----------------------------------------------------------------------*
* FORM Routines (Procedural Modularization)
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form get_inventory_data
*&---------------------------------------------------------------------*
*& Retrieves data from the database table (simulated with local structure)
*&---------------------------------------------------------------------*
FORM get_inventory_data.
  " Build Open SQL SELECT based on user's selection screen input.
  " All parameters are optional, so we handle combinations with IF/ELSEIF.

  " --- Case 1: All filters provided ---
  IF p_prodid IS NOT INITIAL AND p_categ IS NOT INITIAL AND p_status IS NOT INITIAL.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product
      WHERE product_id = p_prodid
        AND category   = p_categ
        AND status     = p_status.

  " --- Case 2: Product ID + Category ---
  ELSEIF p_prodid IS NOT INITIAL AND p_categ IS NOT INITIAL.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product
      WHERE product_id = p_prodid
        AND category   = p_categ.

  " --- Case 3: Product ID + Status ---
  ELSEIF p_prodid IS NOT INITIAL AND p_status IS NOT INITIAL.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product
      WHERE product_id = p_prodid
        AND status     = p_status.

  " --- Case 4: Category + Status ---
  ELSEIF p_categ IS NOT INITIAL AND p_status IS NOT INITIAL.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product
      WHERE category = p_categ
        AND status   = p_status.

  " --- Case 5: Only Product ID ---
  ELSEIF p_prodid IS NOT INITIAL.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product
      WHERE product_id = p_prodid.

  " --- Case 6: Only Category ---
  ELSEIF p_categ IS NOT INITIAL.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product
      WHERE category = p_categ.

  " --- Case 7: Only Status ---
  ELSEIF p_status IS NOT INITIAL.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product
      WHERE status = p_status.

  " --- Case 8: No filters — select all ---
  ELSE.
    SELECT product_id product_name category supplier_id unit_price
           stock_qty reorder_level location status created_date
      FROM zproduct
      INTO TABLE gt_product.
  ENDIF.

  " If 'Low Stock Only' checkbox is checked, remove products
  " where stock is above the reorder level (keep only low-stock items)
  IF p_low = 'X'.
    DELETE gt_product WHERE stock_qty > reorder_level.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form display_inventory
*&---------------------------------------------------------------------*
*& Displays the internal table data in a clean list report
*&---------------------------------------------------------------------*
FORM display_inventory.
  WRITE: / '============================================================'.
  WRITE: / '        SAP ABAP Inventory Management Report'.
  WRITE: / '============================================================'.
  SKIP.
  
  " Column Headers
  WRITE: /2 'Product ID', 14 'Product Name', 35 'Category', 52 'Stock', 60 'Price'.
  WRITE: / '--------------------------------------------------------------'.

  " Process each record in the internal table
  LOOP AT gt_product INTO gs_product.
    WRITE: /2 gs_product-product_id,
           14 gs_product-product_name,
           35 gs_product-category,
           52 gs_product-stock_qty,
           60 gs_product-unit_price.
  ENDLOOP.
  
  WRITE: / '--------------------------------------------------------------'.
  SKIP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form calculate_inventory_value
*&---------------------------------------------------------------------*
*& Procedural calculation approach (demonstration alongside OO approach)
*&---------------------------------------------------------------------*
FORM calculate_inventory_value.
  CLEAR gv_total_value.
  LOOP AT gt_product INTO gs_product.
    gv_total_value = gv_total_value + ( gs_product-unit_price * gs_product-stock_qty ).
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form display_statistics
*&---------------------------------------------------------------------*
*& Displays the calculated statistics at the bottom of the report
*&---------------------------------------------------------------------*
FORM display_statistics.
  WRITE: / '============================================================'.
  WRITE: / '        Inventory Statistics'.
  WRITE: / '============================================================'.
  WRITE: / 'Total Products:       ', gv_total_products.
  WRITE: / 'Total Stock Units:    ', gv_total_stock.
  WRITE: / 'Total Inventory Value:', gv_total_value.
  WRITE: / '============================================================'.
ENDFORM.
