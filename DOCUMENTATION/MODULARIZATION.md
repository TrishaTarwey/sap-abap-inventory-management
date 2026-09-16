# ABAP Modularization

## What is Modularization?
Modularization is the practice of dividing a large program into smaller, manageable, and independent blocks of code called modules. Instead of writing one massive block of code, you break it down into logical pieces that perform specific tasks.

## Why is it Important?
- **Readability**: Smaller blocks of code are much easier to read and understand.
- **Reusability**: You can write a module once and call it multiple times from different places, avoiding code duplication.
- **Maintainability**: If a bug occurs or a change is needed, you only have to update the specific module responsible for that logic.
- **Debugging**: It is easier to test and debug smaller, isolated pieces of code.

## FORM Routines (Subroutines)
In traditional ABAP, subroutines are known as **FORM routines**. They encapsulate a block of code.

### Syntax
A FORM routine is defined using `FORM` and `ENDFORM`:
```abap
FORM my_routine.
  " Code goes here
ENDFORM.
```

### PERFORM Statement
To execute the code inside a FORM routine, you use the `PERFORM` statement:
```abap
PERFORM my_routine.
```

### Passing Parameters
You can pass data into and out of FORM routines using `USING` and `CHANGING`:
- **USING**: Used for input parameters that the routine should read.
- **CHANGING**: Used for parameters that the routine will modify and return.

```abap
FORM calculate_discount USING pv_price TYPE p
                      CHANGING cv_discount TYPE p.
  cv_discount = pv_price * '0.10'.
ENDFORM.
```

## Examples from ZINVENTORY_REPORT

In our main report, we use modularization to clearly define the steps of the program:

```abap
PERFORM get_inventory_data.
PERFORM display_inventory.
PERFORM calculate_inventory_value.
PERFORM display_statistics.
```

Each of these `PERFORM` statements calls a corresponding `FORM` block later in the program. This makes the main flow of the program incredibly easy to read. You know exactly what the program does just by looking at these four lines.

## Note on Modern ABAP
While `FORM` and `PERFORM` are the traditional ways to modularize ABAP code and are still widely found in older SAP systems, modern ABAP development strongly prefers using **Object-Oriented Programming (OOP)** with Classes and Methods. However, understanding FORM routines is essential for any ABAP beginner because you will frequently encounter them when maintaining existing code.
