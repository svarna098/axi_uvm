class axi_subscriber extends uvm_subscriber # (trans);
 `uvm_component_utils (axi_subscriber)

  trans sub;
 

  covergroup cg ;
    a:coverpoint sub.AWADDR ;
    b:coverpoint sub.AWPROT ;
    c:coverpoint sub.AWVALID;
    d:coverpoint sub.WDATA;
    e:coverpoint sub.WSTRB ;
    f:coverpoint sub.WVALID;
    g :coverpoint sub.BREADY;
    h:coverpoint sub.ARADDR;
   
    j:coverpoint sub.ARVALID;
    k:coverpoint sub.RREADY;
   cross a,h;
  
  endgroup
 
 function new(string name="axi_subscriber",uvm_component parent);
super.new(name,parent);
 cg=new();
`uvm_info(get_name,"[subscriber]:INPUT RECIEVED",UVM_NONE)
endfunction
 
function void report_phase(uvm_phase phase);
super.report_phase(phase);
    `uvm_info(get_name,$sformatf(" COVERAGE = %0f",cg.get_coverage()),UVM_NONE)
     
  `uvm_info("COVERAGE",$sformatf("awaddr  = %0.2f%%",cg.a.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("awprot  = %0.2f%%",cg.b.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("awvalid  = %0.2f%%",cg.c.get_coverage()),UVM_LOW)
       `uvm_info("COVERAGE",$sformatf("wdata  = %0.2f%%",cg.d.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("wstrb  = %0.2f%%",cg.e.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("wvalid  = %0.2f%%",cg.f.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("bready  = %0.2f%%",cg.g.get_coverage()),UVM_LOW)
          `uvm_info("COVERAGE",$sformatf(" araddr = %0.2f%%",cg.h.get_coverage()),UVM_LOW)
         `uvm_info("COVERAGE",$sformatf("arvalid  = %0.2f%%",cg.j.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("rready  = %0.2f%%",cg.k.get_coverage()),UVM_LOW)
endfunction

 
function void write(trans t);
sub=t;
cg.sample();
endfunction
endclass

