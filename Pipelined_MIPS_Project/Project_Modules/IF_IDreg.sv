module IF_ID(Ins_D,PC_plus4_D, Ins_F, PC_plus4_F, flush_IF_ID, branch_case, pcsrc, clk);
  input [31:0] Ins_F, PC_plus4_F; 
  input flush_IF_ID, branch_case, pcsrc, clk; 
  output [31:0] Ins_D, PC_plus4_D; 
  reg [31:0] Ins_D, PC_plus4_D; 
  always @(posedge clk)
    begin
     
      if (flush_IF_ID == 0)
        begin
        	Ins_D <= Ins_F;
        	PC_plus4_D <= PC_plus4_F; 
        end 
      else if (branch_case == 1 || pcsrc == 1)
    		Ins_D <= 0 ; 
       
    end
endmodule
