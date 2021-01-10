
module Mux_4to1_5bits(out, s, in3, in2, in1, in0);
  input [4:0] in3, in2, in1, in0;
  input [1:0] s;
  output [4:0]out;
  reg [4:0]out;
  
  always @ (*)
   begin
     if (s == 0)
       out <= in0;
     else if (s == 1)
       out <= in1 ; 
     else if (s == 2)
       out <= in2 ; 
     else 
       out <= in3 ;
   end
endmodule

module Mux_3to1_32bits(out, s, in2, in1, in0);
  input [31:0] in2, in1, in0;
  input [1:0] s;
  output [31:0]out;
  reg [31:0]out;
  
  always @ (in1 or in2 or in0 or s)
   begin
     if (s == 0)
       out <= in0;
     else if (s == 1)
       out <= in1 ; 
     else 
       out <= in2 ; 
   end
endmodule

module Mux_4to1_32bit(out, s, in3, in2, in1, in0);
  input [31:0] in3, in2, in1, in0;
  input [1:0] s;
  output [31:0] out;
  reg [31:0] out;
  always @ (in1 or in2 or in3 or in0 or s)
   begin
     if (s == 2'd0)
       out <= in0;
     else if (s == 2'd1)
       out <= in1 ; 
     else if (s == 2'd2)
       out <= in2 ; 
     else 
       out <= in3; 
   end
endmodule

module Mux_2to1_32bit(out, s,  in1, in0);
  input [31:0] in1, in0;
  input s;
  output [31:0] out;
  reg [31:0] out;

  always @ (in1 or in0 or s)
   begin
     if (s == 1'd0)
      out <= in0;
     else
      out <= in1 ; 
   end
endmodule

module Mux_2to1_1bit(out, s,  in1, in0);
  input  in1, in0;
  input s;
  output  out;
  reg  out;

  always @ (in1 or in0 or s)
   begin
     if (s == 1'd0)
      out <= in0;
     else
      out <= in1 ; 
   end
endmodule
