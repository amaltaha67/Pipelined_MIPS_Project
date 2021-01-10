module AddFloatS (res_float, a , b);
  input [31:0] a , b ; 
  output [31:0] res_float;
 
  	reg a_sign, b_sign, res_sign;
    reg [24:0] a_dec, b_dec, res_dec;
    reg [7:0] a_exp,b_exp,res_exp;
    reg [24:0] shift_amount,count;
  
	always@(*)begin 
		a_sign = a[31];
		b_sign = b[31];
		
        a_exp = a[30:23];
		b_exp = b[30:23];
    
      if(a[30:23] == 8'b0)
        a_dec = {2'b00,a[22:0]}; 	
      else
          a_dec = {2'b01,a[22:0]};
		
      if(b[30:23] == 8'b0)
        b_dec = {2'b00,b[22:0]};
	   else 
          b_dec = {2'b01,b[22:0]};
			

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
      if(res_dec[24] == 1) 
       begin  
      		res_exp = res_exp + 1;
      		res_dec = res_dec >> 1;
	 	end

      else if(res_dec[23] == 0)
       begin
         
		count = 0;
         
         while((res_dec[23] == 0) && count < 32)
          begin
			res_exp = res_exp - 1;
			res_dec = res_dec << 1;
			count = count +1;
 
		end
		
	 end
	end
  
  
	assign res_float[31] = res_sign;
    assign res_float[30:23] = res_exp;
    assign res_float[22:0] = res_dec;
  
  
endmodule