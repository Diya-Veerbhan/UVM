## UVM Utility and Field macros
* UVM uses the concept of factory where all objects are registered with it so that it can return an object
  of the requested type when required
* The <b> utility macros </b> help to register each object with the factory
* UVM also introduces a bunch of automation mechanisms for implememting print, copy and compare ; defined using field macros

## Utility macros 
* The <b> utils </b>  macro is primarily used to register the object or component with the factory and
  is required for it to function correctly
* It is required to be used inside every user defined class that is derived from uvm_object, which include all types of sequence
 items and components
  ### Object utility
* All classes directly derived from the uvm_object or uvm_transaction require them to be registered using <b>`uvm_object_utils </b>
macro
* <b> Note </b> : It is mandatory for the new function to be explicitly defined for every class and takes the name of the class instance as an argument
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/d7ae9a40-60d9-4bb6-8066-46fea8b55389)

 ### Component Utility
 * All classes directly or indirectlly derived from the uvm_component required them to be registered to the factory using <b> `uvm_object_utils </b>
 macro
* <b> Note </b> : It is mandatory for the new function to be explicitly defined for every class derived directly or indirectly from uvm_component
and takes the name of the class instance and a handle to the parent class where this object is instantiated
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/626f23ca-b66b-4fe0-9416-c0686cf60751)

 ## Macro expansion: behind the scenes
 * <b> Macros </b> : Macros are code snippets; macros are pre processed i.e. this block of code is passed to the compiler even before entering the actual coding(before your code compiles)
 * <b> Note </b> : Functions are not pre processed but are compiled; before compilation, macro name is replaced by macro value (increasing the code length) whereas during function call, transfer of control takes place
   ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/3116a491-d15f-4253-beaa-85c2319bb521)

 * `uvm_object_utils eventually gets expanded into its *_begin and *_end form with nothing between begin and end
 * *_begin implements other macros required for the correct functionality of the uvm factory
   ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/04562d64-05fd-4635-b1d6-fe30e3d5646b)
* The uvm_object_utils_end consist of end and endfunction, therefore it is terminating a function, that function can be anything
*  Now, it can be seen that each macro expanded by *_begin implements some function required for factory operation and performs the following operation:
   - Implements <b> get_type </b> static method which returns a factory proxy object for the requested type
   - Implements <b> create </b>, which instantiates an object of the specified type by calling its constructor with no arguments
   - Implements <b> get_type_name </b> method which returns the type as string
   - Registers the type with uvm factoy
   ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/a0fa4740-8b1d-4418-a0db-b66e2f575640)
* Similar way, `uvm_component_utils_* also have equivalent macros and function calls
* <b> create </b> function for components takes two arguments : name and parent, unlike that of an object

  ## Creation of class object
  * It is recommended that all class objects are created by calling the <b> type id :: create() </b> method which is already defined by the  macro `m_uvm-object_create_func
  * This makes any child class object to be created and returned using factory mechanism and promotes testbench flexibility and reusability
    ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/ae7d1699-3a95-4a39-8427-96c243e09d2b)
    - the `uvm_object_utils(ABC) // registers the object with the factory
    -  function new(string name = "ABC") //the new function for object is taking only one argument 
    - the `uvm_component_utils(base_test) // registers the component with the factory
    - function new(string name = "base_test", uvm_component parent= null) //the new function for component is taking two arguments : name and parent
    - ABC abc = ABC :: type_id :: create("abc_inst") //Here create func is already defined in macro and we have registered it using uvm_object_utils macro
   
  ## Field Macros
  * <b> `uvm_field_* </b> macros that were used between *_begin and *_end utility macros are called field macros
  * They can operate on class properties and provide automatic implementations of core methods like copy, compare and print
    ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/ddbf2b7d-b9fb-4720-9bb3-8c2c0b71ed92)
    ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/b2748a93-f6a8-4ec5-b944-b982541f3f63)
    ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/f1002f5c-71bb-48ff-985a-8ce04c9e88f9)



    
   


  
   

  
