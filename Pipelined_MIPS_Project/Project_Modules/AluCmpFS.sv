module CompareFloatS(FP_cond_alu, aluop, double, a, b);
  input [31:0] a,b ; 
  input [3:0] aluop ; 
  input double;
  output FP_cond_alu ; 
  reg FP_cond_alu;
  
  	reg a_sign,b_sign;
    reg [22:0] a_dec,b_dec;
    reg [7:0] a_exp,b_exp;
  
  initial FP_cond_alu = 0 ; 
  
  always @ (*)begin 
    a_sign = a[31] ; 
    b_sign = b[31] ;
    
    a_dec = a[22:0] ;
    b_dec = b[22:0] ; 
    
    a_exp = a[30:23] ; 
    b_exp = b[30:23] ; 
    
    if (aluop == 4'd14 && !double)
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