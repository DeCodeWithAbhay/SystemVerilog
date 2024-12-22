// Code your design here
`timescale 1ns/1ps

module top;
  
  bit clk;
  
  bit a, b, c;
  
  initial begin
    forever	begin
  	#5 clk = ~clk;
    end
  end	
  
  initial begin
    $display("Case1::a and b rise and fall at same time ."); 
   #1;//a and b rise and fall in the same cycle
    @(negedge clk) 
    b = 1;
    a = 1;
    repeat (3)@(negedge clk);
    a = 0;
    b = 0;
    repeat (3)@(negedge clk);    
    
    $display("Case2::a and b rise at same time . b falls after a"); 
    b = 1;
    a = 1;
    repeat (3)@(negedge clk);
    a = 0;
    @(negedge clk);
    b = 0;
     repeat (3)@(negedge clk);
    
    $display("Case3::b rise before a. a and b falls at same time"); 
    b = 1;
    @(negedge clk);
    a = 1;
    repeat (3)@(negedge clk);
    a = 0;
    b = 0;
    repeat (3)@(negedge clk);
    
    $display("Case4::b rise before a. b falls after a"); 
    b = 1;
    @(negedge clk);
    a = 1;
    repeat (3)@(negedge clk);
    a = 0;
    @(negedge clk);
    b = 0;
    
    repeat (3)@(negedge clk);
    
    $finish();
  end	
  
  
  property p_throughout();
    realtime t;
    @(posedge clk) $rose(b) |-> b throughout (!a[->1]) ##0 (1, $display("@%0t: Throughout: Ended a=%0b, b=%0b", $realtime, a, b));
  endproperty
  
  property p_until();
    realtime t;
    @(posedge clk) $rose(b) |-> b until !a ##0 (1, $display("@%0t: Until: Ended a=%0b, b=%0b", $realtime, a, b));
  endproperty
  
  property p_until_with();
    realtime t;
    @(posedge clk) $rose(b) |-> b until_with !a ##0 (1, $display("@%0t: Until With: Ended a=%0b, b=%0b", $realtime, a, b));
  endproperty

  
  property p_within();
    realtime t;
    @(posedge clk) $rose(b) |-> !b[->1] within !a[->1] ##0 (1, $display("@%0t: Within: Ended a=%0b, b=%0b", $realtime, a, b));
  endproperty
  
 
    ASSERT_THROUGHT: assert property (p_throughout()) 
    else
      $error("FAIL ASSERT_THROUGHT");
    
    ASSERT_UNTIL:assert property (p_until()) 
    else
      $error("FAIL ASSERT_UNTIL"); 
   
    ASSERT_UNTIL_WITH: assert property (p_until_with()) 
    else
      $error("FAIL ASSERT_UNTIL_WITH"); 
      
    ASSERT_WITHIN: assert property (p_within()) 
    else
      $error("FAIL ASSERT_WITHIN"); 
      
   // Dump waves
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, top);
   end   
      
  
endmodule