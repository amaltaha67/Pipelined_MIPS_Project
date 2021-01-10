module PC_Init(PCout, PCin, PC_write, PC_Val, clk);
  input [31:0] PCin, PC_Val;
  input PC_write, clk; 
  output [31:0] PCout;
  reg [31:0] PCout;
 
  initial  #1 PCout = PC_Val ; 
  always @ ( posedge clk)
    begin
      if (PC_write == 1)
        	PCout <= PCin;
    end
endmodule