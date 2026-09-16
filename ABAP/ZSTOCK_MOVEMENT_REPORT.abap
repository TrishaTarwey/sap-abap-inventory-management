*&---------------------------------------------------------------------*
*& Report ZSTOCK_MOVEMENT_REPORT
*&---------------------------------------------------------------------*
*& Display Stock Movements
*&---------------------------------------------------------------------*
REPORT ZSTOCK_MOVEMENT_REPORT.

* Define structure matching ZSTOCK_MOVEMENT table
TYPES: BEGIN OF ty_stock_movement,
         movement_id   TYPE c LENGTH 10,
         product_id    TYPE c LENGTH 10,
         movement_type TYPE c LENGTH 3,
         quantity      TYPE i,
         movement_date TYPE dats,
         reference_no  TYPE c LENGTH 15,
       END OF ty_stock_movement.

* Internal table and work area for stock movements
DATA: it_movements TYPE STANDARD TABLE OF ty_stock_movement,
      wa_movement  TYPE ty_stock_movement.

* Variable to hold total movements count
DATA: v_total_movements TYPE i.

* Selection Screen parameters
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  PARAMETERS: p_prodid TYPE c LENGTH 10,  " Product ID
              p_mvtype TYPE c LENGTH 3.   " Movement Type (IN/OUT)
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
* Build the SELECT query with optional filters
  IF p_prodid IS NOT INITIAL AND p_mvtype IS NOT INITIAL.
    SELECT movement_id product_id movement_type quantity movement_date reference_no
      FROM zstock_movement
      INTO TABLE it_movements
      WHERE product_id = p_prodid
        AND movement_type = p_mvtype.
  ELSEIF p_prodid IS NOT INITIAL.
    SELECT movement_id product_id movement_type quantity movement_date reference_no
      FROM zstock_movement
      INTO TABLE it_movements
      WHERE product_id = p_prodid.
  ELSEIF p_mvtype IS NOT INITIAL.
    SELECT movement_id product_id movement_type quantity movement_date reference_no
      FROM zstock_movement
      INTO TABLE it_movements
      WHERE movement_type = p_mvtype.
  ELSE.
    SELECT movement_id product_id movement_type quantity movement_date reference_no
      FROM zstock_movement
      INTO TABLE it_movements.
  ENDIF.

* Calculate total movements
  DESCRIBE TABLE it_movements LINES v_total_movements.

* Display header
  WRITE: / '============================================================'.
  WRITE: / '          Stock Movement Report'.
  WRITE: / '============================================================'.
  WRITE: /.
  WRITE: / 'Movement ID  Product ID  Type   Quantity   Date         Reference'.
  WRITE: / '-----------------------------------------------------------------'.

* Loop through internal table and display each record
  LOOP AT it_movements INTO wa_movement.
    WRITE: / wa_movement-movement_id   UNDER 'Movement ID',
             wa_movement-product_id    UNDER 'Product ID',
             wa_movement-movement_type UNDER 'Type',
             wa_movement-quantity      UNDER 'Quantity',
             wa_movement-movement_date UNDER 'Date',
             wa_movement-reference_no  UNDER 'Reference'.
  ENDLOOP.

* Display footer
  WRITE: / '-----------------------------------------------------------------'.
  WRITE: /.
  WRITE: / 'Total Movements:', v_total_movements.
  WRITE: / '============================================================'.
