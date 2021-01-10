module CompareFloatD(FP_cond_alu, aluop, double, a, b);
  input [63:0] a,b ; 
  input [3:0] aluop ; 
  input double;
  output FP_cond_alu ; 
  reg FP_cond_alu;
  
  	reg a_sign,b_sign;
  reg [51:0] a_dec,b_dec;
  reg [10:0] a_exp,b_exp;
  
  initial FP_cond_alu = 0 ; 
  
  always @ (*)begin 
    a_sign = a[63] ; 
    b_sign = b[63] ;
    
    a_dec = a[51:0] ;
    b_dec = b[51:0] ; 
    
    a_exp = a[62:52] ; 
    b_exp = b[62:52] ; 
    
    if (aluop == 4'd14 && double)
      begin
        if (a == b)
          	FP_cond_alu = 1; 
        else 
          begin
            if ((a_sign == b_sign) && (a_sign == 0))
              begin  
                if (a_exp < b_exp)
                  FP_cond_alu = 1;
                else if (a_exp == b_exp) 
                  begin
                    if (a_dec <= b_dec)
                      FP_cond_alu = 1;
                    else
                      FP_cond_alu = 0;
                end
                else 
                  FP_cond_alu = 0;
            end

            else if ((a_sign == b_sign) && (a_sign == 1))
              begin  
                if (a_exp > b_exp) 
                  FP_cond_alu = 1;
                else if (a_exp == b_exp)
                  begin
                  if (a_dec >= b_dec) 
                      FP_cond_alu = 1;
                    else 
                      FP_cond_alu = 0;
                end
                else FP_cond_alu = 0;
            end

            else   
                FP_cond_alu = a_sign;
          
          end
          	
      end
  
  end
endmodule