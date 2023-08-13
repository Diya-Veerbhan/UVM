## What is uvm_object?
* All components and object classes in a uvm environment are derived from uvm_object
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/204dd9e8-2f7b-4c4e-9cdc-ea5df3a04216)
* Defines common utility functions like print, copy, compare and record
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/95a7c3a3-3984-462d-b1a7-0b505b38f6d3)
* Classes that are derived from uvm_object must implement the pure virtual methods such as <b> create </b> and <b> get_type_name </b> 
* The <b> create </b> method allocates a new object of the same type as <b> this </b> object and returns via the base <b> uvm_object </b> handle.
* <b> Note </b> - Difference between new and create is that new allocates memory to  the current object and the create returns the handle of the object allocated elsewhere
 ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/49d0a3ee-2960-4390-874c-7f82f1949337)
* <b> get_type_name </b> returns the class type name of the object and is used for debugging functions and by the factory to create objects of a particular type
 ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/22d8d17e-7635-4d79-90b3-9e837678494b)


## Factory interface 
* All the classes that are defined in the UVM environment are registered with this 'factory', which can then return an object of any requested class type later on
* User classes are expected to include certain macros within them to allow them to be registered with the factory
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/1f51b278-5750-4d2c-88fe-7f5e3f9f6027)


## Utility Functions 
### Print
* Deep-prints the current object's variables in the format defined by the UVM printer policy
* As this function is not declared as virtual, it cannot be overridden by a child class for a different implememtation
* do_print for custom information
* <b> Note </b> : A virtual function is a member function which is declared within a base class and is re-defined(Overridden) by a derived class. When you refer to a derived class object using a pointer or a reference to the base class, you can call a virtual function for that object and execute the derived class’s version of the function.
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/b25a121b-e3a4-43f4-b46e-1f4ab4aa5f5b)

### Copy
* Like print function, copy cannot be overridden by the derived class
* To copy fields of a derived class, that class should override do_copy method
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/d6cf463e-0fc9-4c98-8b95-147403afa012)

### Compare
* This method performs a deep compare on members of <b> this </b> object with those of the object provided as an argument to this method
* Returning a 1 on match and 0 otherwise
* This method cannot be overridden by derived classes
* Custom code can be added using do_compare
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/dcb4983d-4405-4169-9ea0-d9bb07c008c6)



