//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree50.sv
//  Creating Date: Wed 27 Dec 2023 02:41:56 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 05:15:12 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree50 (//output
                                        output logic[65:0] o_sum,
                                        output logic[65:0] o_carry,
                                        //input
                                        input logic[64:0] i_a,
                                        input logic[63:0] i_b,
                                        input logic[41:0] i_c  
 );

assign o_sum[24:0] = i_a[24:0];
assign o_carry[23:0] = i_b[23:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[24]),
                        .o_cout(o_carry[25]),
                        //input
                        .i_a(i_b[24]),
                        .i_b(i_c[0])         
);

csa36bit csa36bit(//output
                      .o_sum(o_sum[60:25]),
                      .o_carry(o_carry[61:26]),
                      //input
                      .i_a(i_a[60:25]),
                      .i_b(i_b[60:25]),
                      .i_c(i_c[36:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[61]),
                      .o_carry(o_carry[62]),
                      //input
                      .i_a(i_a[61]),
                      .i_b(i_b[61]),
                      .i_c(i_c[37])
);

fulladder fulladder1(//output
                      .o_sum(o_sum[62]),
                      .o_carry(o_carry[63]),
                      //input
                      .i_a(i_a[62]),
                      .i_b(i_b[62]),
                      .i_c(i_c[38])
);

fulladder fulladder2(//output
                      .o_sum(o_sum[63]),
                      .o_carry(o_carry[64]),
                      //input
                      .i_a(i_a[63]),
                      .i_b(i_b[63]),
                      .i_c(i_c[39])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[64]),
                        .o_cout(o_carry[65]),
                        //input
                        .i_a(i_a[64]),
                        .i_b(i_c[40])

);

assign o_sum[65] = i_c[41];

endmodule//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree50.sv
//  Creating Date: Wed 27 Dec 2023 02:41:56 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 05:15:12 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree50 (//output
                                        output logic[65:0] o_sum,
                                        output logic[65:0] o_carry,
                                        //input
                                        input logic[64:0] i_a,
                                        input logic[63:0] i_b,
                                        input logic[41:0] i_c  
 );

assign o_sum[24:0] = i_a[24:0];
assign o_carry[23:0] = i_b[23:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[24]),
                        .o_cout(o_carry[25]),
                        //input
                        .i_a(i_b[24]),
                        .i_b(i_c[0])         
);

csa36bit csa36bit(//output
                      .o_sum(o_sum[60:25]),
                      .o_carry(o_carry[61:26]),
                      //input
                      .i_a(i_a[60:25]),
                      .i_b(i_b[60:25]),
                      .i_c(i_c[36:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[61]),
                      .o_carry(o_carry[62]),
                      //input
                      .i_a(i_a[61]),
                      .i_b(i_b[61]),
                      .i_c(i_c[37])
);

fulladder fulladder1(//output
                      .o_sum(o_sum[62]),
                      .o_carry(o_carry[63]),
                      //input
                      .i_a(i_a[62]),
                      .i_b(i_b[62]),
                      .i_c(i_c[38])
);

fulladder fulladder2(//output
                      .o_sum(o_sum[63]),
                      .o_carry(o_carry[64]),
                      //input
                      .i_a(i_a[63]),
                      .i_b(i_b[63]),
                      .i_c(i_c[39])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[64]),
                        .o_cout(o_carry[65]),
                        //input
                        .i_a(i_a[64]),
                        .i_b(i_c[40])

);

assign o_sum[65] = i_c[41];

endmodule