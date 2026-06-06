//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree30.sv
//  Creating Date: Wed 27 Dec 2023 02:40:50 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 02:57:26 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree30 (//output
                                    output logic[62:0] o_sum,
                                    output logic[51:0] o_carry,
                                    //input
                                    input logic[50:0] i_a,
                                    input logic[45:0] i_b,
                                    input logic[52:0] i_c                
);

assign o_sum[10:0] = i_a[10:0];
assign o_carry[9:0] = i_b[9:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[10]),
                        .o_cout(o_carry[11]),
                        //input
                        .i_a(i_b[10]),
                        .i_b(i_c[0])
);

csa32bit csa32bit(//output
                  .o_sum(o_sum[42:11]),
                  .o_carry(o_carry[43:12]),
                  //input
                  .i_a(i_a[42:11]),
                  .i_b(i_b[42:11]),
                  .i_c(i_c[32:1])
);

fulladder fulladder0(//output
                  .o_sum(o_sum[43]),
                  .o_carry(o_carry[44]),
                  //input
                  .i_a(i_a[43]),
                  .i_b(i_b[43]),
                  .i_c(i_c[33])
);

fulladder fulladder1(//output
                  .o_sum(o_sum[44]),
                  .o_carry(o_carry[45]),
                  //input
                  .i_a(i_a[44]),
                  .i_b(i_b[44]),
                  .i_c(i_c[34])
);

fulladder fulladder2(//output
                  .o_sum(o_sum[45]),
                  .o_carry(o_carry[46]),
                  //input
                  .i_a(i_a[45]),
                  .i_b(i_b[45]),
                  .i_c(i_c[35])
);

halfadder halfadder1(//output
                     .o_sum(o_sum[46]),
                     .o_cout(o_carry[47]),
                     //input
                     .i_a(i_a[46]),
                     .i_b(i_c[36])
);

halfadder halfadder2(//output
                     .o_sum(o_sum[47]),
                     .o_cout(o_carry[48]),
                     //input
                     .i_a(i_a[47]),
                     .i_b(i_c[37])
);

halfadder halfadder3(//output
                     .o_sum(o_sum[48]),
                     .o_cout(o_carry[49]),
                     //input
                     .i_a(i_a[48]),
                     .i_b(i_c[38])
);

halfadder halfadder4(//output
                     .o_sum(o_sum[49]),
                     .o_cout(o_carry[50]),
                     //input
                     .i_a(i_a[49]),
                     .i_b(i_c[39])
);

halfadder halfadder5(//output
                     .o_sum(o_sum[50]),
                     .o_cout(o_carry[51]),
                     //input
                     .i_a(i_a[50]),
                     .i_b(i_c[40])
);

assign o_sum[62:51] = i_c[52:41];

endmodule