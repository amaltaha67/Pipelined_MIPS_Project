
module signExtension(out, in);
  input [15:0] in ; 
  output [31:0] out;
  reg [31:0] out;
  always @ (in)
    begin
  	  if (in[15] == 1'b1)
        out <= {16'hffff, in}; 
      else 
        out <= {16'h0, in}; 
    end
endmodule


module zeroExtension(out, in);
  input [15:0] in ; 
  output [31:0] out;
  reg [31:0] out;
  always @ (in) out <= {16'h0, in}; 
    
endmodule

