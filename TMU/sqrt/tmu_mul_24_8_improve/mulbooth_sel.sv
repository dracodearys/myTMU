//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mulbooth_sel.sv
//  Creating Date: Fri 29 Dec 2023 03:33:21 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Fri 29 Dec 2023 03:49:22 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mulbooth_sel  (//output 
                      output wire o_ppij,
                      //input 
                      input i_sign,
                      input i_sel_m,
                      input i_sel_2m,
                      input i_yj,
                      input i_yi_l
                      );
  assign o_ppij = ~((i_yj & i_sel_m) | (i_yi_l & i_sel_2m)) ^~ i_sign; //the expression ture is (2m&&lb || m&&cb && ~sign) and ~(2m&&lb || m&&cb) && sign

endmodule