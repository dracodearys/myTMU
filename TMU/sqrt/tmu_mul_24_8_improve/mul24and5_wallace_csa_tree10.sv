//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24and5_wallace_csa_tree10.sv
//  Creating Date: Fri 29 Dec 2023 04:39:49 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 02 Jan 2024 10:55:46 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24and5_wallace_csa_tree10(//output
                                  output logic[32:0] o_sum,
                                  output logic[31:0] o_carry,
                                  //input
                                  input logic[30:0] i_a,
                                  input logic[29:0] i_b,
                                  input logic[28:0] i_c
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

csa24bit csa24bit(//output
                  .o_sum(o_sum[28:5]),
                  .o_carry(o_carry[29:6]),
                  //input
                  .i_a(i_a[28:5]),
                  .i_b(i_b[28:5]),
                  .i_c(i_c[24:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[29]),
                      .o_carry(o_carry[30]),
                      //input
                      .i_a(i_a[29]),
                      .i_b(i_b[29]),
                      .i_c(i_c[25])
);

halfadder halfadder1(//ouput
                      .o_sum(o_sum[30]),
                      .o_cout(o_carry[31]),
                      //input
                      .i_a(i_a[30]),
                      .i_b(i_c[26])
);

assign o_sum[32:31] = i_c[28:27];



endmodule