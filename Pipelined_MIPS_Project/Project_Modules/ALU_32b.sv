`include "AluAddFS.sv"
`include "AluAddFD.sv"
`include "AluCmpFS.sv"
`include "AluCmpFD.sv"

module Alu_32(res, res1, zero, FPcond, a, b, m, a1, b1, double);

  input  [31:0] a,b,a1,b1; // a1, b1 not implemented
  input  [3:0] m;
  input double; // not implemented
  
  output  [31:0] res, res1;
  output zero, FPcond;
  
  reg [31:0] res , res1;  // res1 not implemented yet
  reg zero, FPcond;
  
  reg [31:0] HI, LOW;
  wire [31:0] res_float;
  wire FP_cond_alu, FP_cond_alu_d;
  wire [63:0] in1 = {a, a1};
  wire [63:0] in2 = {b, b1} ; 
  wire [63:0] res_float_d ; 
  
   AddFloatS addFS(res_float, a , b);
   AddFloatD addFD(res_float_d, in1 , in2);
  
  CompareFloatS compFS(FP_cond_alu, m, double, a, b) ; 
  CompareFloatD compFD(FP_cond_alu_d, m, double, in1, in2) ; 
  integer i;
  
  initial  FPcond = 0 ;
  
  always @(a or b or m)
    begin 
   
     // res1 = 0 ; 
      if ( m == 4'd0 ) // or
        res <= a|b ; 
      else if ( m==4'd1) // and
        res <= a & b;
      else if (m == 4'd2) // sll
        res <= b<<a[10:6];
      else if (m == 4'd3) // add
        res <= a+b ; 
      else if (m == 4'd4) // nor
        res <= ~(a|b) ; 
      else if (m == 4'd5) // srl
        res <= b>>a[10:6] ; 
      else if (m == 4'd6 ) // slt
        res <= $signed(a)<$signed(b) ; 
      else if (m == 4'd7) // sub
        res <= $signed(b) - $signed(a) ; 
      else if (m == 4'd8) // mult
      {HI,LOW} <= a*b;
      else if (m == 4'd9) // divide
        begin 
          	LOW = a/b;
          	HI = a%b;       
        end
      else if (m == 4'd10) // mfhi
        res <= HI; 
      else if (m == 4'd11) // mflo
        res <= LOW;
      else if (m == 4'd13)
        begin 
          if (double == 0)
         	 #1 res<= res_float;
          else 
            begin
              #1 res<=res_float_d[63:32];  
              #1 res1 <= res_float[31:0]; 
            end
        end
      else if (m == 4'd14)
        #1 FPcond = FP_cond_alu | FP_cond_alu_d; 
      else if (m == 4'd12)
        begin 
          res = b ; 
          if ($signed(b) < 0)
            begin
              for (i = 0 ; i<a[10:6] ; i = i+1)
                begin
                  res = res>>1;
                  res[31] = 1;
                end
            end
          	else 
              res = res>>a[10:6] ; 
        end
      if (a == b)
        	zero <= 1 ;
      else 
        	zero <= 0 ;
    end
  
endmodule
