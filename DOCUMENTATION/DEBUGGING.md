# ABAP Debugging Guide

## 1. What is ABAP Debugging
ABAP debugging is the process of finding and resolving bugs or defects in an ABAP program. It allows you to pause the execution of your code, inspect variables, and step through the logic line by line to understand how the program behaves and identify issues.

## 2. How to Set a Breakpoint
- **In SE38/SE80**: Click on the margin next to the line number where you want to pause execution. A stop sign icon will appear.
- **Using BREAK-POINT statement**: Add the `BREAK-POINT.` statement directly in your ABAP code.
- **Using /h in the command field**: Type `/h` in the SAP GUI command field and press Enter. This activates debugging mode for the next action you perform.

## 3. Debugging ZINVENTORY_REPORT Step by Step
- **Step 1:** Set breakpoint at the `SELECT` statement.
- **Step 2:** Execute the report (F8).
- **Step 3:** Debugger opens at the breakpoint.
- **Step 4:** Press F5 (Single Step) to execute the `SELECT`.
- **Step 5:** Double-click on `lt_product` to inspect the internal table.
- **Step 6:** Check how many records were fetched.
- **Step 7:** Continue to the `LOOP` statement.
- **Step 8:** Inside the `LOOP`, inspect `ls_product` (work area).
- **Step 9:** Check individual fields: `PRODUCT_ID`, `STOCK_QTY`, `UNIT_PRICE`.
- **Step 10:** Step through to inventory value calculation.
- **Step 11:** Verify: `inventory_value = unit_price * stock_qty`.
- **Step 12:** Press F8 to continue to the next iteration.

## 4. Debugger Buttons
- **F5:** Single Step (steps into forms/functions).
- **F6:** Execute (steps over forms/functions).
- **F7:** Return (steps out of current form/function).
- **F8:** Continue (runs to the next breakpoint).

## 5. Watching Variables
In the debugger, you can type variable names (like `lt_product` or `ls_product-unit_price`) into the Variables view to watch their values change as you step through the code.

## 6. Debugging Flow Diagram
```
SELECT
 ↓
lt_product (internal table - inspect here)
 ↓
LOOP AT lt_product INTO ls_product
 ↓
ls_product (work area - inspect fields here)
 ↓
Inventory Value Calculation (verify arithmetic)
```

## 7. Common Debugging Tips for Beginners
- Always verify your internal table contents immediately after a `SELECT` statement.
- Check `sy-subrc` after database operations (0 means success).
- Be careful with `F5` in standard SAP code; use `F6` to step over standard functions unless necessary.
- Use watchpoints to pause execution only when a specific variable's value changes.
