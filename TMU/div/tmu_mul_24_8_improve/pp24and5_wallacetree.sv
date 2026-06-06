//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp24and5_wallacetree.sv
//  Creating Date: Tue 02 Jan 2024 01:28:53 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 02 Jan 2024 01:56:40 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module pp24and5_wallacetree(
                              output logic[31:0] o_sum,
                              output logic[31:0] o_carry,
                              //input
                              input logic[27:0] i_a0,                              
                              input logic[28:0] i_b0,
                              input logic[28:0] i_a1,
                              input logic[28:0] i_b1,
                              input logic[26:0] i_a2
);

logic[30:0] w_sum00;
logic[29:0] w_carry00;

mul24and5_wallace_csa_tree00 mul24and5_wallace_csa_tree00(
                                                             .o_sum(w_sum00),
                                                             .o_carry(w_carry00),
                                                             //
                                                             .i_a(i_a0),
                                                             .i_b(i_b0),
                                                             .i_c(i_a1)
);

logic[32:0] w_sum10;
logic[31:0] w_carry10;

mul24and5_wallace_csa_tree10 mul24and5_wallace_csa_tree10(
                                                            .o_sum(w_sum10),
                                                            .o_carry(w_carry10),
                                                            //
                                                            .i_a(w_sum00),
                                                            .i_b(w_carry00),
                                                            .i_c(i_b1)
);

mul24and5_wallace_csa_tree20 mul24and5_wallace_csa_tree20(//output
                                                           .o_sum(o_sum),
                                                           .o_carry(o_carry),
                                                           //input
                                                           .i_a(w_sum10),
                                                           .i_b(w_carry10),
                                                           .i_c(i_a2)
);

endmodule