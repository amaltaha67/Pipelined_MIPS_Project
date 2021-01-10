module HzardDetection (PC_enable, flush_IF_ID, flush_ID_EXE, pcsrc, and_br_eq, Rs_D, Rt_D, Rt_X, memread_X );
	input pcsrc, and_br_eq, memread_X; 
    input [4:0] Rs_D, Rt_D, Rt_X;
  	output flush_IF_ID, flush_ID_EXE, PC_enable;
    reg flush_IF_ID, flush_ID_EXE, PC_enable;
  
  always @ (*) begin
    flush_IF_ID = 0 ; 
    flush_ID_EXE = 0; 
    PC_enable = 1; 
    
    if (memread_X == 1 && (Rs_D == Rt_X || Rt_D == Rt_X))
      begin 
      	 flush_IF_ID = 1 ;
         PC_enable = 0 ; 
      end
    
    if ( and_br_eq == 1) 
      begin 
      	 flush_IF_ID = 1 ; 
    	 flush_ID_EXE = 1; 
      end
  
    if (pcsrc == 1 ) 
      	 flush_IF_ID = 1 ;   
    
    
  end
endmodule