class axi_reset_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_reset_sequence)

  function new(string name="axi_reset_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 0; WVALID == 0; ARVALID == 0; BREADY == 0; RREADY == 0;});
    finish_item(req);
  endtask
  endclass


class axi_write_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_write_read_sequence)

  function new(string name="axi_write_read_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 1;RREADY==1; BREADY == 1; AWADDR == 32'h08; WDATA == 32'd20; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
  endclass

class axi_write_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_write_sequence)

  function new(string name="axi_write_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; AWADDR == 32'h04; WDATA == 32'd20; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
  endclass


class axi_aw_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_sequence)

  function new(string name="axi_aw_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 0; ARVALID == 0; BREADY == 0; AWADDR == 32'h04;});
    finish_item(req);
  endtask
 endclass


class axi_w_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_w_sequence)

  function new(string name="axi_w_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 0; WVALID == 1; ARVALID == 0; BREADY == 1; WDATA == 32'd15; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
endclass


class axi_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_read_sequence)

  function new(string name="axi_read_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 0; WVALID == 0; ARVALID == 1; RREADY == 1; AWADDR == 32'h04;  WSTRB == 4'b1111;});
    finish_item(req);
  endtask
 endclass




class axi_valid_write_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_valid_write_sequence)

  function new(string name="axi_valid_write_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; AWADDR == 32'd00; WDATA == 32'd30; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
 endclass


class axi_invalid_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_invalid_sequence)

  function new(string name="axi_invalid_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; AWADDR == 32'h40; WDATA == 32'd17; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
  endclass

class axi_invalid_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_invalid_read_sequence)

  function new(string name="axi_invalid_read_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {ARVALID == 1; AWVALID == 0; WVALID == 0; RREADY == 1; BREADY == 0; ARADDR == 32'h40;});
    finish_item(req);
  endtask
  endclass

class axi_ro_write_sequence1 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_ro_write_sequence1)

  function new(string name="axi_ro_write_sequence1");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1;WVALID  == 1;ARVALID == 0; BREADY  == 1;RREADY  == 0;AWADDR  == 32'h28;WDATA   == 32'd11;WSTRB   == 4'b1111;});
    finish_item(req);
  endtask
 endclass

class axi_wo_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_wo_read_sequence)

  function new(string name="axi_wo_read_sequence");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'h34;});
    finish_item(req);
  endtask
 endclass


class axi_coverage_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_coverage_sequence)

  function new(string name="axi_coverage_sequence");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");
    for (int i=0;i<15;i++) begin
      start_item(req);
       assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; RREADY == 0;  WDATA == 32'd11; WSTRB == i; });
      finish_item(req);
    end
   
    req = trans::type_id::create("req");
    for (int i=0;i<30;i++) begin
      start_item(req);
       assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 1; BREADY == 0; RREADY == 1; WDATA==i; });
      finish_item(req);
    end


  endtask
endclass
