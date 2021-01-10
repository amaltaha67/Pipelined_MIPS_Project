//declares a 32x32 register file.
module registerFile(rData1, rData2, rData3_tmp, rDataF1, rDataF2, readdata_double1, readdata_double2, rReg1, rReg2, rRegF1, rRegF2, wData, wData2, wReg, regWSig, regwrite_float, opcode, double, clk);
  
  input regWSig, regwrite_float, double, clk;
  input [5:0] opcode ; 
  input [4:0] rReg1, rReg2, wReg, rRegF1, rRegF2;
  input [31:0] wData, wData2;
  output [31:0] rData1, rData2, rDataF1, rDataF2, readdata_double1, readdata_double2, rData3_tmp; 
  reg [31:0] rData1, rData2, rDataF1, rDataF2, readdata_double1, readdata_double2, rData3_tmp; 
  
  reg [31:0] registers_i[31:0];
  reg [31:0] registers_f[31:0];
  
  integer i;
  
  

  initial
    begin
      for (i = 0 ; i<32 ; i = i+1)
        registers_i[i] <= 32'b0;
      
    //  for (i = 0 ; i<32 ; i = i+1)
      registers_f[0] <= 32'b00000001000000000000000000000000;
      registers_f[1] <= 32'b10000001110000000000000000000000;
      registers_f[2] <= 32'b10000011101100000000000000000000;
      registers_f[3] <= 32'b00000001000000000000000000000000;
      registers_f[4] <= 32'b00000001000000000000000000000000;
  	end
  always #1
    begin
      if (regWSig == 1 )
        registers_i[wReg] = wData ; 
      
      if (regwrite_float == 1)
        begin 
            registers_f[wReg] = wData ; 
              if (double == 1)
                registers_f[wReg+1] = wData2 ; 
        end
    end
  
  always @ (negedge clk) begin
	 rData1 = registers_i[rReg1] ; 
     rData2 = registers_i[rReg2] ; 
     rData3_tmp = registers_i[rRegF1] ; 
	  if ( opcode == 6'h31 || opcode == 6'h39 || opcode == 6'h35 || opcode == 6'h3d)
      begin
         rDataF1 = registers_f[rReg1] ;
        readdata_double1 = registers_f[rReg1+1] ;
      end
    else 
      begin
        rDataF1 = registers_f[rRegF1] ;
        readdata_double1 = registers_f[rRegF1+1] ;
      end
    rDataF2 = registers_f[rRegF2] ; 
    readdata_double2 = registers_f[rRegF2+1] ; 
  end
  
endmodule
