module AddFloatD (res_float, a , b);
  input [63:0] a , b ; 
  output [63:0] res_float;
 
  	reg a_sign, b_sign, res_sign;
  reg [53:0] a_dec, b_dec, res_dec;
  reg [10:0] a_exp,b_exp,res_exp;
  reg [53:0] shift_amount,count;
  
	always@(*)begin 
      a_sign = a[63];
      b_sign = b[63];
		
      a_exp = a[62:52];
      b_exp = b[62:52];
    
      if(a[62:52] == 11'b0)
        a_dec = {2'b00,a[51:0]}; 	
      else
        a_dec = {2'b01,a[51:0]};
		
      if(b[62:52] == 11'b0)
        b_dec = {2'b00,b[51:0]};
	   else 
         b_dec = {2'b01,b[51:0]};
			

      if(a_exp == b_exp)
        begin 
		res_exp = a_exp;
        
          if(a_sign == b_sign)
        	begin
				res_dec = a_dec + b_dec;
				res_sign = a_sign;
			end 
		else 
          begin 
         
            if(a_dec > b_dec)
            	begin
					res_dec = a_dec - b_dec; 
					res_sign = a_sign;
				end 
			else
              begin
				res_dec = b_dec - a_dec;
				res_sign = b_sign;
			end
		end
	end 
	else 
      begin 
      

        if(a_exp > b_exp)begin
			res_exp = a_exp;
			res_sign = a_sign;
			
          	shift_amount = a_exp - b_exp;
          
			b_dec = b_dec >> shift_amount;
          
          if (a_sign == b_sign)
				res_dec = a_dec + b_dec;
        else
          	res_dec = a_dec - b_dec;
		end
		else 
          begin 
			res_exp = b_exp;
			
            res_sign = b_sign;
			
            shift_amount = b_exp - a_exp;
			
            a_dec = a_dec >> shift_amount;
            if (a_sign == b_sign)
				res_dec = a_dec + b_dec;
        else
          	res_dec = b_dec - a_dec;
		end
	end
	
	//normalize
      if(res_dec[53] == 1) 
       begin  
      		res_exp = res_exp + 1;
      		res_dec = res_dec >> 1;
	 	end

      else if(res_dec[52] == 0)
       begin
         
		count = 0;
         
         while((res_dec[52] == 0) && count < 64)
          begin
			res_exp = res_exp - 1;
			res_dec = res_dec << 1;
			count = count +1;
 
		end
		
	 end
	end
  
  
  assign res_float[63] = res_sign;
  assign res_float[62:52] = res_exp;
  assign res_float[51:0] = res_dec;
  
  
endmodule