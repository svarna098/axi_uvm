class trans extends uvm_sequence_item ;
	`uvm_object_utils(trans)
        bit rst;
	rand bit AWVALID;
 	rand bit WVALID;
 	rand bit ARVALID;
 	rand bit [31:0] AWADDR;
 	rand bit [31:0] WDATA;
 	rand bit [31:0] ARADDR;
 	rand bit BREADY;
        rand bit RREADY;
       rand bit [2:0] AWPROT;
       rand bit [2:0] ARPROT;
       rand bit [3:0] WSTRB;
        logic  AWREADY;
        logic  WREADY;
        logic  [1:0]BRESP;
        logic  BVALID;
        logic  ARREADY;
        logic  [31:0] RDATA;
        logic  [1:0]RRESP;
        logic  RVALID;
 
  constraint c { AWADDR inside {32'h04,32'd00,32'h40,32'h28,32'h34,32'd10,32'h08};}
  constraint c1 { WDATA inside {[0:30]};}
  constraint c2 {ARADDR inside {32'h04,32'd00,32'h40,32'h28,32'h34,32'd10,32'h08};}
        
  
 function new(string name="trans");
	super.new(name);
 endfunction

 endclass
 /*

 class trans1 extends trans;
      `uvm_object_utils (trans1)     

     constraint c3 { AWVALID == 1'b1; WVALID ==1'b1; }

   function new(string name="trans1");
	super.new(name);
  endfunction

 endclass

  class trans2 extends trans;
          `uvm_object_utils (trans2)     

     
     constraint c4 { ARVALID ==1'b1; RREADY ==1'b1; }
     
     
 function new(string name="trans2");
	super.new(name);
 endfunction
    
 endclass
 
 class trans3 extends trans;
      `uvm_object_utils (trans3)     

     constraint c3 { AWVALID == 1'b1; WVALID ==1'b1; ARVALID ==1'b0; RREADY ==1'b0; }

   function new(string name="trans3");
	super.new(name);
  endfunction

 endclass

  class trans4 extends trans;
          `uvm_object_utils (trans4)     

     
     constraint c4 { ARVALID ==1'b1; RREADY ==1'b1; AWVALID ==1'b0; WVALID ==1'b0; }
     
     
 function new(string name="trans4");
	super.new(name);
 endfunction
    
 endclass
 
 */
