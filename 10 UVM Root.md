## UVM Root
* <b> Singleton class </b> : Singleton class mtlb iss class ka baas ek instance (only one object) hi ho skta h, irrespective of tum iss class ko multiple times instantiate kro.
  Everytime same object is returned, even if the user tries to create multiple objects e.g. configuration class
* UVM root : singleton class 
* Automatically created when uvm is initialized and is available throughout the entire simulation
* Users should not create any other instance of this class   
* UVM root serves as top level container for all uvm components aur iske instance ko <b> uvm_top </b> bolte h
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/574202a5-49e4-404e-9dc3-b1add39b5d87)

