// Code your design here
module add (input [3:0] a,b, output [4:0] y);
  
  assign y=a+b;
  
endmodule; 

/////////////////////////////////////////////////

interface add_if();// adding the interface for the DUT
  //the interface class is static from the DUT side
  logic [3:0] a;
  logic [3:0] b;
  logic [4:0] y;
endinterface

//////////////////////////////////////////////


// Code your testbench here
// or browse Examples

//////////////////////////////////////////////
`timescale 1ns/1ps

///////Transaction class//////////////////
`include "uvm_macros.svh" //to access uvm macros
 import uvm_pkg::*;//to access all the base classes
//both are required to compile the uvm code
class transaction extends uvm_sequence_item;
  //adding input and output ports of the DUT
  rand bit [3:0] a;
  rand bit [3:0] b;
  bit [4:0] y;
  
  //as it is a uvm_object class, only one argument is required for the new function
  function new (input string path = "transaction");
    super.new(path);
  endfunction
  
  //Registering the class with the factory
  `uvm_object_utils_begin(transaction)
  //for using inbuilt implementation for accessing the core methods of uvm (print, copy, clone) so adding field_int (depends upon the datatype of the variable) for the data member
  // you can use do methods if you want to use your own implementation
  `uvm_field_int(a, UVM_DEFAULT)
  `uvm_field_int(b, UVM_DEFAULT)
  `uvm_field_int(y, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

///////////////////Generator(Sequence class)//////////////////////////

class generator extends uvm_sequence #(transaction);
  // #(transaction): parameterized class: we will be operating on this parameter only
  //You can't pass different kind of transaction packet to this class as it accept only the kind of objects defined in the parameter #()
  //this will generate sequence 
  // we want to send random stimuli to the DUT and analyse the results
  //registering the class with the factory
  `uvm_object_utils(generator)
  
  transaction t;
  integer i ;//a count variable to specify the number of stimuli we will send to DUT
  
  // adding the constructor for this class
  function new (input string path = "generator");
    super.new(path);
  endfunction
//when we will call start method of the sequence, automatically the body will be called  
  virtual task body();
    //creating the object for the transaction class
    t = transaction :: type_id :: create ("t");
    repeat(10)
      begin
        start_item(t); //we send the request
        //after receiving the grant, we call randomize method
        t.randomize();
        //this will generate the random values for the rand variables
        `uvm_info("GEN", $sformatf("Data sent to driver a : %0d b : %0d", t.a,t.b), UVM_NONE)
        finish_item(t);//this will be sending the data to the driver through the sequencer
      end
  endtask
endclass

/////////////// Driver class//////////////////////

class driver extends uvm_driver #(transaction);
  //parameterized class
  
 // registering the class with uvm factory
  `uvm_component_utils(driver)
  
  //defining constructor, as it is a uvm component derived class it should two arguments
  function new (input string path = "driver", uvm_component parent = null);
    super.new(path, parent);
  endfunction
  
  transaction tc;//data container where we will be storing the data that we will receive from the sequencer
  virtual add_if aif; //to access the interface to connect with the DUT
  //creates the virtual interface so that it can be used in classes in TB
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    //creating the data object for the container
    tc = transaction :: type_id :: create("tc");
    // to get the access of the interface in the build phase itself
    //parameter that we will be working : virtual add_if
    //calling the get() method
    // this refers to driver class
    // the instance name aif has an access to virtual add_if if the the get method is successful
    if(!uvm_config_db #(virtual add_if) :: get(this, "", "aif", aif))
      `uvm_error("DRV","Unable to access uvm_config_db");//as it is an error it doesn't require any verbosity level
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    //we need to be ready to receive the data from the sequencer
    forever begin
      //we call seq item port
      //this is the special port through which we will be communicating with the sequencer
      seq_item_port.get_next_item(tc);//this will send the request to the sequencer that the driver is ready to accept the new data
      //applying the stimulus to the DUT
      aif.a <= tc.a;
      aif.b <= tc.b;
      //when you are triggering the interface use non-blocking assignment whereas when you are updating the data member of the class use blocking assignment(example in monitor)
      `uvm_info("DRV", $sformatf("trigger the DUT input a : %0d, b : %0d ", tc.a, tc.b), UVM_NONE)
      #10;
    end
  endtask
  
endclass
    
//////MONITOR///////////////    
 
class monitor
  extends uvm_monitor;
 `uvm_component_utils(monitor)
  // analysis  port to send the data from the monitor to the scoreboard
  uvm_analysis_port #(transaction) send;    
      
 function new (input string path="monitor", uvm_component parent=null);
    super.new(path, parent);
   //costructor for the analysis port
   //two arguments : instance_name and parent (this = monitor)
   send = new("send", this);
 endfunction
  
  transaction t; // to store the data that we will receive from DUT
  virtual add_if aif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    t = transaction :: type_id :: create("t");
    if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
   `uvm_error("MON","Unable to access uvm_config_db");
  endfunction
 
 virtual task run_phase(uvm_phase phase);
          forever begin
           #10;//wait for the stimulus applied to have a valid response
            //assigning the data received from DUT to the local transaction instance
           t.a = aif.a;
           t.b = aif.b;
           t.y = aif.y;
           `uvm_info("MON",$sformatf("Data sent to scoreboard a :%0d b : %0d and y=%0d", t.a, t.b, t.y), UVM_NONE)
            send.write(t);//sending tha data to the scoreboard 
          end
        endtask
endclass

////////////////SCOREBOARD/////////////////////////////////
        
class scoreboard extends uvm_component;
          `uvm_object_utils(scoreboard)
          // connecting the analysis port 
          // two parameters : transaction type data and implementation of this analysis port will be in the scoreboard class 
          uvm_analysis_imp #(transaction, scoreboard) recv;
          
           transaction tr;
          function new(input string path="scoreboard", uvm_component parent=null);
            super.new(path, parent);
            //constructor for the uvm analysis port
            recv = new("recv", this);
          endfunction
  
          virtual function void write(input transaction t);
            //assigning the data received from monitor to the local instance
            tr = t;
            `uvm_info("SCB", $sformatf("Data eceived from monitor a : %0d, b: %0d, y : %0d", tr.a, tr.b, tr.y), UVM_NONE);
            if(tr.y == tr.a + tr.b)
              `uvm_info("SCB","TEST PASSED", UVM_NONE)
            else
              `uvm_info("SCB","TEST FAILED", UVM_NONE)
          endfunction
              
 endclass
              
////////////////Agent/////////////////////
 class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   
                
  function new(input string inst = "AGENT", uvm_component c);
     super.new(inst, c);
     endfunction
    //defining the instances for monitor, driver and seqr          
   monitor m;
   driver d;
   uvm_sequencer #(transaction) seqr;
   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     //creating objects for monitor, driver and seqr
     m = monitor :: type_id ::create("m", this);
     d = driver ::type_id :: create("d", this);
     seqr= uvm_sequencer #(transaction) :: type_id :: create("seqr", this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     //connecing the port of driver and sequencer (not declared explicitly in driver and seqr, but their methods have been used in the run_phase task)
     d.seq_item_port.connect(seqr.seq_item_export);
   endfunction
 endclass
////////////env/////////////////////////
            class env extends uvm_env;
              `uvm_component_utils(env);
              
              function new (input string inst = "env", uvm_component c);
                super.new(inst, c);
              endfunction
              
              //creating instances of scoreboard and agent : part of env
              scoreboard s;
              agent a;
              
              virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                //creating the object of the scoreboard and agent
                s = scoreboard::type_id::create("s", this);
                a = agent :: type_id :: create("a", this);
              endfunction
              
              virtual function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                // connecting the send analysis port of the monitor with the recv analysis port of scoreboard
                a.m.send.connect(s.recv);
              endfunction
              
            endclass
              
 ///////////////test/////////////////////
            class test extends uvm_test;
              `uvm_component_utils(test)
              
              function new(input string inst="test", uvm_component c);
                super.new(inst, c);
              endfunction
              //creating instances of sequence(generator) and env
             generator gen; 
             env e;
              
              virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                //creating object of the sequence(generator) and env
                gen = generator :: type_id :: create("gen"); 
                e = env :: type_id :: create("e", this);
              endfunction
              
              virtual task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                //starting the sequence and specifying the sequencer
                gen.start(e.a.seqr);
                phase.drop_objection(this);
              endtask
            endclass
/////////////////////tb_top//////////////////
            module add_tb();
              //instantiating the interface
              add_if aif();
              add dut(.a(aif.a), .b(aif.b), .y(aif.y));
              
              initial begin
                $dumpfile("dump.vcd");
                $dumpvars;
              end
              
              initial begin
                //calling set method of uvm_config_db
                // accessing the agent uvm_test_top.e.a* as both monitor and driver needs access to the interface
                uvm_config_db #(virtual add_if) ::set(null, "uvm_test_top.e.a*", "aif", aif);
                //specifying the name of our component : test
                run_test("test");
              end
            endmodule
            
