//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24and9_wallace_csa_tree30.sv
//  Creating Date: Wed 03 Jan 2024 06:15:08 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 08:47:34 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24and9_wallace_csa_tree30(//output
                                      output logic[39:0] o_sum,
                                      output logic[39:0] o_carry,
                                      //
                                      input logic[41:0] i_a,
                                      input logic[37:0] i_b,
                                      input logic[31:0] i_c
);

assign o_sum[10:0] = i_a[10:0]; 
assign o_carry[9:0] = i_b[9:0];

halfadder halfadder0(//output
                      .o_sum(o_carry[10]),
                      .o_cout(o_carry[11]),
                      //
                      .i_a(i_b[10]),
                      .i_b(i_c[0])
);

csa24bit csa24bit(//output
                    .o_sum(o_sum[34:11]),
                    .o_carry(o_carry[35:12]),
                    //
                    .i_a(i_a[34:11]),
                    .i_b(i_b[34:11]),
                    .i_c(i_c[24:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[35]),
                      .o_carry(o_carry[36]),
                      //
                      .i_a(i_a[35]),
                      .i_b(i_b[35]),
                      .i_c(i_c[25])
);

fulladder fulladder1(//output
                      .o_sum(o_sum[36]),
                      .o_carry(o_carry[37]),
                      //
                      .i_a(i_a[36]),
                      .i_b(i_b[36]),
                      .i_c(i_c[26])
);

fulladder fulladder2(//output
                      .o_sum(o_sum[37]),
                      .o_carry(o_carry[38]),
                      //
                      .i_a(i_a[37]),
                      .i_b(i_b[37]),
                      .i_c(i_c[27])
);

halfadder halfadder1(//output
                      .o_sum(o_sum[38]),
                      .o_cout(o_carry[39]),
                      //
                      .i_a(i_a[38]),
                      .i_b(i_c[28])
);

halfadder halfadder2(//output
                      .o_sum(o_sum[39]),
                      .o_cout(),
                      //
                      .i_a(i_a[39]),
                      .i_b(i_c[29])
);

//halfadder halfadder3(//output
//                      .o_sum(),
//                      .o_cout(),
//                      //
//                      .i_a(),
//                      .i_b(),
//);
//
//halfadder halfadder4(//output
//                      .o_sum(),
//                      .o_cout(),
//                      //
//                      .i_a(),
//                      .i_b(),
//);

endmodule