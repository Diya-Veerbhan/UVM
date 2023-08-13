## Base classes
* uvm_void
* uvm_object
* uvm_report_object
* uvm_component
* uvm_transaction
* uvm_root
* For any verification environment the basic building blocks are components (drivers, monitors, scoreboard etc.) and the transactions (class objects that contains the actual data)
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/191972d1-eac0-4568-952e-4555fd498346)
## uvm_void
* No purpose, but serves as base class for all classes
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/197edb19-e7e1-408e-9533-d03b1d263875)
* Abstract class, no function, no data members; It's like no responsibility yet full importance
* User classes derived directly from uvm_void doesn't contain any uvm functionality
## uvm_object
* Virtual base class for all testbench components and transcations
* Defines methods for basic operations like print, copy, compare and record
  ![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/00aacfff-854e-4078-a29a-2459704a71b0)
## uvm_report_object
* Interface for uvm reporting facility
* All messages, warning, error issued by the components goes through this interface
* There's an internal instance of uvm_report_handler which stores the reporting configuration, on the basis of which the handler makes the decision on whether the message should be printed or not
* Then, it's passed to the central uvm_report_server which does the actual formatting and production of messages
* A report ID has <b> ["ID String", "Severity", "Verbosity level", "Text message"] </b>  and may include ["File name", "line number"] from which the message came
* If the verbosity level is set UVM_MEDIUM then UVM_HIGH text messages won't be printed; uvm_report_server will ignore the higher verbosity
## uvm_component
* All major verification components are derived from this class; it laready inherits the uvm_object and uvm_report_object functionalities
* It has following interface:
   - <b> Hierarchy </b> - defines methods for searching and traversing the component hierarchy e.g. env0.pci1.master2.drv
   - <b>  Phasing </b> - defines a phasing system that all components should follow e.g. build connect run etc.
   - <b> Reporting </b> - defines an instance to report_handler and all messages, warnings and error are passed via this interface
   - <b> Recording </b> - defines methods to record the transactions produced/consumed by the component to a transaction database
   - <b> Factory </b> - defines an interface to uvm_factory (used to create new components/objects based on instance type)
* <b> Note </b>  uvm_component is automatically seeded if UVM seeding is enabled, but all other objects must be manually reseeded via uvm_object::reseed.
## uvm_transaction
* Extension of uvm_object and includes timing and recording interface
* Simple transaction can be derived from uvm_transaction but sequence enabled transactions must be derived from uvm_sequence_item
## uvm_root
* It is an implicit top-level uvm_component that is automatically created when the simulation is run ans users can access via the global (uvm-package scope) variable <b> uvm_top</b>
* It has the following properties :
   - Any component whose parent is set to null becomes a child of  <b> uvm_top </b> (like mother of all)
   - It <b> manages the phasing for all components </b>
   - It is used to <b>search for components based on their hierarchical name </b>
   - It is used to <b> globally configure report verbosity </b>
   - UVM's reporting mechanism is accessible from anywhere outside uvm_component such as in modules and sequences
 * uvm_top checks for error during the end_of_elaboration phase and issues UVM_FATAL error to stop the simulation from starting 


