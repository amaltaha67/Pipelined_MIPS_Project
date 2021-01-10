module ID_EXE(Ins_X, PC_plus4_X, Ext_X, ShiftLeft16_X, shift_op_X,  readdata1_X, readdata2_X, readdata3_tmp_X, regdst_X, memtoreg_X, aluop_X,alusrc_X, regwrite_X, regwriteF_X, memread_X, memwrite_X, storeByte_X,  bne_X, bfpc_X, branch_X, float_rs_X, float_rt_X, readdata1F_X, readdata2F_X, readdata_double1_X, readdata_double2_X, double_X, outADD_X, Ins_D, PC_plus4_D, Ext_D, ShiftLeft16_D, shift_op_D, readdata1_D, readdata2_D, readdata3_tmp_D, regdst_D, memtoreg_D, aluop_D,alusrc_D, regwrite_D, regwriteF_D, memread_D, memwrite_D, storeByte_D,  bne_D, bfpc_D, branch_D, float_rs_D, float_rt_D, readdata1F_D, readdata2F_D, readdata_double1_D, readdata_double2_D, double_D, outADD_D ,flush_ID_EXE, clk);
  
  input [31:0] Ins_D, PC_plus4_D, Ext_D, ShiftLeft16_D, readdata1_D, readdata2_D, readdata3_tmp_D, readdata1F_D, readdata2F_D, readdata_double1_D, readdata_double2_D, outADD_D; 
  input [1:0] regdst_D, memtoreg_D, alusrc_D;
  input [3:0] aluop_D;
  input double_D, float_rt_D, float_rs_D, branch_D, regwrite_D, regwriteF_D, memread_D, memwrite_D, storeByte_D, shift_op_D,  bne_D,bfpc_D, flush_ID_EXE, clk;
  
  output [31:0] Ins_X, PC_plus4_X, Ext_X, ShiftLeft16_X, readdata1_X, readdata2_X, readdata3_tmp_X, readdata1F_X, readdata2F_X, readdata_double1_X, readdata_double2_X, outADD_X; 
  output [1:0] regdst_X, memtoreg_X, alusrc_X;
  output [3:0] aluop_X;
  output double_X, float_rt_X, float_rs_X, branch_X, regwrite_X,regwriteF_X, memread_X, memwrite_X, storeByte_X, shift_op_X,  bne_X, bfpc_X; 
  
  reg [31:0] Ins_X, PC_plus4_X, Ext_X, ShiftLeft16_X, readdata1_X, readdata2_X, readdata3_tmp_X, readdata1F_X, readdata2F_X, readdata_double1_X, readdata_double2_X, outADD_X; 
  reg [1:0] regdst_X, memtoreg_X, alusrc_X;
  reg [3:0] aluop_X;
  reg double_X, float_rt_X, float_rs_X, branch_X, regwrite_X, regwriteF_X, memread_X, memwrite_X, storeByte_X, shift_op_X,  bne_X, bfpc_X;
  
  initial branch_X <= 0 ;
  always @ (posedge clk)
    begin
      
      if (flush_ID_EXE == 0)
        begin
            Ins_X <= Ins_D;
            PC_plus4_X <= PC_plus4_D;
            Ext_X <= Ext_D;
            ShiftLeft16_X <= ShiftLeft16_D;
            readdata1_X <= readdata1_D;
            readdata2_X <= readdata2_D;
            regdst_X <= regdst_D;
            memtoreg_X <= memtoreg_D;
            aluop_X <= aluop_D;
            alusrc_X <= alusrc_D;
            regwrite_X <= regwrite_D;
            regwriteF_X <= regwriteF_D;
            memread_X <= memread_D;
            memwrite_X <= memwrite_D;
            storeByte_X <= storeByte_D;
            shift_op_X <= shift_op_D;
      	    branch_X <= branch_D;
            bne_X <=  bne_D;
          	bfpc_X <= bfpc_D;
            readdata1F_X <= readdata1F_D;
            readdata2F_X <= readdata2F_D; 
            double_X <= double_D;
           	float_rs_X <= float_rs_D;
          	float_rt_X <= float_rt_D;
            readdata_double1_X <= readdata_double1_D;
            readdata_double2_X <= readdata_double2_D;
          readdata3_tmp_X <= readdata3_tmp_D; 
            outADD_X <= outADD_D;
        end
      else 
        begin
     
      	    branch_X <= 0;
        
        end
    
    
    end
  
endmodule 