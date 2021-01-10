module tst_4; 
	reg [31:0]PC_VALUE_;		  
	reg [31:0] cycle;
	Top top(PC_VALUE_);
	initial begin
		PC_VALUE_ <=400;	  
		cycle <= 1;
	end				   
	always @(posedge top.clk) begin	
	cycle = cycle + 1;
	if (cycle == 13)
	begin
		$display("cycle: %d" , cycle);
		$display("PC: %d",top.program_counter);				   
		$display("$s1: %d" , top.regFile.registers_i[19], " The correct value is 0");
		$display("$s2: %d" , top.regFile.registers_i[20], " The correct value is 10");		
		$display("$s3: %d" , top.regFile.registers_i[21], " The correct value is 15");		
		
		$finish;
		end
		
		
	
		
	end
endmodule