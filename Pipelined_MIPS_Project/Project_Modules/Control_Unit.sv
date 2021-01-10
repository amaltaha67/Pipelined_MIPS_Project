module ControlUnit(AluOp, AluSrc, regDst, memToReg, regWrite, regwriteF, memRead,
                   memWrite, branch, bne, bfpc, double, float_rs, float_rt, sign, jump, pcSrc, opcode, fmt ,fun, storeByte, shift_op);
  input [5:0] opcode, fun; 
  input [4:0] fmt;
  output [3:0] AluOp;
  output [1:0] regDst, memToReg, AluSrc;
  output  regWrite, regwriteF, memRead, memWrite, branch, jump, pcSrc, storeByte, bne, bfpc, sign, shift_op, float_rs, float_rt, double;
  reg [3:0] AluOp;
  reg [1:0] regDst, memToReg, AluSrc;
  reg regWrite,regwriteF, memRead, memWrite, branch, jump, pcSrc, storeByte, sign, bne, bfpc, shift_op, float_rs, float_rt, double;
  /* 
  you can view the whole control signals sheet on link:
  
  https://docs.google.com/spreadsheets/d/1wwzyYd8OKr9A75yAvdk2ruoWsFogmoz1NS6GEC61Mic/edit?	usp=sharing
  */
  
  // float rs & rt not implemented yet
   
  always @ (opcode or fun)
    begin
      //// added recently for fp 
      	// bfpc(floating point branch condtion)
      
        if (opcode == 6'h11 && fmt == 5'h8 && fun == 6'h1)
            bfpc<= 1 ;
        else 
            bfpc<= 0 ;
      
        // float_fs 
      if (opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11) || opcode == 6'h31 || opcode == 6'h39 || opcode == 6'h35 || opcode == 6'h3d)
            float_rs <= 1 ;     
        else 
          	float_rs <= 0 ;
     
      if (opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11))
            float_rt <= 1 ;     
        else 
          	float_rt <= 0 ;
      
      
      if (opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11) && fun == 0 ||opcode == 6'h31  || opcode == 6'h35)
            regwriteF <= 1 ;     
        else 
          	regwriteF <= 0 ;
       	  
      
      /////////
      
      
      // AluOp
      // AluOp[3]
      if (opcode == 6'h3 && (fun == 6'h1a || fun == 6'h10 || fun == 6'h12 || fun == 6'h18 || fun == 6'h3) || opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11))
        	 AluOp[3] <= 1; 
      	  else 
       		  AluOp[3] <= 0;
      
          // ALUOP[2]
      if (opcode == 6'h3 && (fun == 6'h24|| fun == 6'h2a || fun == 6'h27 || fun == 6'h2 || fun == 6'h3) || opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11))
            AluOp[2] <= 1; 
      	  else 
            AluOp[2] <= 0;
      
          // ALUOP[1]
          if (opcode == 6'h3 && (fun == 6'h20 || fun == 6'h2a || fun == 6'h24 || fun == 6'h13
                                 || fun == 6'h0  || fun == 6'h21  || fun == 6'h10 || fun == 6'h12)
              || opcode == 6'h9  || opcode == 6'h12 || opcode == 6'h2b || opcode == 6'h28 || opcode == 6'h31 || opcode == 6'h39  || opcode == 6'h35 || opcode == 6'h3d ||  opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11) && fun != 0)
            AluOp[1] <= 1; 
    	  else 
       	    AluOp[1] <= 0;

          // ALUOP[0]
          if (opcode == 6'h3 && (fun == 6'h20 || fun == 6'h14 ||  fun == 6'h13
                                 || fun == 6'h24 || fun == 6'h2 || fun == 6'h21 || fun == 6'h1a || fun == 6'h12 )
              || opcode == 6'h9  || opcode == 6'hc || opcode == 6'h12 || opcode == 6'h2b 
              || opcode == 6'h28  || opcode == 6'h31 || opcode == 6'h39 || opcode == 6'h35 || opcode == 6'h3d || opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11) && fun == 0)
            AluOp[0] <= 1; 
          else 
            AluOp[0] <= 0; 


      // regDst 

          // regDst[1]
      if (opcode == 6'h7 || opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11) && fun == 0)
            regDst[1] <= 1 ; 
      	  else 
            regDst[1] <= 0 ;

          // regDst[0]
          if (opcode == 6'h3 && (fun == 6'h24|| fun == 6'h2a || fun == 6'h27  || fun == 6'h25
                                || fun == 6'h14 || fun == 6'h20 || fun == 6'h0 || fun == 6'h2 || fun == 6'h3 || fun == 6'h10 || fun == 6'h12) || opcode == 6'h11 && (fmt == 5'h10 || fmt == 5'h11) && fun == 0)
            regDst[0] <= 1; 
     	  else 
        	regDst[0] <= 0; 


      // memToReg
          // memToReg[1]
          if (opcode == 6'h7 || opcode == 6'h0f)
            memToReg[1] <= 1 ; 
   	      else 
       	    memToReg[1] <= 0 ; 

      // memToReg[0]
      if (opcode == 6'h12 || opcode == 6'h0f || opcode == 6'h3 && fun == 6'h21 || opcode == 6'h31 || opcode == 6'h35)
            memToReg[0] <= 1 ; 
      	  else 
            memToReg[0] <= 0 ; 

      // AluSrc
      
      if (opcode == 6'h3 && (fun == 6'h21 || fun == 6'h13))
        AluSrc[1] <= 1 ; 
      else 
        AluSrc[1] <= 0 ;
      
      if (opcode == 6'h9 || opcode == 6'hc
          || opcode == 6'h12 || opcode == 6'he ||  opcode == 6'h2b || opcode == 6'h28 || opcode == 6'h39 || opcode == 6'h31 || opcode == 6'h35 || opcode == 6'h3d)
        AluSrc[0] <= 1 ; 
      else 
        AluSrc[0] <= 0 ; 

      // regWrite
      if (opcode == 6'h3 && (fun == 6'h24|| fun == 6'h2a || fun == 6'h27  || fun == 6'h25
                             || fun == 6'h14 || fun == 6'h20 || fun == 6'h21 || fun == 6'h2
                             || fun == 6'h0 || fun == 6'h10 || fun == 6'h12 || fun == 6'h3)
         || opcode == 6'h9 || opcode == 6'hc || opcode == 6'h12 || opcode == 6'he 
         || opcode == 6'h7 || opcode == 6'hf)
         regWrite <= 1; 
      else 
        regWrite <= 0; 


      // memRead 

      if (opcode == 6'h12 ||opcode == 6'h3 && fun == 6'h21 || opcode == 6'h31 || opcode == 6'h35 )
         memRead <= 1 ; 
       else 	
		 memRead <= 0 ; 

      // memWrite
      if (opcode == 6'h2b || opcode == 6'h28|| opcode == 6'h3 && fun == 6'h13 || opcode == 6'h39 || opcode == 6'h3d)
         memWrite <= 1 ; 
       else 
		 memWrite <= 0 ; 

      // branch
      if (opcode == 6'h5 || opcode == 6'h4)
        branch <= 1 ; 
	  else 
		branch <= 0 ; 
      
      // jump 
      if (opcode == 6'h2 || opcode == 6'h7)
        jump <= 1 ;
      else 
        jump <= 0 ;

      //pcSrc 
      if (opcode == 6'h3 && fun == 6'h8 || opcode == 6'h2 || opcode == 6'h7)
        pcSrc <= 1; 
      else 
        pcSrc <= 0; 
      
	  // Store Byte
      if (opcode == 6'h28)
        storeByte <= 1 ; 
      else 
        storeByte <= 0 ;
      
      // sign 
      if (opcode == 6'hc || opcode == 6'he)
        sign <= 1 ; 
      else 
        sign <= 0 ;
    
      // bne 
      if (opcode == 6'h4)
        bne <= 1 ; 
      else 
        bne <= 0 ;

      //shift_op
      if (opcode == 6'h3 && (fun == 6'h0 || fun == 6'h2 || fun == 6'h3 || fun == 6'h8 ))
        shift_op <= 1 ; 
      else 
        shift_op <= 0 ;
		
      if (opcode == 6'h3d || opcode == 6'h35 || opcode == 6'h11 && fmt == 5'h11)
        double <= 1 ; 
      else 
        double <= 0 ; 
      
    end

endmodule