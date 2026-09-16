*&---------------------------------------------------------------------*
*& Report ZLOW_STOCK_REPORT
*&---------------------------------------------------------------------*
*& Description: Executable ABAP report to display low stock products.
*& Logic: SELECT from ZPRODUCT WHERE stock_qty <= reorder_level
*&---------------------------------------------------------------------*
REPORT ZLOW_STOCK_REPORT.

*----------------------------------------------------------------------*
* Data Types Definition
*----------------------------------------------------------------------*
* Local structure matching the ZPRODUCT table fields
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

*----------------------------------------------------------------------*
* Global Data Declarations
*----------------------------------------------------------------------*
* Internal table and work area
DATA: gt_product TYPE STANDARD TABLE OF ty_product,
      gs_product TYPE ty_product,
      gv_count   TYPE i.

*----------------------------------------------------------------------*
* Main Program Execution
*----------------------------------------------------------------------*
START-OF-SELECTION.

  " Open SQL SELECT: fetch products where stock is at or below reorder level
  SELECT product_id product_name category supplier_id unit_price
         stock_qty reorder_level location status created_date
    FROM zproduct
    INTO TABLE gt_product
    WHERE stock_qty <= reorder_level.

  " Count low stock items found
  DESCRIBE TABLE gt_product LINES gv_count.

  " Display Header
  WRITE: / '============================================================'.
  WRITE: / '           Low Stock Inventory Report'.
  WRITE: / '============================================================'.
  SKIP.

  " Column Headers
  WRITE: /2 'Product ID', 14 'Product Name', 45 'Stock', 55 'Reorder Level'.
  WRITE: / '--------------------------------------------------------------'.

  " Loop through internal table to display each low stock item
  LOOP AT gt_product INTO gs_product.
    WRITE: /2 gs_product-product_id,
           14 gs_product-product_name,
           45 gs_product-stock_qty,
           55 gs_product-reorder_level.
  ENDLOOP.

  WRITE: / '--------------------------------------------------------------'.
  SKIP.
  
  " Display footer with total count
  WRITE: / 'Low stock items found:', gv_count.
  WRITE: / '============================================================'.
