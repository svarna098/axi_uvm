class axi_test extends uvm_test ;
  `uvm_component_utils (axi_test)

  axi_environment env;
  axi_config m_cfg;
  
  function new (string name =" axi_test" , uvm_component parent );
     super.new (name ,parent );
  endfunction

 function void build_phase (uvm_phase phase );
    super.build_phase (phase);
   
    m_cfg=axi_config::type_id::create("m_cfg");
  
    if(!uvm_config_db#(virtual axi_if)::get(this,"","axi_if",m_cfg.vif))
	`uvm_fatal(get_type_name(),"Can't get the interface")
         m_cfg.input_agent_is_active=UVM_ACTIVE;
         m_cfg.output_agent_is_active=UVM_PASSIVE;

    uvm_config_db#(axi_config)::set(this,"*","axi_config",m_cfg);

    env=axi_environment::type_id::create("env",this);

 endfunction

 function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
 endfunction

endclass

class test1 extends axi_test;

  `uvm_component_utils(test1)

  axi_reset_sequence  reset_seq;
  axi_write_read_sequence s2;
  axi_write_sequence s3;
  axi_aw_sequence  s4;
  axi_w_sequence  s5;
  axi_read_sequence  s6;
  axi_valid_write_sequence s7;
  axi_invalid_sequence s8;
  axi_invalid_read_sequence s9;
  axi_ro_write_sequence1 s10;
  axi_wo_read_sequence s11;
  axi_coverage_sequence s12;

  function new(string name="test1", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    reset_seq = axi_reset_sequence::type_id::create("reset_seq");
    s2 = axi_write_read_sequence::type_id::create("s2");
    s3 = axi_write_sequence::type_id::create("s3");
    s4 = axi_aw_sequence::type_id::create("s4");
    s5 = axi_w_sequence::type_id::create("s5");
    s6 = axi_read_sequence::type_id::create("s6");
    s7 = axi_valid_write_sequence::type_id::create("s7");
    s8 = axi_invalid_sequence::type_id::create("s8");
    s9 = axi_invalid_read_sequence::type_id::create("s9");
    s10 = axi_ro_write_sequence1::type_id::create("s10");
    s11 = axi_wo_read_sequence::type_id::create("s11");
    s12 = axi_coverage_sequence::type_id::create("s12");

    reset_seq.start(env.in_agnt.seq);
    s2.start(env.in_agnt.seq);
    s3.start(env.in_agnt.seq);
    s4.start(env.in_agnt.seq);
    s5.start(env.in_agnt.seq);
    s6.start(env.in_agnt.seq);
    s7.start(env.in_agnt.seq);
    s8.start(env.in_agnt.seq);
    s9.start(env.in_agnt.seq);
    s10.start(env.in_agnt.seq);
    s11.start(env.in_agnt.seq);
    s12.start(env.in_agnt.seq);

    #50;

    phase.drop_objection(this);

  endtask
endclass
