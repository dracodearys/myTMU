//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24and9_wallace_csa_tree02.sv
//  Creating Date: Wed 03 Jan 2024 03:37:36 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 09:09:55 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24and9_wallace_csa_tree02(//output
                                      output logic[30:0] o_sum,
                                      output logic[29:0] o_carry,
                                      //
                                      input logic[28:0] i_a,
                                      input logic[28:0] i_b,
                                      input logic[26:0] i_c
);

assign o_sum[4:0] = i_a[4:0];
assign o_carry[1:0] = i_b[1:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[2]),
                        .o_cout(o_carry[3]),
                        //input
                        .i_a(i_b[2]),
                        .i_b(i_c[0])
);

csa24bit csa24bit(//output
                      .o_sum(o_sum[28:5]),
                      .o_carry(o_carry[27:4]),
                      //input
                      .i_a(i_a[28:5]),
                      .i_b(i_b[26:3]),
                      .i_c(i_c[24:1])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[29]),
                        .o_cout(o_carry[28]),
                        //input
                        .i_a(i_b[27]),
                        .i_b(i_c[25])
);

halfadder halfadder2(//output
                        .o_sum(o_sum[30]),
                        .o_cout(o_carry[29]),
                        //input
                        .i_a(i_b[28]),
                        .i_b(i_c[26])
);

endmodule
