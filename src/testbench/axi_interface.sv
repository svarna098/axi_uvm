interface axi_if #(
parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 32,
   parameter MEM_DEPTH  = 16,
    parameter [2:0] DEFAULT_PROT = 3'b000
)
   (input clk ,input rst);

 
    logic [ADDR_WIDTH-1:0]      AWADDR;
    logic [2:0]                 AWPROT;
    logic                       AWVALID;
   logic                        AWREADY;

    logic [DATA_WIDTH-1:0]      WDATA;
    logic [(DATA_WIDTH/8)-1:0]  WSTRB;
    logic                       WVALID;
    logic                       WREADY;

    logic  [1:0]               BRESP;
    logic                      BVALID;
    logic                      BREADY;

    logic [ADDR_WIDTH-1:0]      ARADDR;
    logic [2:0]                 ARPROT;
    logic                       ARVALID;
    logic                       ARREADY;

    logic [DATA_WIDTH-1:0]      RDATA;
    logic  [1:0]                RRESP;
    logic                       RVALID;
    logic                       RREADY;

/*
clocking drv_if  @ (posedge clk );
  default input #1 output #1;

  input rst;
  output AWADDR , AWPROT ,AWVALID , WDATA,WSTRB,WVALID,BREADY,ARADDR,ARPROT,ARVALID ,RREADY;
  input AWREADY , WREADY , ARREADY ;
 
endclocking 
*/
clocking drv_if @(posedge clk);
  default input #1 output #1;

  input rst;

  // Master drives these
  output AWADDR, AWPROT, AWVALID;
  output WDATA, WSTRB, WVALID;
  output BREADY;
  output ARADDR, ARPROT, ARVALID;
  output RREADY;

  // Slave drives these (driver reads them)
  input AWREADY;
  input WREADY;
  input BRESP;
  input BVALID;
  input ARREADY;
  input RDATA;
  input RRESP;
  input RVALID;

endclocking

clocking in_mon_if @ (posedge clk);
  default input #1 output #1;
  
  input AWADDR , AWPROT ,AWVALID , WDATA,WSTRB,WVALID,BREADY,ARADDR,ARPROT,ARVALID ,RREADY , AWREADY , WREADY ,BRESP ,BVALID ,ARREADY ,RDATA ,RRESP ,RVALID;
  
endclocking

clocking out_mon_if @ (posedge clk);
  default input #1 output #1;

  input AWREADY , WREADY ,BRESP ,BVALID ,ARREADY ,RDATA ,RRESP ,RVALID;
endclocking 


modport drv (clocking drv_if);
modport in_mon (clocking in_mon_if );
modport out_mon (clocking out_mon_if );

property p1;
  @(posedge clk)
  disable iff (!rst)
  AWVALID && !AWREADY |=> (AWVALID throughout AWREADY[->1]);
endproperty

assert property(p1)
  else $error("AWVALID became 0 before AWREADY");


property p2;
  @(posedge clk)
  disable iff (!rst)
  WVALID && !WREADY |=> (WVALID throughout AWREADY[->1]);
endproperty

assert property(p2)
  else $error("WVALID became 0before WREADY");


property p3;
  @(posedge clk)
  disable iff (!rst)
  RVALID && !RREADY |=> (RVALID throughout AWREADY[->1]);
endproperty

assert property(p3)
  else $error("RVALID became 0 before RREADY");

property p4;
  @(posedge clk)
  disable iff (!rst)
  (AWVALID && AWREADY && WVALID && WREADY)
  |->  BVALID;
endproperty

assert property(p4)
  else $error("BVALID was not asserted after AW/W handshakes");
/*
property p5;
  @(posedge clk)
  disable iff (!rst)
   (AWVALID && AWREADY && WVALID && WREADY && (AWADDR > 32'h3C) )|-> ##[1:$] (BRESP == 2'b11);
endproperty

assert property(p5)
  else $error("Invalid address did not return DECERR");
*/
endinterface






   
