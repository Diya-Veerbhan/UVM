// Code your design here
module ram (
  input clk, wr,
  input [7:0] din,
  output reg [7:0] dout;
  input [3:0] addr
);
  
  reg [7:0] mem [15:0];
  
  always @(posedge clk)
    begin
      if (wr)
        begin 
          mem[addr] <= din;
        end
      else
        begin
          dout <= mem[addr];
        end
    end
endmodule

///////////interface/////////////////
interface ram_if;
  logic clk;
  logic wr;
  logic [7:0] din;
  logic [7:0] dout;
  logic [3:0] addr;
endinterface

  // Code your testbench here
// or browse Examples
class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  //for inputs, we are generating them randomly
  rand bit wr;
  rand bit [7:0] din;
  bit [7:0] dout;
  
  constraint addr_C {addr==3;};
  
  function new(input string inst="transaction");
    super.new(inst);
  endfunction
  
endclass


//////////////Sequence///////////////////////////////
class generator extends uvm_sequence#(transaction);
  `uvm_object_utils(generator)
  transaction t;
  
  function new(input string inst="generator");
    super.new(inst);
  endfunction
  
  virtual task body();
    for(int i=0;i<10; i++)//sending 10 transaction
     begin
       t = transaction :: type_id ::create("transaction");
       start_item(t);
       t.randomize();
       $display("-------------------------------------------------");
       `uvm_info("GEN", $sformatf("SEQ -> Driver wr=%0d din=%0d dout=%0d", t.wr, t.din, t.dout), UVM_NONE)
       finish_item(t);
       
     end
  endtask
    endclass

///////////////////////////////DRIVER///////////////////////////////
class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
  
  function new(input string inst= "driver" uvm_component parent=null);
    super.new(inst,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    
  endfunction
endclass
