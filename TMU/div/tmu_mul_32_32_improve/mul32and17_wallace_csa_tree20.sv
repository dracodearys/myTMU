//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree20.sv
//  Creating Date: Wed 27 Dec 2023 02:40:02 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 02:38:43 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree20 (//output
                                    output logic[50:0] o_sum,
                                    output logic[45:0] o_carry,
                                    //input
                                    input logic[44:0] i_a,
                                    input logic[39:0] i_b,
                                    input logic[44:0] i_c                
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

csa32bit csa32bit(//output
                      .o_sum(o_sum[38:7]),
                      .o_carry(o_carry[39:8]),
                      //input
                      .i_a(i_a[38:7]),
                      .i_b(i_b[38:7]),
                      .i_c(i_c[32:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[39]),
                      .o_carry(o_carry[40]),
                      //input
                      .i_a(i_a[39]),
                      .i_b(i_b[39]),
                      .i_c(i_c[33])
);

halfadder halfadder1(//output
                    .o_sum(o_sum[40]),
                    .o_cout(o_carry[41]),
                    //input
                    .i_a(i_a[40]),
                    .i_b(i_c[34])
);

halfadder halfadder2(//output
                    .o_sum(o_sum[41]),
                    .o_cout(o_carry[42]),
                    //input
                    .i_a(i_a[41]),
                    .i_b(i_c[35])
);

halfadder halfadder3(//output
                    .o_sum(o_sum[42]),
                    .o_cout(o_carry[43]),
                    //input
                    .i_a(i_a[42]),
                    .i_b(i_c[36])
);

halfadder halfadder4(//output
                    .o_sum(o_sum[43]),
                    .o_cout(o_carry[44]),
                    //input
                    .i_a(i_a[43]),
                    .i_b(i_c[37])
);
    
halfadder halfadder5(//output
                    .o_sum(o_sum[44]),
                    .o_cout(o_carry[45]),
                    //input
                    .i_a(i_a[44]),
                    .i_b(i_c[38])
);

assign o_sum[50:45] = i_c[44:39];


endmodule