## Example
* uvm_object  being base class contains the basic functions; UVM has many automation macros that get expanded into full code during compilation and implements these functions for all classes with ease
* The purpose of this example is to show how uvm automation macros can be used to print variable contents easily
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/fcc93041-a1b0-4f34-8291-fed16554a24c)
* A class "Object" is derived from uvm_object inheriting all functions of parent class
* Few variables of different datatype are declared
* A class object is created using new() ---???????
* Different variations of uvm_field_* macro is used corresponding to the data type
* UVM_DEFAULT implies that the given variable should be used for all default uvm automation macros implemeted by the object which are copy, print, compare and record
* Now to test above code, we will use a base test class that will print contents of the instance of class "object"
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/44ac7412-5fb9-4871-aad2-16d0417d8eb6)
* By default the uvm printer prints content of any object in table format having name of variable, datatype, its size and value
* Even the arrays are printed with content of all their indices
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/9e7e2ad4-6eac-4943-b032-13aa6963ab4c)
## Using do_print()
* Using automation macros is not recommended because it inntroduces a lot of additonal code and reduce simulator performance
* Use  do_* callback hooks to implement the requirement
* User can implement the function called do_print inside derived object and not use automation macro at all
* do_print function is called by print function by default and hence whatever is defined in do_print will be printed out
* Here we will print three variables
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/9ff169eb-3785-43f5-a5c3-9c9f4a92f97d)
  - do_print(uvm_printer printer) ???
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/474d59c2-965c-4820-a13d-595d60d1d92b)
## Using sprint
* It returns formatted content in a string format
* Substitute of print function
  

