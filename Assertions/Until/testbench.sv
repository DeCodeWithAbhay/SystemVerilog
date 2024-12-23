// Code your design here
`timescale 1ns/1ns

module top;
  
  bit clk;
  
  bit a, b, c;
  
  initial begin
    forever	begin
  	#5 clk = ~clk;
    end
  end	
  
  initial begin
   
    #1;
    
    $display("**************************************************"); 
    $display("Case1:: a and b rise at same time . b and a falls at same time");
    $display("**************************************************"); 
    b = 1;
    a = 1;
    c = 0;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    
    repeat (3) begin 
      @(negedge clk);
      $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    end
    a = 0;
    b = 0;
    c = 1;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    @(negedge clk);
    
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    repeat (3) begin 
      @(negedge clk);
      $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    end
    
   
    $display("**************************************************"); 
    $display("Case2::PASS: a and b rise at same time . b falls after a");
    $display("**************************************************"); 
    b = 1;
    a = 1;
    c = 0;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    
    repeat (3) begin 
      @(negedge clk);
      $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    end
    a = 0;
    c = 1;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    @(negedge clk);
    b = 0;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    repeat (3) begin 
      @(negedge clk);
      $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    end
    
    $display("**************************************************"); 
    $display("Case2::FAIL: a and b rise at same time . b falls after a");
    $display("**************************************************"); 
    b = 1;
    a = 1;
    c = 0;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    
    repeat (3) begin 
      @(negedge clk);
      $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    end
    a = 0;
    //c = 0;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    @(negedge clk);
    b = 0;
    c = 1;
    $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);

    repeat (3) begin 
      @(negedge clk);
      $display("@%0t: a=%0b, b=%0b, c=%0b", $realtime, a, b, c);
    end

    $finish();
  end	
  
  

  property p_until_delayed_end();
    realtime t;
    @(posedge clk) $rose(b||a) |-> b until !a ##0 (1, $display("@%0t: Until Delayed: Ended a=%0b, b=%0b", $realtime, a, b))
    ##1 c;
  endproperty
  
   property p_until();
    realtime t;
     @(posedge clk) $rose(b||a) |-> b until !a ##0 (1, $display("@%0t: Until: Ended a=%0b, b=%0b", $realtime, a, b))
    ##0 c;
  endproperty
  
  property p_until_with_delayed_end();
    realtime t;
    @(posedge clk) $rose(b||a) |-> b until_with !a ##0 (1, $display("@%0t: Until With Delayed: Ended a=%0b, b=%0b", $realtime, a, b))
    ##1 c;
  endproperty
  
  property p_until_with();
    realtime t;
    @(posedge clk) $rose(b||a) |-> b until_with !a ##0 (1, $display("@%0t: Until With: Ended a=%0b, b=%0b", $realtime, a, b))
    ##0 c;
  endproperty


    ASSERT_UNTIL_DELAYED:assert property (p_until_delayed_end()) 
    else
      $error("FAIL ASSERT_UNTIL_DELAYED"); 
          
    ASSERT_UNTIL:assert property (p_until()) 
    else
      $error("FAIL ASSERT_UNTIL"); 
      
    
    ASSERT_UNTIL_WITH_DELAYED: assert property (p_until_with_delayed_end()) 
    else
      $error("FAIL ASSERT_UNTIL_WITH_DELAYED"); 
      
   
    ASSERT_UNTIL_WITH: assert property (p_until_with()) 
    else
      $error("FAIL ASSERT_UNTIL_WITH"); 

   // Dump waves
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, top);
   end   
      
  
endmodule