
class axi_drv extends uvm_driver #(trans);
  
   axi_config cfg;
   virtual axi_if.drv vif ;
  `uvm_component_utils (axi_drv);
   
    bit [31:0] temp_addr ;
    bit [31:0] temp_data ;
    bit [31:0] temp_raddr ;
        bit aw_flag = 0;
    bit w_flag  = 0;



   function new ( string name= "axi_drv" , uvm_component parent );
     super.new ( name , parent );
   endfunction

   function void build_phase ( uvm_phase phase );
      super.build_phase (phase);
    if (!uvm_config_db #( axi_config ):: get (this," " , "axi_config",cfg))
        `uvm_fatal ( get_type_name() , " driver config fail ")
   endfunction

  function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      vif=cfg.vif;
  endfunction

   task run_phase (uvm_phase phase);
       wait (vif.drv_if.rst == 1) begin
        forever begin
             seq_item_port.get_next_item (req);
             drive_in (req);
             seq_item_port.item_done ();
              
        end
end
   endtask
  

task drive_in(trans d);


     if (!vif.drv_if.rst) begin

        vif.drv_if.AWVALID <= 0;
        vif.drv_if.WVALID <= 0;
        vif.drv_if.ARVALID <= 0;

        vif.drv_if.BREADY <= 0;
        vif.drv_if.RREADY <= 0;

        vif.drv_if.AWADDR  <= 0;
        vif.drv_if.WDATA  <= 0;
        vif.drv_if.ARADDR  <= 0;

        vif.drv_if.AWPROT <= 0;
        vif.drv_if.WSTRB  <= 0;
  end

    
    else begin
    @(vif.drv_if) 
    vif.drv_if.AWVALID <= d.AWVALID;
    vif.drv_if.WVALID  <= d.WVALID;
    vif.drv_if.ARVALID <= d.ARVALID;
    vif.drv_if.RREADY <= d.RREADY;
    vif.drv_if.AWPROT <= d.AWPROT; 
    vif.drv_if.ARPROT <= d.ARPROT;
    vif.drv_if.WSTRB  <= d.WSTRB;
    vif.drv_if.AWPROT <= d.AWPROT;
      
    if (d.AWVALID && aw_flag == 0) begin

        vif.drv_if.AWADDR <= d.AWADDR;
        aw_flag = 1;

    end

    if (d.WVALID && w_flag == 0) begin

        vif.drv_if.WDATA <= d.WDATA;
        w_flag = 1;

    end

    if (aw_flag == 1 && d.AWVALID && vif.drv_if.AWREADY) begin

        aw_flag = 0;


    end

    if (w_flag == 1 && d.WVALID && vif.drv_if.WREADY) begin

        w_flag = 0;
  

    end

    if (aw_flag == 0 && w_flag == 0) begin
        vif.drv_if.BREADY <= d.BREADY;
    end

    if (d.ARVALID) begin
        vif.drv_if.ARADDR <= d.ARADDR;
    end



    end
`uvm_info ("axi_driver " , $sformatf("axi_driver : awvalid=%d | awaddr=%d |  wvalid=%d  | wdata=%d | bready=%d | arvalid=%d | araddr=%d | rready=%d | arprot=%d | awprot=%d | wstrb=%d |",d.AWVALID , d.AWADDR ,d.WVALID ,d.WDATA ,d.BREADY ,d.ARVALID ,d.ARADDR ,d.RREADY ,d.ARPROT ,d.AWPROT ,d.WSTRB),UVM_NONE)
endtask

endclass
