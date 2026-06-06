//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mulbooth_code.sv
//  Creating Date: Wed 27 Dec 2023 03:26:20 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Dec 2023 03:26:36 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mulbooth_code (//output 
                      output wire o_sign,  //+ /-
                      output wire o_sel_m,  //b
                      output wire o_sel_2m,  //2b
                      //input 
                      input i_x2i_l,  //lsb
                      input i_x2i,
                      input i_x2i_m  //msb
                       );
  assign o_sign = i_x2i_m;  //when i_x2i_m i_x2i i_x2i_l == 111 ,sign = 1
  assign o_sel_m = i_x2i ^ i_x2i_l;
  assign o_sel_2m = (i_x2i & i_x2i_l & ~i_x2i_m) | (~i_x2i & ~i_x2i_l & i_x2i_m);
endmodule