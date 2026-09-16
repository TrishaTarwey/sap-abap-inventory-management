*&---------------------------------------------------------------------*
*& Report ZINVENTORY_TEST_DATA
*&---------------------------------------------------------------------*
*& Description: Inserts sample test data into ZPRODUCT, ZSUPPLIER, and
*&              ZSTOCK_MOVEMENT tables.
*&---------------------------------------------------------------------*
REPORT ZINVENTORY_TEST_DATA.

*----------------------------------------------------------------------*
* Selection Screen
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_insert RADIOBUTTON GROUP g1 DEFAULT 'X', " Insert Data
            p_reset  RADIOBUTTON GROUP g1.             " Reset Data (Test Only)
SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* Data Declarations
*----------------------------------------------------------------------*
DATA: lt_suppliers TYPE TABLE OF zsupplier,
      ls_supplier  TYPE zsupplier,
      lt_products  TYPE TABLE OF zproduct,
      ls_product   TYPE zproduct,
      lt_movements TYPE TABLE OF zstock_movement,
      ls_movement  TYPE zstock_movement.

*----------------------------------------------------------------------*
* Start of Selection
*----------------------------------------------------------------------*
START-OF-SELECTION.

  IF p_reset = 'X'.
    PERFORM reset_data.
  ELSE.
    PERFORM insert_data.
  ENDIF.

*----------------------------------------------------------------------*
* Form insert_data
*----------------------------------------------------------------------*
FORM insert_data.
  " Clear tables before populating
  CLEAR: lt_suppliers, lt_products, lt_movements.

  " --------------------------------------------------------------------
  " 1. Populate Suppliers
  " --------------------------------------------------------------------
  ls_supplier-supplier_id = 'S1001'.
  ls_supplier-supplier_name = 'TechWorld Supplies'.
  ls_supplier-email = 'techworld@email.com'.
  ls_supplier-phone = '9876543210'.
  ls_supplier-city = 'Noida'.
  ls_supplier-status = 'ACTIVE'.
  APPEND ls_supplier TO lt_suppliers.

  ls_supplier-supplier_id = 'S1002'.
  ls_supplier-supplier_name = 'Office Mart'.
  ls_supplier-email = 'officemart@email.com'.
  ls_supplier-phone = '9876543211'.
  ls_supplier-city = 'Delhi'.
  ls_supplier-status = 'ACTIVE'.
  APPEND ls_supplier TO lt_suppliers.

  ls_supplier-supplier_id = 'S1003'.
  ls_supplier-supplier_name = 'FurniPro India'.
  ls_supplier-email = 'furnipro@email.com'.
  ls_supplier-phone = '9876543212'.
  ls_supplier-city = 'Mumbai'.
  ls_supplier-status = 'ACTIVE'.
  APPEND ls_supplier TO lt_suppliers.

  ls_supplier-supplier_id = 'S1004'.
  ls_supplier-supplier_name = 'PrintTech Solutions'.
  ls_supplier-email = 'printtech@email.com'.
  ls_supplier-phone = '9876543213'.
  ls_supplier-city = 'Bangalore'.
  ls_supplier-status = 'ACTIVE'.
  APPEND ls_supplier TO lt_suppliers.

  ls_supplier-supplier_id = 'S1005'.
  ls_supplier-supplier_name = 'StationeryHub'.
  ls_supplier-email = 'stationeryhub@email.com'.
  ls_supplier-phone = '9876543214'.
  ls_supplier-city = 'Pune'.
  ls_supplier-status = 'INACTIVE'.
  APPEND ls_supplier TO lt_suppliers.

  " Insert Suppliers
  TRY.
      INSERT zsupplier FROM TABLE lt_suppliers ACCEPTING DUPLICATE KEYS.
      IF sy-subrc = 0.
        WRITE: / 'Suppliers inserted successfully.'.
      ELSE.
        WRITE: / 'Some suppliers might already exist or insert failed.'.
      ENDIF.
    CATCH cx_sy_open_sql_db.
      WRITE: / 'Error inserting suppliers.'.
  ENDTRY.

  " --------------------------------------------------------------------
  " 2. Populate Products
  " --------------------------------------------------------------------
  CLEAR ls_product.
  ls_product-product_id = 'P1001'. ls_product-product_name = 'Laptop'. ls_product-category = 'Electronics'. ls_product-supplier_id = 'S1001'. ls_product-unit_price = '55000.00'. ls_product-stock_qty = 25. ls_product-reorder_level = 10. ls_product-location = 'Noida'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1002'. ls_product-product_name = 'Keyboard'. ls_product-category = 'Electronics'. ls_product-supplier_id = 'S1001'. ls_product-unit_price = '1200.00'. ls_product-stock_qty = 8. ls_product-reorder_level = 10. ls_product-location = 'Noida'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1003'. ls_product-product_name = 'Office Chair'. ls_product-category = 'Furniture'. ls_product-supplier_id = 'S1003'. ls_product-unit_price = '6500.00'. ls_product-stock_qty = 15. ls_product-reorder_level = 5. ls_product-location = 'Mumbai'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1004'. ls_product-product_name = 'Monitor'. ls_product-category = 'Electronics'. ls_product-supplier_id = 'S1001'. ls_product-unit_price = '18000.00'. ls_product-stock_qty = 12. ls_product-reorder_level = 8. ls_product-location = 'Noida'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1005'. ls_product-product_name = 'Printer'. ls_product-category = 'Office Equipment'. ls_product-supplier_id = 'S1004'. ls_product-unit_price = '12000.00'. ls_product-stock_qty = 6. ls_product-reorder_level = 10. ls_product-location = 'Bangalore'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1006'. ls_product-product_name = 'Desk Lamp'. ls_product-category = 'Office Equipment'. ls_product-supplier_id = 'S1002'. ls_product-unit_price = '800.00'. ls_product-stock_qty = 30. ls_product-reorder_level = 15. ls_product-location = 'Delhi'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1007'. ls_product-product_name = 'Notebook (Paper)'. ls_product-category = 'Stationery'. ls_product-supplier_id = 'S1005'. ls_product-unit_price = '150.00'. ls_product-stock_qty = 100. ls_product-reorder_level = 50. ls_product-location = 'Pune'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1008'. ls_product-product_name = 'Mouse'. ls_product-category = 'Electronics'. ls_product-supplier_id = 'S1001'. ls_product-unit_price = '500.00'. ls_product-stock_qty = 5. ls_product-reorder_level = 15. ls_product-location = 'Noida'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1009'. ls_product-product_name = 'Whiteboard'. ls_product-category = 'Office Equipment'. ls_product-supplier_id = 'S1002'. ls_product-unit_price = '2500.00'. ls_product-stock_qty = 10. ls_product-reorder_level = 5. ls_product-location = 'Delhi'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1010'. ls_product-product_name = 'Filing Cabinet'. ls_product-category = 'Furniture'. ls_product-supplier_id = 'S1003'. ls_product-unit_price = '8500.00'. ls_product-stock_qty = 7. ls_product-reorder_level = 5. ls_product-location = 'Mumbai'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1011'. ls_product-product_name = 'Pen Set'. ls_product-category = 'Stationery'. ls_product-supplier_id = 'S1005'. ls_product-unit_price = '250.00'. ls_product-stock_qty = 200. ls_product-reorder_level = 100. ls_product-location = 'Pune'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1012'. ls_product-product_name = 'Projector'. ls_product-category = 'Electronics'. ls_product-supplier_id = 'S1004'. ls_product-unit_price = '35000.00'. ls_product-stock_qty = 3. ls_product-reorder_level = 5. ls_product-location = 'Bangalore'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1013'. ls_product-product_name = 'Bookshelf'. ls_product-category = 'Furniture'. ls_product-supplier_id = 'S1003'. ls_product-unit_price = '4500.00'. ls_product-stock_qty = 20. ls_product-reorder_level = 10. ls_product-location = 'Mumbai'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1014'. ls_product-product_name = 'Scanner'. ls_product-category = 'Office Equipment'. ls_product-supplier_id = 'S1004'. ls_product-unit_price = '9500.00'. ls_product-stock_qty = 4. ls_product-reorder_level = 5. ls_product-location = 'Bangalore'. ls_product-status = 'INACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.
  ls_product-product_id = 'P1015'. ls_product-product_name = 'Paper Ream'. ls_product-category = 'Stationery'. ls_product-supplier_id = 'S1005'. ls_product-unit_price = '350.00'. ls_product-stock_qty = 45. ls_product-reorder_level = 20. ls_product-location = 'Pune'. ls_product-status = 'ACTIVE'. ls_product-created_date = sy-datum. APPEND ls_product TO lt_products.

  TRY.
      INSERT zproduct FROM TABLE lt_products ACCEPTING DUPLICATE KEYS.
      IF sy-subrc = 0.
        WRITE: / 'Products inserted successfully.'.
      ELSE.
        WRITE: / 'Some products might already exist or insert failed.'.
      ENDIF.
    CATCH cx_sy_open_sql_db.
      WRITE: / 'Error inserting products.'.
  ENDTRY.

  " --------------------------------------------------------------------
  " 3. Populate Stock Movements
  " --------------------------------------------------------------------
  CLEAR ls_movement.
  ls_movement-movement_id = 'M001'. ls_movement-product_id = 'P1001'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 50. ls_movement-movement_date = '20260101'. ls_movement-reference_no = 'REF001'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M002'. ls_movement-product_id = 'P1002'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 20. ls_movement-movement_date = '20260105'. ls_movement-reference_no = 'REF002'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M003'. ls_movement-product_id = 'P1001'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 25. ls_movement-movement_date = '20260110'. ls_movement-reference_no = 'REF003'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M004'. ls_movement-product_id = 'P1002'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 12. ls_movement-movement_date = '20260112'. ls_movement-reference_no = 'REF004'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M005'. ls_movement-product_id = 'P1003'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 30. ls_movement-movement_date = '20260201'. ls_movement-reference_no = 'REF005'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M006'. ls_movement-product_id = 'P1003'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 15. ls_movement-movement_date = '20260215'. ls_movement-reference_no = 'REF006'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M007'. ls_movement-product_id = 'P1004'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 20. ls_movement-movement_date = '20260301'. ls_movement-reference_no = 'REF007'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M008'. ls_movement-product_id = 'P1004'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 8. ls_movement-movement_date = '20260310'. ls_movement-reference_no = 'REF008'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M009'. ls_movement-product_id = 'P1005'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 10. ls_movement-movement_date = '20260401'. ls_movement-reference_no = 'REF009'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M010'. ls_movement-product_id = 'P1005'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 4. ls_movement-movement_date = '20260405'. ls_movement-reference_no = 'REF010'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M011'. ls_movement-product_id = 'P1006'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 50. ls_movement-movement_date = '20260501'. ls_movement-reference_no = 'REF011'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M012'. ls_movement-product_id = 'P1006'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 20. ls_movement-movement_date = '20260510'. ls_movement-reference_no = 'REF012'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M013'. ls_movement-product_id = 'P1007'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 200. ls_movement-movement_date = '20260601'. ls_movement-reference_no = 'REF013'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M014'. ls_movement-product_id = 'P1007'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 100. ls_movement-movement_date = '20260615'. ls_movement-reference_no = 'REF014'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M015'. ls_movement-product_id = 'P1008'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 15. ls_movement-movement_date = '20260701'. ls_movement-reference_no = 'REF015'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M016'. ls_movement-product_id = 'P1008'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 10. ls_movement-movement_date = '20260710'. ls_movement-reference_no = 'REF016'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M017'. ls_movement-product_id = 'P1009'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 15. ls_movement-movement_date = '20260801'. ls_movement-reference_no = 'REF017'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M018'. ls_movement-product_id = 'P1009'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 5. ls_movement-movement_date = '20260810'. ls_movement-reference_no = 'REF018'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M019'. ls_movement-product_id = 'P1010'. ls_movement-movement_type = 'IN'. ls_movement-quantity = 10. ls_movement-movement_date = '20260901'. ls_movement-reference_no = 'REF019'. APPEND ls_movement TO lt_movements.
  ls_movement-movement_id = 'M020'. ls_movement-product_id = 'P1010'. ls_movement-movement_type = 'OUT'. ls_movement-quantity = 3. ls_movement-movement_date = '20260905'. ls_movement-reference_no = 'REF020'. APPEND ls_movement TO lt_movements.

  TRY.
      INSERT zstock_movement FROM TABLE lt_movements ACCEPTING DUPLICATE KEYS.
      IF sy-subrc = 0.
        WRITE: / 'Stock movements inserted successfully.'.
      ELSE.
        WRITE: / 'Some stock movements might already exist or insert failed.'.
      ENDIF.
    CATCH cx_sy_open_sql_db.
      WRITE: / 'Error inserting stock movements.'.
  ENDTRY.

ENDFORM.

*----------------------------------------------------------------------*
* Form reset_data
*----------------------------------------------------------------------*
FORM reset_data.
  DATA: lv_answer TYPE char1.

  " Confirm before deletion
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = 'Confirm Data Reset'
      text_question         = 'Are you sure you want to delete all test data from ZPRODUCT, ZSUPPLIER, and ZSTOCK_MOVEMENT?'
      text_button_1         = 'Yes'
      icon_button_1         = 'ICON_OKAY'
      text_button_2         = 'No'
      icon_button_2         = 'ICON_CANCEL'
      default_button        = '2'
      display_cancel_button = 'X'
    IMPORTING
      answer                = lv_answer.

  IF lv_answer = '1'. " Yes
    TRY.
        DELETE FROM zstock_movement.
        IF sy-subrc = 0. WRITE: / 'ZSTOCK_MOVEMENT records deleted.'. ENDIF.

        DELETE FROM zproduct.
        IF sy-subrc = 0. WRITE: / 'ZPRODUCT records deleted.'. ENDIF.

        DELETE FROM zsupplier.
        IF sy-subrc = 0. WRITE: / 'ZSUPPLIER records deleted.'. ENDIF.
      CATCH cx_sy_open_sql_db.
        WRITE: / 'Error during data deletion.'.
    ENDTRY.
  ELSE.
    WRITE: / 'Data reset cancelled.'.
  ENDIF.
ENDFORM.
