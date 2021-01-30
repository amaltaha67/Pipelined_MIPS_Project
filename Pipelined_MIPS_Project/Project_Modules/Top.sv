`include "ins_mem.sv"
`include "Control_Unit.sv"
`include "Register_File.sv"
`include "ALU_32b.sv"
`include "Data_Memory.sv"
`include "clock.sv"
`include "Basic_operations.sv"
`include "IF_IDreg.sv"
`include "ID_EXEreg.sv"
`include "EXE_MEMreg.sv"
`include "MEM_WBreg.sv"
`include "ForwardingUnit.sv"
`include "HazardDetectionUnit.sv"
`include "PC_reg.sv"
`include "Muxes.sv"
`include "Shifting_Comp.sv"
`include "Extensions.sv"

module Top(PC_Val);
  
  
  input [31:0] PC_Val;
  
  // general signals 
  wire clk;
  wire [31:0] program_counter;
  wire [31:0] PCin ; 
  wire [31:0] signExt, zeroExt, toALU, toALU2, toALU3, branch_target, PC_OR_branch,jumpORjr, writedata, writedata_double, out1, out2, readdata_1or2;
  wire alu_zero, alu_FPcond, jump, pcsrc, equal, equal1, equal2, and_br_eq, PC_write, PC_enable, sign, flush_IF_ID, flush_ID_EXE;
  wire[27:0] Shift_i;
  wire [1:0] ForwardA, ForwardB; 
  
 
  // IF instructions 
  wire [31:0] Ins_F, PC_plus4_F; 
  
  // ID instructions 
  wire [31:0] Ins_D, PC_plus4_D, Ext_D, ShiftLeft16_D, readdata1_D, readdata2_D, readdata3_tmp_D, readdata1F_D, readdata2F_D, readdata_double1_D, readdata_double2_D, outADD_D; 
  wire [1:0] regdst_D, memtoreg_D, alusrc_D;
  wire [3:0] aluop_D;
  wire  branch_D, double_D, float_rs_D, float_rt_D, regwrite_D, regwriteF_D, memread_D, memwrite_D, storeByte_D, shift_op_D,  bne_D, bfpc_D;
  
  // EX instructions 
  wire [31:0] Ins_X, PC_plus4_X, resultAlu_X, Ext_X, ShiftLeft16_X, readdata1_X, readdata2_X, readdata3_tmp_X, readdata1F_X, readdata2F_X, outADD_X, readdata_double1_X, readdata_double2_X, resultAlu_double_X; 
  wire [1:0] regdst_X, memtoreg_X, alusrc_X;
  wire [4:0] writereg_X; 
  wire [3:0] aluop_X;
  wire branch_X, double_X, float_rs_X, float_rt_X, regwrite_X, regwriteF_X, memread_X, memwrite_X, storeByte_X, shift_op_X,  bne_X, bfpc_X; 
  
  // MEM instructions 
  wire [31:0] PC_plus4_M, readdata2_M, resultAlu_M, resultAlu_double_M ,read_data_M, readdataMem_double_M, readdata_double2_M, ShiftLeft16_M; 
  wire [1:0] memtoreg_M;
  wire [4:0] writereg_M;
  wire double_M, regwrite_M, regwriteF_M, memread_M, memwrite_M, storeByte_M; 
  
  // WB instructions 
  wire [31:0] PC_plus4_W, PC_plus8, resultAlu_W, resultAlu_double_W, read_data_W, readdataMem_double_W, ShiftLeft16_W; 
  wire [1:0] memtoreg_W;
  wire [4:0] writereg_W;
  wire regwrite_W, regwriteF_W; 
  // -------------------------------------------------
  


  clock cl(clk);
  
 
// IF Stage: 

  PC_Init pc1(program_counter, PCin, PC_write, PC_Val, clk) ;
    
  instructionMemory im(Ins_F, program_counter);

  Adder_32bit add1(PC_plus4_F, program_counter, 32'd4);

  Adder_32bit add2(branch_target , outADD_X, PC_plus4_X);
  
  Mux_2to1_1bit mux_branch( equal1 ,bne_X, ~alu_zero, alu_zero);
  
  
  Mux_2to1_1bit mux_floatingCond( equal2 ,bfpc_X, ~alu_FPcond, alu_FPcond);
  
  Or_op or_op(equal, equal2, equal1) ; 

  And_op andop(and_br_eq, branch_X, equal);
  
 
  ShiftLeft_2bit sl2(outADD_D , Ext_D);
  

  
  Mux_2to1_32bit mx3(PC_OR_branch, and_br_eq,  branch_target, PC_plus4_F);
  

  Mux_2to1_32bit mx4(jumpORjr, jump, {PC_plus4_D[31:28], Shift_i}, readdata2_D);
  
 
  
  Mux_2to1_32bit mx5(PCin, pcsrc,  jumpORjr, PC_OR_branch);

  
  
  IF_ID IFtoID(Ins_D, PC_plus4_D, Ins_F, PC_plus4_F, flush_IF_ID, and_br_eq, pcsrc, clk);
  
  // -----------------------------------------------
  
// ID Stage


  ControlUnit cu(aluop_D, alusrc_D, regdst_D, memtoreg_D, regwrite_D, regwriteF_D, memread_D, memwrite_D, branch_D, bne_D, bfpc_D, double_D, float_rs_D, float_rt_D,sign, jump, pcsrc, Ins_D[31:26], Ins_D[25:21], Ins_D[5:0], storeByte_D, shift_op_D) ;
 
 
  ShiftLeft_2bit_i sli(Shift_i, Ins_D[25:0]);
  
 
  signExtension se(signExt , Ins_D[15:0]);
 
  zeroExtension ze(zeroExt , Ins_D[15:0]);
  
  Mux_2to1_32bit mx_signExt(Ext_D, sign, zeroExt, signExt); 
  
 
  ShiftLeft_16bit sll_16(ShiftLeft16_D, Ins_D[15:0]);
  
  
  registerFile regFile(readdata1_D, readdata2_D, readdata3_tmp_D, readdata1F_D, readdata2F_D, readdata_double1_D, readdata_double2_D, Ins_D[25:21], Ins_D[20:16], Ins_D[15:11], Ins_D[20:16], writedata, writedata_double, writereg_W, regwrite_W, regwriteF_W, Ins_D[31:26], double_D, clk);
  
    
  
  
    HzardDetection hu(PC_write, flush_IF_ID, flush_ID_EXE, pcsrc, and_br_eq, Ins_D[25:21], Ins_D[20:16], writereg_X, memread_X );
  

  ID_EXE IDtoEXE(Ins_X, PC_plus4_X, Ext_X, ShiftLeft16_X, shift_op_X,  readdata1_X, readdata2_X,readdata3_tmp_X, regdst_X, memtoreg_X, aluop_X,alusrc_X, regwrite_X, regwriteF_X, memread_X, memwrite_X, storeByte_X,  bne_X, bfpc_X, branch_X, float_rs_X, float_rt_X, readdata1F_X, readdata2F_X, readdata_double1_X, readdata_double2_X, double_X, outADD_X, Ins_D, PC_plus4_D, Ext_D, ShiftLeft16_D, shift_op_D, readdata1_D, readdata2_D, readdata3_tmp_D, regdst_D, memtoreg_D, aluop_D,alusrc_D, regwrite_D, regwriteF_D, memread_D, memwrite_D, storeByte_D,  bne_D, bfpc_D, branch_D, float_rs_D, float_rt_D, readdata1F_D, readdata2F_D, readdata_double1_D, readdata_double2_D, double_D, outADD_D, flush_ID_EXE, clk); 

 // ---------------------------------------
 // EXE Stage 

 
  ForwardingUnit fu(ForwardA, ForwardB, writereg_M, writereg_W, Ins_X[25:21], Ins_X[20:16], regwrite_M, regwrite_W, memwrite_X);

  
  Mux_2to1_32bit   mux_alu( readdata_1or2 ,shift_op_X, Ext_X, readdata1_X);
  Mux_3to1_32bits mxFwd1(out1, ForwardA, resultAlu_M, writedata, readdata_1or2); 
   
  Mux_3to1_32bits mxFwd2(out2, ForwardB,resultAlu_M, writedata, readdata2_X);
  
 
  Mux_4to1_5bits mx1(writereg_X, regdst_X , Ins_X[10:6],5'd31, Ins_X[15:11], Ins_X[20:16]);
  

  Mux_3to1_32bits mx2(toALU, alusrc_X,  readdata3_tmp_X, Ext_X, out2);
  
  Mux_2to1_32bit mx_FloatFS(toALU2, float_rs_X,  readdata1F_X, out1);
  
  Mux_2to1_32bit mx_FloatFt(toALU3, float_rt_X,  readdata2F_X, toALU);
  
  
  Alu_32 alu(resultAlu_X, resultAlu_double_X, alu_zero, alu_FPcond, toALU2, toALU3, aluop_X,readdata_double1_X, readdata_double2_X, double_X);

  EXE_MEM EXEtoMEM(PC_plus4_M, readdata2_M, resultAlu_M, resultAlu_double_M, ShiftLeft16_M,memtoreg_M, writereg_M, regwrite_M, regwriteF_M, memread_M, memwrite_M, storeByte_M, readdata_double2_M, double_M, PC_plus4_X, readdata2_X, resultAlu_X, resultAlu_double_X, ShiftLeft16_X,memtoreg_X, writereg_X, regwrite_X,regwriteF_X, memread_X, memwrite_X, storeByte_X, readdata_double2_X, double_X, clk);
  
// ---------------------------------------------------
 // MEM stage
 
  
  DataMemory dm(read_data_M, readdataMem_double_M, resultAlu_M , readdata2_M , readdata_double2_M, memwrite_M, memread_M, storeByte_M, double_M, clk);
  
  MEM_WB MEMtoWB(PC_plus4_W, resultAlu_W, resultAlu_double_W, ShiftLeft16_W, read_data_W, readdataMem_double_W, memtoreg_W, writereg_W, regwrite_W, regwriteF_W, PC_plus4_M, resultAlu_M, resultAlu_double_M, ShiftLeft16_M, read_data_M, readdataMem_double_M, memtoreg_M, writereg_M, regwrite_M, regwriteF_M, clk); 
  
//---------------------------------------
  // WB stage
  
  
   Adder_32bit add_jal(PC_plus8, PC_plus4_W, 32'd4);
  
  Mux_4to1_32bit mx6(writedata, memtoreg_W, ShiftLeft16_W, PC_plus8, read_data_W, resultAlu_W);
  
  Mux_2to1_32bit mux_double_wb(writedata_double, memtoreg_W[0],  readdataMem_double_W, resultAlu_double_W);
  
 
endmodule
