//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree31.sv
//  Creating Date: Wed 27 Dec 2023 02:41:12 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 03:01:24 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree31 (//output
                                    output logic[48:0] o_sum,
                                    output logic[41:0] o_carry,
                                    //input
                                    input logic[42:0] i_a,
                                    input logic[40:0] i_b,
                                    input logic[36:0] i_c                
);

assign o_sum[12:0] = i_a[12:0];
assign o_carry[3:0] = i_b[3:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[4]),
                        .o_cout(o_carry[5]),
                        //input

                        .i_a(i_b[4]),
                        .i_b(i_c[0])
);

csa28bit csa28bit(//output
                  .o_sum(o_sum[40:13]),
                  .o_carry(o_carry[33:6]),
                  //input
                  .i_a(i_a[40:13]),
                  .i_b(i_b[32:5]),
                  .i_c(i_c[28:1])
);

fulladder fulladder0(//output
                  .o_sum(o_sum[41]),
                  .o_carry(o_carry[34]),
                  //input
                  .i_a(i_a[41]),
                  .i_b(i_b[33]),
                  .i_c(i_c[29])
);

fulladder fulladder1(//output
                  .o_sum(o_sum[42]),
                  .o_carry(o_carry[35]),
                  //input
                  .i_a(i_a[42]),
                  .i_b(i_b[34]),
                  .i_c(i_c[30])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[43]),
                        .o_cout(o_carry[36]),
                        //input
                        .i_a(i_b[35]),
                        .i_b(i_c[31])
);

halfadder halfadder2(//output
                        .o_sum(o_sum[44]),
                        .o_cout(o_carry[37]),
                        //input
                        .i_a(i_b[36]),
                        .i_b(i_c[32])
);

halfadder halfadder3(//output
                        .o_sum(o_sum[45]),
                        .o_cout(o_carry[38]),
                        //input
                        .i_a(i_b[37]),
                        .i_b(i_c[33])
);

halfadder halfadder4(//output
                        .o_sum(o_sum[46]),
                        .o_cout(o_carry[39]),
                        //input
                        .i_a(i_b[38]),
                        .i_b(i_c[34])
);

halfadder halfadder5(//output
                        .o_sum(o_sum[47]),
                        .o_cout(o_carry[40]),
                        //input
                        .i_a(i_b[39]),
                        .i_b(i_c[35])

);

halfadder halfadder6(//output
                        .o_sum(o_sum[48]),
                        .o_cout(o_carry[41]),
                        //input
                        .i_a(i_b[40]),
                        .i_b(i_c[36])
);

endmodule