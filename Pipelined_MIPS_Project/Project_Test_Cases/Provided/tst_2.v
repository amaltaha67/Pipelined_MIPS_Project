module tst_2; 
	reg [31:0]PC_VALUE_;		  
	reg [31:0] cycle;
	Top top(PC_VALUE_);
	initial begin
		PC_VALUE_ <= 200;	  
		cycle <= 1;
	end				   
	always @(posedge top.clk) begin	

	if (cycle == 12)
	begin
		$display("cycle: %d" , cycle);
		$display("PC: %d",top.program_counter);				   
		$display("$s1: %d" , top.regFile.registers_i[19], " The correct value is 5");
		$display("$s2: %d" , top.regFile.registers_i[20], " The correct value is 10");		
		$display("$s3: %d" , top.regFile.registers_i[21], " The correct value is 3");		
		$display("$s4: %d" , top.regFile.registers_i[22], " The correct value is 2");
		$display("$s5: %d" , top.regFile.registers_i[23], " The correct value is 15");
		$display("$s6: %d" , top.regFile.registers_i[24], " The correct value is -2  *** Check reporesentation");		
				
		$finish;
		end
			cycle = cycle + 1;
		
		
	
		
	end
endmodule