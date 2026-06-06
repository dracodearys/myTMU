//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree01.sv
//  Creating Date: Wed 27 Dec 2023 02:38:13 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 01:50:19 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree01 (
                                        output logic[40:0] o_sum,
                                        output logic[37:0] o_carry,
                                        //
                                        input logic[36:0] i_a,
                                        input logic[36:0] i_b,
                                        input logic[36:0] i_c
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

csa32bit csa32bit(//output
                      .o_sum(o_sum[36:5]),
                      .o_carry(o_carry[35:4]),
                      //input
                      .i_a(i_a[36:5]),
                      .i_b(i_b[34:3]),
                      .i_c(i_c[32:1])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[37]),
                        .o_cout(o_carry[36]),
                        //input
                        .i_a(i_b[35]),
                        .i_b(i_c[33])
);

halfadder halfadder2(//output
                        .o_sum(o_sum[38]),
                        .o_cout(o_carry[37]),
                        //input

                        .i_a(i_b[36]),
                        .i_b(i_c[34])
);

assign o_sum[40:39] = i_c[36:35];


endmodule