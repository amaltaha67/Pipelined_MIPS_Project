module DataMemory (rData, rData2, addr, wData, wData2, memW, memR, storeByte, double, clk);
  input [31:0] addr, wData, wData2; 
  input double, memW, memR, clk, storeByte; 
  
  output [31:0] rData, rData2;
	
  reg [7:0] mem [1023:0]; // building a 1k memory //
  reg [31:0] rData , rData2; 
  
	integer i;
	
	initial
		begin
			for(i = 0; i <1024; i = i + 1)
				begin
					mem[i] <=  0;
					if((i+1)%4 == 0)
					mem[i] <= i+1;
                end
    // mem[3] 	= 4
	// mem[7] 	= 8
	// mem[11] 	= 12
	// mem[15] 	= 16
	// mem[19] 	= 20
	// mem[23] 	= 24
	// mem[27] 	= 28
	// mem[31] 	= 32	
			
		end
	
  always @( clk )
    begin
      if (memW == 1 && clk == 1) 
      begin
       
        if (storeByte == 0)
          begin
            
            mem[addr+3] = wData[7:0] ; 
            mem[addr+2] = wData[15:8];
            mem[addr+1] = wData[23:16];
            mem[addr] = wData[31:24] ;
            
            if (double == 1)
              begin
                mem[addr+7] = wData2[7:0] ; 
                mem[addr+6] = wData2[15:8];
                mem[addr+5] = wData2[23:16];
                mem[addr+4] = wData2[31:24] ;
              end
              
          end
        else 
          begin
            mem[addr+3] = wData[7:0] ; 
          end
      end
    
      if (memR == 1 & clk == 0) 
     begin
      rData = {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]}; 
       if (double == 1)
         rData2 = {mem[addr+4],mem[addr+5],mem[addr+6],mem[addr+7]}; 
     end
    end

endmodule

