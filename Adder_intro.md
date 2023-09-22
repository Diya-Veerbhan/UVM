## UVM TESTBENCH
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/43a2e914-9405-4bdd-977e-6b4559ac41b8)
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/c95aec76-a1cc-426d-b203-d4e128a42f18)
![image](https://github.com/Diya-Veerbhan/UVM/assets/64258231/b9f95c83-282a-491a-93d3-992fde2bd0fa)

- Transaction and sequence : dynamic component : uvm_object/ uvm_transaction
- Sequencer, Driver, agent, monitor, scoreboard,env, test  : Static component : uvm_component
- agent handles the connection between sequencer and driver
- env handles the connection between monitor and scoreboard
- For uvm_components, any class instance defined inside it is allocated memory in the build phase (using create method)
- for uvm_object, any class instance is allocated memory in task body() using new()
- For the analysis port instance (in monitor and scoreboard), the constructor new() will be present inside the constructor of the scoreboard
- 

