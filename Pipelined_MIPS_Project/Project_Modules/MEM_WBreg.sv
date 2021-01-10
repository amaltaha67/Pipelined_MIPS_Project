module MEM_WB (PC_plus4_W, resultAlu_W, resultAlu_double_W, ShiftLeft16_W, read_data_W, readdataMem_double_W, memtoreg_W, writereg_W, regwrite_W, regwriteF_W, PC_plus4_M, resultAlu_M, resultAlu_double_M, ShiftLeft16_M, read_data_M, readdataMem_double_M,  memtoreg_M, writereg_M, regwrite_M, regwriteF_M, clk);

	
  input [31:0] PC_plus4_M, resultAlu_M, resultAlu_double_M, read_data_M, ShiftLeft16_M, readdataMem_double_M; 
  input [1:0] memtoreg_M;
  input [4:0] writereg_M;
  input regwrite_M,regwriteF_M, clk; 
  
  output [31:0] PC_plus4_W, resultAlu_W, resultAlu_double_W, read_data_W , readdataMem_double_W, ShiftLeft16_W; 
  output [1:0] memtoreg_W;
  output [4:0] writereg_W;
  output regwrite_W ,regwriteF_W; 
  
  reg [31:0] PC_plus4_W, resultAlu_W, resultAlu_double_W, read_data_W,readdataMem_double_W, ShiftLeft16_W; 
  reg [1:0] memtoreg_W;
  reg [4:0] writereg_W;
  reg regwrite_W, regwriteF_W; 
  
  always @ (posedge clk)
    begin 
    	PC_plus4_W <= PC_plus4_M;
      	resultAlu_W <= resultAlu_M;
    	read_data_W <= read_data_M;
    	ShiftLeft16_W <= ShiftLeft16_M;
        memtoreg_W <= memtoreg_M;
      	writereg_W <= writereg_M;
      	regwrite_W <= regwrite_M;
        regwriteF_W <= regwriteF_M;
        resultAlu_double_W <= resultAlu_double_M;
        readdataMem_double_W <= readdataMem_double_M;
    end
  
endmodule