
`timescale 1ns / 1ps
module stimulus;
	reg x;
	reg y;
	wire z;
	comparator dut (
		.x(x), 
		.y(y), 
		.z(z)
	);
 
	initial
           begin
           $dumpfile("test.vcd");
           $dumpvars(0,stimulus);

 	   x = 0;
	   y = 0;
	   #20 y = 1;
	   #20 y = 0;		  
	   #80;
           end  
 
	initial
           begin
	   $monitor("x=%d,y=%d,z=%d \n",x,y,z);
	   end
 
        always #10 x = ~x;

	initial #2000 $finish;
endmodule