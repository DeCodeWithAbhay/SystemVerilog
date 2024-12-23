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
  
  
  property p_throughout();
    realtime t;
    @(posedge clk) ($rose(b || a), $display("@%0t: Throughout: Started a=%0b, b=%0b", $realtime, a, b)) |-> 
    b throughout (!a[->1]) ##0 
    (1, $display("@%0t: Throughout: Ended a=%0b, b=%0b", $realtime, a, b)) ##0 c;
  endproperty
  

 
  ASSERT_THROUGHT: assert property (p_throughout()) 
    else
      $error("FAIL ASSERT_THROUGHT");
         
   // Dump waves
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, top);
   end   
      
  
endmodule