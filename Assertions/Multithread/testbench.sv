// Code your testbench here
// or browse Examples


module test;
  
  bit req, ack;
  bit clk;
  
  property ack_chk();
    @(posedge clk) $rose(req) |-> ##[1:$] (ack) ##0 (1, $display("@%0t: Pass", $time));
  endproperty 
  
  SVA_ACK_CHK: assert property(ack_chk());
    
  property ack_chk_fm();
    @(posedge clk) $rose(req) |-> first_match(##[1:$] (ack)) ##0 (1, $display("@%0t: FM Pass", $time));
  endproperty 
  
    SVA_ACK_FM_CHK: assert property(ack_chk_fm());
    
  
  always 
    #5 clk =~ clk;
  
  initial begin 
    @(negedge clk);
    req = 1;
    $display("@%t: req=%b, ack=%b", $time, req, ack);
    @(negedge clk);
    req = 0;
    repeat(2) @(negedge clk);
    ack = 1;
    $display("@%t: req=%b, ack=%b", $time, req, ack);
    @(negedge clk);
    ack = 0;
    $display("@%t: req=%b, ack=%b", $time, req, ack);
    
    repeat(2) @(negedge clk);
    ack = 1;
    $display("@%t: req=%b, ack=%b", $time, req, ack);
    @(negedge clk);
    ack = 0;
    $display("@%t: req=%b, ack=%b", $time, req, ack);
    
    repeat(2) @(negedge clk);
    
    $finish();
    
  end
  
endmodule