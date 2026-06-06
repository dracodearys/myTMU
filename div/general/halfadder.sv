//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: halfadder.sv
//  Creating Date: Wed 27 Dec 2023 03:35:04 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Dec 2023 03:55:40 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module halfadder(
          input logic i_a,
          input logic i_b,
          output logic o_sum,
          output logic o_cout
);

assign o_sum =i_a^i_b;
assign o_cout =i_a & i_b;

endmodule