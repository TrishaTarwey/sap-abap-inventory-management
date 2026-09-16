*&---------------------------------------------------------------------*
*& Report ZCATEGORY_REPORT
*&---------------------------------------------------------------------*
*& Category-Wise Stock Analysis
*&---------------------------------------------------------------------*
REPORT ZCATEGORY_REPORT.

* Define structure matching ZPRODUCT table
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

* Define structure for category summary
TYPES: BEGIN OF ty_category_summary,
         category      TYPE c LENGTH 20,
         product_count TYPE i,
         total_stock   TYPE i,
         total_value   TYPE p LENGTH 15 DECIMALS 2,
         avg_price     TYPE p LENGTH 8 DECIMALS 2,
       END OF ty_category_summary.

* Internal tables and work areas
DATA: it_products TYPE STANDARD TABLE OF ty_product,
      wa_product  TYPE ty_product.

DATA: it_category_summary TYPE STANDARD TABLE OF ty_category_summary,
      wa_summary          TYPE ty_category_summary.

* Variables for grand totals
DATA: v_total_categories TYPE i,
      v_grand_total_stock TYPE i,
      v_grand_total_value TYPE p LENGTH 15 DECIMALS 2.

START-OF-SELECTION.
* 1. Retrieve all products from ZPRODUCT
  SELECT product_id product_name category supplier_id unit_price stock_qty 
         reorder_level location status created_date
    FROM zproduct
    INTO TABLE it_products.

* 2. Aggregate data by CATEGORY
  LOOP AT it_products INTO wa_product.
    " Try to find existing category summary
    READ TABLE it_category_summary INTO wa_summary WITH KEY category = wa_product-category.
    
    IF sy-subrc = 0.
      " Update existing entry
      wa_summary-product_count = wa_summary-product_count + 1.
      wa_summary-total_stock   = wa_summary-total_stock + wa_product-stock_qty.
      wa_summary-total_value   = wa_summary-total_value + ( wa_product-unit_price * wa_product-stock_qty ).
      wa_summary-avg_price     = wa_summary-avg_price + wa_product-unit_price. " Accumulate total price for now
      
      " Modify the table entry
      MODIFY it_category_summary FROM wa_summary INDEX sy-tabix.
    ELSE.
      " Append a new entry
      wa_summary-category      = wa_product-category.
      wa_summary-product_count = 1.
      wa_summary-total_stock   = wa_product-stock_qty.
      wa_summary-total_value   = wa_product-unit_price * wa_product-stock_qty.
      wa_summary-avg_price     = wa_product-unit_price. " First item's price
      
      APPEND wa_summary TO it_category_summary.
    ENDIF.
  ENDLOOP.

* 3. Final calculations for each category (calculate averages)
  LOOP AT it_category_summary INTO wa_summary.
    " Calculate actual average price
    wa_summary-avg_price = wa_summary-avg_price / wa_summary-product_count.
    MODIFY it_category_summary FROM wa_summary INDEX sy-tabix.
    
    " Accumulate grand totals
    v_grand_total_stock = v_grand_total_stock + wa_summary-total_stock.
    v_grand_total_value = v_grand_total_value + wa_summary-total_value.
  ENDLOOP.

* Calculate total categories
  DESCRIBE TABLE it_category_summary LINES v_total_categories.

* 4. Display Output
  WRITE: / '============================================================'.
  WRITE: / '         Category-Wise Stock Report'.
  WRITE: / '============================================================'.
  WRITE: /.
  WRITE: / 'Category           Products   Total Stock   Avg Price     Total Value'.
  WRITE: / '---------------------------------------------------------------------'.

  LOOP AT it_category_summary INTO wa_summary.
    WRITE: / wa_summary-category      UNDER 'Category',
             wa_summary-product_count UNDER 'Products',
             wa_summary-total_stock   UNDER 'Total Stock',
             wa_summary-avg_price     UNDER 'Avg Price',
             wa_summary-total_value   UNDER 'Total Value'.
  ENDLOOP.

  WRITE: / '---------------------------------------------------------------------'.
  WRITE: /.
  WRITE: / 'Total Categories:', v_total_categories.
  WRITE: / 'Grand Total Stock:', v_grand_total_stock.
  WRITE: / 'Grand Total Value:', v_grand_total_value.
  WRITE: / '============================================================'.
