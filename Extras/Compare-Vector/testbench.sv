// Code your testbench here
// or browse Examples

module test;
  
initial begin
  
  bit [1:0] a, b;
  a = 2'b10;
  b = 2'b01;
  
 if(a == 1'b0)//Any non zero value is considered as true.
   $display("a:True"); 
  else
    $display("a:False");
  	
  if(b == 1'b0)
    $display("b:True");
  else
    $display("b:False");
  
  
end	
  
  
endmodule
