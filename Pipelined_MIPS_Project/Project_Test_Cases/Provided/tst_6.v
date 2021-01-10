module tst_6; 
	reg [31:0]PC_VALUE_;		  
	reg [31:0] cycle;
	Top top(PC_VALUE_);
	initial begin
		PC_VALUE_ <= 600;	  
		cycle <= 1;
	end				   
	always @(posedge top.clk) begin	
if (cycle== 11)	
begin
		$display("cycle: %d" , cycle);
		$display("PC: %d",top.program_counter);				   
		$display("$s1: %d" , top.regFile.registers_i[19], " The correct value is 5");
		$display("$s2: %d" , top.regFile.registers_i[20], " The correct value is 10");		
		$display("$s3: %d" , top.regFile.registers_i[21], " The correct value is 3");		
		$display("$s4: %d" , top.regFile.registers_i[22], " The correct value is 25");
		$display("$s5: %d" , top.regFile.registers_i[23], " The correct value is 28");	
		
		$finish;
		end
		cycle = cycle + 1;
	end
endmodule