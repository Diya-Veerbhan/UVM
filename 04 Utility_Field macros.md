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
 * `uvm_object_utils eventually gets expanded into its *_begin and *_end form with nothing between begin and end
 * *_begin implements other macros required for the correct functionality of the uvm factory
   ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/04562d64-05fd-4635-b1d6-fe30e3d5646b)

  
