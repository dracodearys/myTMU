//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24and5_wallace_csa_tree20.sv
//  Creating Date: Fri 29 Dec 2023 05:24:28 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 02 Jan 2024 01:57:50 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24and5_wallace_csa_tree20(//output
                                    output logic[31:0] o_sum,
                                    output logic[31:0] o_carry,
                                    //input
                                    input logic[32:0] i_a,
                                    input logic[31:0] i_b,
                                    input logic[26:0] i_c
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
                        .o_carry(),
                        //input
                        .i_a(i_a[31]),
                        .i_b(i_b[31]),
                        .i_c(i_c[25])
);

endmodule