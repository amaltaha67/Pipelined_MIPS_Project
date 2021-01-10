module Adder_32bit(out, a, b);
  input [31:0] a, b ; 
  output [31: 0] out;
  reg [31: 0] out;
  always @ (a or b) out <= a+b ; 
endmodule

module And_op(out, a, b);
  input  a, b ; 
  output out;
   reg out; 
  always @ (a or b) out <= a&b ; 
endmodule

module Or_op(out, a, b);
  input  a, b ; 
  output out;
   reg out; 
  always @ (a or b) out <= a|b ; 
endmodule


