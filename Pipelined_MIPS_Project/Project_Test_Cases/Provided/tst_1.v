module tst_1; 
	reg [31:0]PC_VALUE_;		  
	reg [31:0] cycle;
	Top top(PC_VALUE_);
	initial begin
 	$dumpfile("dump.vcd");
   		$dumpvars;

		PC_VALUE_ <= 100;	  
		cycle <= 1;
	end				   
	always @(posedge top.clk) begin	
	
	if (cycle == 14)
	begin
		$display("cycle: %d" , cycle);
		$display("PC: %d",top.program_counter);				   
		$display("$t0: %d" , top.regFile.registers_i[8], " The correct value is 4");
		$display("$t1: %d" , top.regFile.registers_i[9], " The correct value is 8");		
		$display("$t2: %d" , top.regFile.registers_i[10], " The correct value is 12");		
		$display("$t3: %d" , top.regFile.registers_i[11], " The correct value is 16");
		$display("$t4: %d" , top.regFile.registers_i[12], " The correct value is 20");
		$display("$t5: %d" , top.regFile.registers_i[13], " The correct value is 24");
		$display("$t6: %d" , top.regFile.registers_i[14], " The correct value is 28");
		$display("$t7: %d" , top.regFile.registers_i[15], " The correct value is 32");
				
		$finish;
		end
		
		
	cycle = cycle + 1;
		
	end
endmodule