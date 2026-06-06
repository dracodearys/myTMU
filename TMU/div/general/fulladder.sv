//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: fulladder.sv
//  Creating Date: Wed 27 Dec 2023 03:36:03 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Dec 2023 03:55:23 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module fulladder(
        input logic i_a,
        input logic i_b,
        input logic i_c,
        output logic o_sum,
        output logic o_carry
);

assign o_sum =i_a^i_b^i_c;
assign o_carry = (i_a & i_b) | ((i_a ^ i_b) & i_c);

endmodule