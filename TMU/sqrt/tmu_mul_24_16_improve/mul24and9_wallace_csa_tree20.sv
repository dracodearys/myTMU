//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24and9_wallace_csa_tree20.sv
//  Creating Date: Wed 03 Jan 2024 05:04:27 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 08:46:06 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24and9_wallace_csa_tree20(//ouput
                                      output logic[41:0] o_sum,
                                      output logic[37:0] o_carry,
                                      //
                                      input logic[36:0] i_a,
                                      input logic[31:0] i_b,
                                      input logic[35:0] i_c
);

assign o_sum[6:0] = i_a[6:0];
assign o_carry[5:0] = i_b[5:0];

halfadder halfadder0(//output
                     .o_sum(o_carry[6]),
                     .o_cout(o_carry[7]),
                     //input
                     .i_a(i_b[6]),
                     .i_b(i_c[0])
);

csa24bit csa24bit(//output
                   .o_sum(o_sum[30:7]),
                   .o_carry(o_carry[31:8]),
                   //input
                   .i_a(i_a[30:7]),
                   .i_b(i_b[30:7]),
                   .i_c(i_c[24:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[31]),
                      .o_carry(o_carry[32]),
                      //input
                      .i_a(i_a[31]),
                      .i_b(i_b[31]),
                      .i_c(i_c[25])
);

halfadder halfadder1(//output
                      .o_sum(o_sum[32]),
                      .o_cout(o_carry[33]),
                      //input
                      .i_a(i_a[32]),
                      .i_b(i_c[26])                 
);

halfadder halfadder2(//output
                      .o_sum(o_sum[33]),
                      .o_cout(o_carry[34]),
                      //input
                      .i_a(i_a[33]),
                      .i_b(i_c[27])
);

halfadder halfadder3(//output
                      .o_sum(o_sum[34]),
                      .o_cout(o_carry[35]),
                      //input
                      .i_a(i_a[34]),
                      .i_b(i_c[28])
);

halfadder halfadder4(//output
                      .o_sum(o_sum[35]),
                      .o_cout(o_carry[36]),
                      //input
                      .i_a(i_a[35]),
                      .i_b(i_c[29])
);

halfadder halfadder5(//output
                      .o_sum(o_sum[36]),
                      .o_cout(o_carry[37]),
                      //input
                      .i_a(i_a[36]),
                      .i_b(i_c[30])
);

assign o_sum[41:37] = i_c[35:31];


endmodule