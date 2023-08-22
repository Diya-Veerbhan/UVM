## UVM Component
* Serves as foundation for all UVM component like drivers, monitors, scrb
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/595efcfc-8acd-461c-b1a5-dacc3bdded68)

## Features
* Hierarchy : hierarchial structure, forming tree like structure and providing methods for searching and traversing the tree
* Phasing : Components can participate in UVM phasing mechanism, which organizes simulation into different phases like build, connect, run,and cleanup
* Reporting : Components use UVM messaging infrastructure to report events, warnings, errors
* Factory : Components can be registered with factory, enabling dynamic object creation and lookup

## Class Hierarchy
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/26f3ac5f-e8ef-457f-a34d-70638bb20b82)

* Phase allows components to construct their internal hierarchy, connect to other components,and finalize their configurations before the actual test starts.


## Class Declaration
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/aff374a3-ac0a-45a0-82f5-934617aa909c)

## Hierarchy Methods
