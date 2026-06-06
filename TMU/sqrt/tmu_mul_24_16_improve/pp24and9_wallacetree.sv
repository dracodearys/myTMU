//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp24and9_wallacetree.sv
//  Creating Date: Wed 03 Jan 2024 02:13:25 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 09:04:23 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module pp24and9_wallacetree (
                            output logic[39:0]o_sum,
                            output logic[39:0]o_carry,
                            //
                            input logic[27:0] i_a0,
                            input logic[28:0] i_b0,
                            input logic[28:0] i_a1,
                            input logic[28:0] i_b1,
                            input logic[28:0] i_a2,
                            input logic[28:0] i_b2,
                            input logic[28:0] i_a3,
                            input logic[28:0] i_b3,
                            input logic[26:0] i_a4
);

logic[30:0] w_sum00;
logic[29:0] w_carry00;

logic[32:0] w_sum01;
logic[29:0] w_carry01;

logic[30:0] w_sum02;
logic[29:0] w_carry02;

mul24and9_wallace_csa_tree00 mul24and9_wallace_csa_tree00(//output
                                                          .o_sum(w_sum00),
                                                          .o_carry(w_carry00),
                                                          //input
                                                          .i_a(i_a0),
                                                          .i_b(i_b0),
                                                          .i_c(i_a1)
);

mul24and9_wallace_csa_tree01 mul24and9_wallace_csa_tree01(//output
                                                          .o_sum(w_sum01),
                                                          .o_carry(w_carry01),
                                                          //input
                                                          .i_a(i_b1),
                                                          .i_b(i_a2),
                                                          .i_c(i_b2)
);

mul24and9_wallace_csa_tree02 mul24and9_wallace_csa_tree02(//output
                                                          .o_sum(w_sum02),
                                                          .o_carry(w_carry02),
                                                          //input
                                                          .i_a(i_a3),
                                                          .i_b(i_b3),
                                                          .i_c(i_a4)
);

logic[36:0] w_sum10;
logic[31:0] w_carry10;

logic[35:0] w_sum11;
logic[31:0] w_carry11;

mul24and9_wallace_csa_tree10 mul24and9_wallace_csa_tree10(//output
                                                          .o_sum(w_sum10),
                                                          .o_carry(w_carry10),
                                                          //input
                                                          .i_a(w_sum00),
                                                          .i_b(w_carry00),
                                                          .i_c(w_sum01)
);

mul24and9_wallace_csa_tree11 mul24and9_wallace_csa_tree11(//output
                                                          .o_sum(w_sum11),
                                                          .o_carry(w_carry11),
                                                          //input
                                                          .i_a(w_carry01),
                                                          .i_b(w_sum02),
                                                          .i_c(w_carry02)
);

logic[41:0] w_sum20;
logic[37:0] w_carry20;

mul24and9_wallace_csa_tree20 mul24and9_wallace_csa_tree20(//output
                                                           .o_sum(w_sum20),
                                                           .o_carry(w_carry20),
                                                           //input
                                                           .i_a(w_sum10),
                                                           .i_b(w_carry10),
                                                           .i_c(w_sum11)
);


mul24and9_wallace_csa_tree30 mul24and9_wallace_csa_tree30(//output
                                                            .o_sum(o_sum),
                                                            .o_carry(o_carry),
                                                            //input
                                                            .i_a(w_sum20),
                                                            .i_b(w_carry20),
                                                            .i_c(w_carry11)                                                
);


endmodule