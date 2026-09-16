# Object-Oriented Programming (OOP) in ABAP

## What is OOP in ABAP?
Object-Oriented Programming (OOP) is a programming paradigm that organizes software design around data, or objects, rather than just functions and logic. In modern ABAP (ABAP Objects), OOP is the recommended way to structure your code because it provides better security, modularity, and reusability compared to traditional procedural code (like FORM routines).

## CLASS Definition and Implementation
In ABAP, a class is divided into two parts:
1. **Definition**: Declares the components of the class, such as its methods and data attributes. It defines *what* the class does.
2. **Implementation**: Contains the actual code for the methods. It defines *how* the class does it.

## The Constructor
The `CONSTRUCTOR` is a special method that is automatically called when an object of the class is created. It is typically used to initialize the object with starting data.

## Methods and Objects
- **Methods**: These are the functions inside a class that perform actions.
- **Objects (Instances)**: A class is like a blueprint. An object is a real instance created from that blueprint. You can create many objects from a single class.

## DATA Declarations in Classes
Data declared inside a class is called an attribute. These attributes can have different visibilities:
- **PUBLIC**: Can be accessed from outside the class.
- **PRIVATE**: Can only be accessed by methods within the class itself.

## Example: `lcl_inventory` from `ZINVENTORY_REPORT`

Here is the class definition used in our inventory report to demonstrate basic OOP:

```abap
CLASS lcl_inventory DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING it_products TYPE ty_product_table,
             get_total_products RETURNING VALUE(rv_count) TYPE i,
             get_total_stock RETURNING VALUE(rv_stock) TYPE i,
             calculate_total_value RETURNING VALUE(rv_value) TYPE p.
  PRIVATE SECTION.
    DATA: mt_products TYPE ty_product_table.
ENDCLASS.
```

### How It Works:
1. **Instantiation**: When we create an instance of `lcl_inventory`, the `constructor` is called. We pass our internal table of products (`it_products`) into it.
2. **Encapsulation**: The constructor saves this data into the private attribute `mt_products`. Because it is in the `PRIVATE SECTION`, no outside program can accidentally modify this data.
3. **Operations**: We can call methods like `get_total_products` or `calculate_total_value`. These methods read the private `mt_products` table, perform their calculations, and return the result.

## Why OOP is Useful
- **Data Protection (Encapsulation)**: Private attributes prevent unauthorized changes to the data.
- **Clear Structure**: The code is neatly bundled into logical objects.
- **Scalability**: It is much easier to extend a class (e.g., via inheritance) to add new features without breaking existing code.

*Note: This project uses a very basic local class just to demonstrate the concepts. Full enterprise SAP applications use global classes (transaction SE24 or Eclipse) with more complex design patterns.*
