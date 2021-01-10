module ForwardingUnit(ForwardA, ForwardB, EX_MEM_Rd, MEM_WB_Rd, ID_EX_Rs, ID_EX_Rt, EX_MEM_RegWrite, MEM_WB_RegWrite, memwrite);
  
  input [4:0] EX_MEM_Rd, MEM_WB_Rd, ID_EX_Rs, ID_EX_Rt;
  input EX_MEM_RegWrite, MEM_WB_RegWrite, memwrite;
  
  output [1:0]ForwardA, ForwardB;
  
  reg [1:0] ForwardA, ForwardB;
 
  
  always @ (*)
    begin
      ForwardA = 0;
      ForwardB = 0;
     
      
     
      if(EX_MEM_RegWrite==1 && EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rs )
			ForwardA = 2;

		if(EX_MEM_RegWrite==1 && EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rt)
			ForwardB = 2;

		if(MEM_WB_RegWrite==1 && MEM_WB_Rd != 0 && 
			!(EX_MEM_RegWrite==1 && EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rs) && 
			MEM_WB_Rd == ID_EX_Rs)
			    ForwardA = 1;

		if(MEM_WB_RegWrite==1 && MEM_WB_Rd != 0 && 
			!(EX_MEM_RegWrite==1 && EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rt) && 
			MEM_WB_Rd == ID_EX_Rt)
			    ForwardB = 1;
      
      //if( memwrite == 1 && ForwardB == 1)
      //  begin
//			ForwardA = 1;
  //      	ForwardB = 0 ; 
    //    end
 
    end


endmodule 