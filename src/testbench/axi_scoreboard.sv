class axi_scoreboard extends uvm_scoreboard ;
  `uvm_component_utils (axi_scoreboard)

  uvm_tlm_analysis_fifo # (trans) in_mon_scb;
  uvm_tlm_analysis_fifo # (trans) out_mon_scb;
 
  trans e;
  trans out_mon_t;           
  bit [31:0] mem [0:15];

typedef enum {idle, w_both, w_addr, w_data, w_resp} state_t;
state_t state;

typedef enum {r_idle, r_data} r_state_t;
r_state_t r_state;

bit [31:0] addr;
bit [31:0] Waddr;
bit [31:0]Wdata;
bit [31:0] Rdata;
bit [3:0]  strb;
bit [1:0] Rresp;
bit [1:0]Bresp;
bit Rvalid;
bit AWready;
bit ARready;
bit Wready;
bit Bvalid;
bit aw_flag;
bit w_flag;



  function new ( string name="axi_scoreboard" ,uvm_component parent);
       super.new (name,parent);
       in_mon_scb = new ("in_mon_scb",this);
       out_mon_scb =new ("out_mon_scb",this);
        // e = new("e");
   endfunction

 task run_phase (uvm_phase phase);
     super.run_phase (phase);
      
     forever begin
      in_mon_scb.get (e);
       reference ();
        `uvm_info ("axi_in_monitor_scb " , $sformatf("axi_in_monitor : awvalid=%d | awaddr=%d |  wvalid=%d  | wdata=%d | bready=%d | arvalid=%d | araddr=%d | rready=%d | arprot=%d |  awprot=%d | wstrb=%d |",e.AWVALID ,e.AWADDR ,e.WVALID ,e.WDATA ,e.BREADY ,e.ARVALID ,e.ARADDR ,e.RREADY ,e.ARPROT ,e.AWPROT ,e.WSTRB),UVM_NONE)
     
      out_mon_scb.get (out_mon_t);
       compare (out_mon_t );
      `uvm_info ("axi_out_monitor_scb" , $sformatf("axi_out_monitor : awready=%d | wready=%d |  bresp=%d  | bvalid=%d | arready=%d | rdata=%d | rresp=%d | rvalid=%d |",out_mon_t.AWREADY , out_mon_t.WREADY ,out_mon_t.BRESP ,out_mon_t.BVALID ,out_mon_t.ARREADY ,out_mon_t.RDATA ,out_mon_t.RRESP ,out_mon_t.RVALID ),UVM_NONE)
     end
 endtask

task compare(trans r);

  if(r.AWREADY === AWready)
    `uvm_info("AWREADY",$sformatf("PASS - DUT_AWREADY=%0d e_AWREADY=%0d",r.AWREADY, AWready), UVM_NONE)
  else
    `uvm_info("AWREADY",$sformatf("FAIL - DUT_AWREADY=%0d e_AWREADY=%0d",r.AWREADY, AWready), UVM_NONE)

  if(r.WREADY === Wready)
    `uvm_info("WREADY", $sformatf("PASS - DUT_WREADY=%0d e_WREADY=%0d",r.WREADY, Wready), UVM_NONE)
  else
    `uvm_info("WREADY",$sformatf("FAIL - DUT_WREADY=%0d e_WREADY=%0d",r.WREADY, Wready), UVM_NONE)

  if(r.BVALID === Bvalid)
    `uvm_info("BVALID",$sformatf("PASS - DUT_BVALID=%0d e_BVALID=%0d",r.BVALID, Bvalid), UVM_NONE)
  else
    `uvm_info("BVALID",$sformatf("FAIL - DUT_BVALID=%0d e_BVALID=%0d",r.BVALID, Bvalid), UVM_NONE)

  if(r.BRESP === Bresp)
    `uvm_info("BRESP", $sformatf("PASS - DUT_BRESP=%0d e_BRESP=%0d",r.BRESP, Bresp), UVM_NONE)
  else
    `uvm_info("BRESP",$sformatf("FAIL - DUT_BRESP=%0d e_BRESP=%0d",r.BRESP, Bresp), UVM_NONE)

  if(r.ARREADY === ARready)
    `uvm_info("ARREADY",$sformatf("PASS - DUT_ARREADY=%0d e_ARREADY=%0d",r.ARREADY, ARready), UVM_NONE)
  else
    `uvm_info("ARREADY",$sformatf("FAIL - DUT_ARREADY=%0d e_ARREADY=%0d",r.ARREADY, ARready), UVM_NONE)

  if(r.RVALID === Rvalid)
    `uvm_info("RVALID",$sformatf("PASS - DUT_RVALID=%0d e_RVALID=%0d",r.RVALID, Rvalid), UVM_NONE)
  else
    `uvm_info("RVALID", $sformatf("FAIL - DUT_RVALID=%0d e_RVALID=%0d",r.RVALID, Rvalid), UVM_NONE)

  if(r.RRESP === Rresp)
    `uvm_info("RRESP", $sformatf("PASS - DUT_RRESP=%0d e_RRESP=%0d",r.RRESP, Rresp), UVM_NONE)
  else
    `uvm_info("RRESP",$sformatf("FAIL - DUT_RRESP=%0d e_RRESP=%0d",r.RRESP, Rresp), UVM_NONE)

  if(r.RDATA === Rdata)
    `uvm_info("RDATA",$sformatf("PASS - DUT_RDATA=%0d e_RDATA=%0d",r.RDATA, Rdata), UVM_NONE)
  else
    `uvm_info("RDATA",$sformatf("FAIL - DUT_RDATA=%0d e_RDATA=%0d",r.RDATA, Rdata), UVM_NONE)

   $display("----------------------------------------------------------------------------------");
endtask

task reference();
  
 if (!e.rst) begin
    AWready = 0;
    Wready = 0;
    Bvalid = 0;
    Bresp = 0;
    Rvalid =0;
    ARready = 0;
    Rresp = 0;
    Rdata  = 0;

    aw_flag = 0;
    w_flag  = 0;

    state = idle;
    r_state = r_idle;
  end
  else begin

 case(state)

  idle : begin

    AWready = 1;
    Wready = 1;
    Bvalid = 0;

    aw_flag = 0;
    w_flag  = 0;

    if(e.AWVALID && e.WVALID)
      state = w_both;

  end


  w_both : begin

    AWready = 1;
    Wready = 1;

    if(e.AWVALID && AWready && (!aw_flag)) begin
      Waddr = e.AWADDR;
      aw_flag = 1;
    end

    if(e.WVALID && Wready && (!w_flag)) begin
      Wdata = e.WDATA;
      strb  = e.WSTRB;
      w_flag  = 1;
    end

    if(aw_flag && w_flag)
      state = w_resp;
    else if(aw_flag)
      state = w_data;
    else if(w_flag)
      state = w_addr;

  end


  w_addr : begin

    AWready = 1;
    Wready  = 0;

    if(e.AWVALID && AWready) begin
      Waddr = e.AWADDR;
      aw_flag = 1;

      if(w_flag)
        state = w_resp;
    end

  end


  w_data : begin

    AWready = 0;
    Wready  = 1;

    if(e.WVALID && Wready) begin
      Wdata  = e.WDATA;
      strb   = e.WSTRB;
      w_flag = 1;

      if(aw_flag)
        state = w_resp;
    end

  end


  w_resp : begin

    AWready = 0;
    Wready  = 0;
    Bvalid  = 1;

    if(Waddr > 32'h3C)
      Bresp = 2'b11;
    else if((Waddr/4) >= 32'd10 && (Waddr/4) <= 32'd12)
      Bresp = 2'b10;
    else begin
      Bresp = 2'b00;

      if(strb[0]) mem[Waddr/4][7:0]   = Wdata[7:0];
      if(strb[1]) mem[Waddr/4][15:8]  = Wdata[15:8];
      if(strb[2]) mem[Waddr/4][23:16] = Wdata[23:16];
      if(strb[3]) mem[Waddr/4][31:24] = Wdata[31:24];
    end

    if(e.BREADY)
      state = idle;

  end

endcase

  case(r_state)

    r_idle: begin

      ARready = 1;
      Rvalid=0;

      if(e.ARVALID &&ARready) begin
        addr  = e.ARADDR;
        r_state = r_data;
      end

    end

    r_data: begin
      Rvalid=1;

      if(Rvalid == 1)begin

      if(addr > 32'h3C) begin
        Rresp = 2'b11;
        Rdata = 32'd0;
      end

      else if((addr/4) >= 32'd13 && (addr/4) <= 32'd14) begin
        Rresp = 2'b10;
        Rdata = 32'd0;
      end

      else begin
        Rresp = 2'b00;
        Rdata = mem[addr/4];
      end

      if(e.RREADY)
        r_state = r_idle;

    end
end

  endcase
end
endtask
endclass
   
