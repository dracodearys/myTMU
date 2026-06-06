//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree13.sv
//  Creating Date: Wed 27 Dec 2023 02:39:47 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 02:31:07 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree13 (//output
                                    output wire [40:0] o_sum,
                                    output wire [36:0] o_carry, //special
                                    //input
                                    input [37:0] i_a,
                                    input [36:0] i_b,
                                    input [34:0] i_c
);

assign o_sum[6:0] = i_a[6:0];
assign o_carry[1:0] = i_b[1:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[2]),
                        .o_cout(o_carry[3]),
                        //input

                        .i_a(i_b[2]),
                        .i_b(i_c[0])
);


csa28bit csa28bit(//output
                      .o_sum(o_sum[34:7]),
                      .o_carry(o_carry[31:4]),
                      //input
                      .i_a(i_a[34:7]),
                      .i_b(i_b[30:3]),
                      .i_c(i_c[28:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[35]),
                      .o_carry(o_carry[32]),
                      //input
                      .i_a(i_a[35]),
                      .i_b(i_b[31]),
                      .i_c(i_c[29])
);

fulladder fulladder1(//output
                      .o_sum(o_sum[36]),
                      .o_carry(o_carry[33]),
                      //input
                      .i_a(i_a[36]),
                      .i_b(i_b[32]),
                      .i_c(i_c[30])
);

fulladder fulladder2(//output
                      .o_sum(o_sum[37]),
                      .o_carry(o_carry[34]),
                      //input
                      .i_a(i_a[37]),
                      .i_b(i_b[33]),
                      .i_c(i_c[31])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[38]),
                        .o_cout(o_carry[35]),
                        //input

                        .i_a(i_b[34]),
                        .i_b(i_c[32])
);

halfadder halfadder2(//output
                        .o_sum(o_sum[39]),
                        .o_cout(o_carry[36]),
                        //input

                        .i_a(i_b[35]),
                        .i_b(i_c[33])
);

//halfadder halfadder1(//output
//                        .o_sum(o_sum[40]),
//                        .o_cout(o_carry[37]),
//                        //input
//
//                        .i_a(i_b[36]),
//                        .i_b(i_c[34])     //this i_c[34] value is fix 0 value 
//);

assign o_sum[40] = i_b[36];

endmodule