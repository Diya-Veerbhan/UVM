## Introduction

* UVM is built over system verilog and provides framework for creating modular, reusable testbench components
* OVM (Open Verification Methodology) was used before UVM; UVM is more standardized and flexible than OVM
* UVM support both Transaction Level Modeling  and Register-Transfer Level Modeling (oVM doesn't support RLM)
* You can think of UVM as a personal detail form, without form you have think each and every detail about yourself and then give it, but with UVM you are having a form so you simply have to fill it; UVM is kind-of like template for the testbenches

## What does UVM contain?
* It contains set of pre-defined classes and methods. Key components of UVM are 
* <b> Testbench Components </b> :
  - It provides a set of base classes that can be extended to create testbench components such as monitors, drivers, agents etc.
  - UVM classes are denoted by prefix uvm_*
  - These components already have the necessary code that will let them connect between each other, handle data packets and work synchronously with each other
*  <b> Transactions </b> :
   - Used to model the communication between DUT and the testbench
   - UVM provides a transaction class that can be extended to create transaction objects
* <b> Phases </b> :
  - UVM defines a set of simulation phases that ensures user to control the order in which the testbench coponents are created, initialized and executed
*  <b> Messaging and Reporting  </b> :
   - Infrastructure for warnings, errors and debug info
* <b> Configuration   </b> :
  - Configuration database to store and retrive config info about testbench
*  <b> Functional Coverage </b> :
   - Mechanism for tracking functional coverage
* <b> Register Abstraction layer</b> : ?

## What is UVM class hierarchy?
* Using Inheritance, you can build complex classes
* For example, for a protocol a new driver class can be built by extending the  base class uvm_driver. Stimulus for that protocol can be written by extending uvm_sequence_item. How this sequence is built and handed over to driver is taken care internally by the the UVM framework, Cool right!!
* <b> uvm_void </b> is the base of all classes, but it is primarily empty
* <b> uvm_object </b> is the main class in which common functions to print, copy and compare two objects of the same class are defined
 ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/d0a05766-04e1-4bb2-b5b4-bc8b6fa0d5e9)

### Major class categories 
* <b> uvm_object </b>
* <b> uvm_sequence </b> 
  - All user defined stimulus classes are recommended to be derived from this class
  - Each sequence can be used into another sequence to create more random scenrios like for read and write sequence, it can be like R>>R>>W>>R, or W>>W>>R>>R etc.
* <b> uvm_sequence_item </b> 
   - Data objects that have to driven to DUT are generally called sequence items and are recommended to be inherited from uvm_sequence_item
   - e.g. for APB  transaction, a sequence item class will consist of the address, the read/write data, access type and send it to APB driver to drive the transaction to DUT
* <b> uvm components</b>
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/cce5d291-e840-46dc-8162-5d4a114dd155)
* <b> Register Layer </b>
 - Some registers are supposed to be configured by the software, in sv testbenches it is quite difficult as you need to build separate classes for theses register that are specific to a project
 - UVM provides a extensive set of classes for these registers; belonging to something called register model
* <b> TLM connections </b>
 - Helps to send data between different components in the form of transactions and class objects
* <b> UVM Phases </b>
 - It enables all the components to be in sync with each other before proceeding to next phase
 - Each component goes through the build phase where it gets instantiated, connect with each other during connect phase, consumes simulation time during run phase and stops altogether during the final phase
   ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/13ad7915-c527-465b-a33d-9dba9cc11a65)








