//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree10.sv
//  Creating Date: Wed 27 Dec 2023 02:38:37 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 01:55:00 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree10 (//output
                                    output wire [44:0] o_sum,
                                    output wire [39:0] o_carry,
                                    //input
                                    input [38:0] i_a,
                                    input [37:0] i_b,
                                    input [40:0] i_c
);

assign o_sum[4:0] = i_a[4:0];
assign o_carry[3:0] = i_b[3:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[4]),
                        .o_cout(o_carry[5]),
                        //input

                        .i_a(i_b[4]),
                        .i_b(i_c[0]) 
);

csa32bit csa32bit(//output
                      .o_sum(o_sum[36:5]),
                      .o_carry(o_carry[37:6]),
                      //input
                      .i_a(i_a[36:5]),
                      .i_b(i_b[36:5]),
                      .i_c(i_c[32:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[37]),
                      .o_carry(o_carry[38]),
                      //input
                      .i_a(i_a[37]),
                      .i_b(i_b[37]),
                      .i_c(i_c[33])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[38]),
                        .o_cout(o_carry[39]),
                        //input

                        .i_a(i_a[38]),
                        .i_b(i_c[34])
);

assign o_sum[44:39] = i_c[40:35];


endmodule