module EXE_MEM(PC_plus4_M, readdata2_M, resultAlu_M, resultAlu_double_M, ShiftLeft16_M, memtoreg_M, writereg_M, regwrite_M, regwriteF_M, memread_M, memwrite_M, storeByte_M, readdata_double2_M, double_M, PC_plus4_X, readdata2_X, resultAlu_X, resultAlu_double_X, ShiftLeft16_X, memtoreg_X, writereg_X, regwrite_X, regwriteF_X, memread_X, memwrite_X, storeByte_X, readdata_double2_X, double_X, clk);

  input [31:0] PC_plus4_X, readdata2_X, resultAlu_X, resultAlu_double_X, ShiftLeft16_X, readdata_double2_X; 
  input [1:0] memtoreg_X;
  input [4:0] writereg_X;
  input double_X, regwrite_X, regwriteF_X, memread_X, memwrite_X, storeByte_X, clk; 
  
  output [31:0] PC_plus4_M, readdata2_M, resultAlu_M, resultAlu_double_M, ShiftLeft16_M, readdata_double2_M; 
  output [1:0] memtoreg_M;
  output [4:0] writereg_M;
  output double_M, regwrite_M,regwriteF_M, memread_M, memwrite_M, storeByte_M; 
  
  reg [31:0] PC_plus4_M, readdata2_M, resultAlu_M, resultAlu_double_M, ShiftLeft16_M, readdata_double2_M; 
  reg [1:0] memtoreg_M;
  reg [4:0] writereg_M;
  reg double_M, regwrite_M, regwriteF_M, memread_M, memwrite_M, storeByte_M; 
  
  
  always @ (posedge clk)
    begin
    	PC_plus4_M <= PC_plus4_X;
        readdata2_M <= readdata2_X;
    	resultAlu_M <= resultAlu_X;
        ShiftLeft16_M <= ShiftLeft16_X;
      	memtoreg_M <= memtoreg_X;
      	writereg_M <= writereg_X;
      	regwrite_M <= regwrite_X;
      	regwriteF_M <= regwriteF_X;
      	memread_M <= memread_X;
      	memwrite_M <= memwrite_X;
      	storeByte_M <= storeByte_X;
        double_M <= double_X;
        readdata_double2_M <= readdata_double2_X;
        resultAlu_double_M <= resultAlu_double_X;
    end
  
  
endmodule
