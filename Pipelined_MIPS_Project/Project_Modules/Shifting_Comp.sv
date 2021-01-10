

module ShiftLeft_2bit_i(out, in);
  input [25:0] in ; 
  output [27:0] out; 
  reg [27:0] out; 
  always @ (in) out <= in<<2;
  
endmodule

module ShiftLeft_2bit(out, in);
  input [31:0] in ; 
  output [31:0] out ; 
  reg [31:0] out ; 
  always @ (in) out <= in<<2;
 
endmodule

module ShiftLeft_16bit(out, in);
  input [15:0] in ; 
  output  [31:0] out ; 
  reg [31:0] out ; 
  always @ (in) out <= in<<16;
 
endmodule
