//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree21.sv
//  Creating Date: Wed 27 Dec 2023 02:40:25 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 02:45:17 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree21 (//output
                                        output logic[52:0] o_sum,
                                        output logic[42:0] o_carry,
                                        //input
                                        input logic[40:0] i_a,
                                        input logic[46:0] i_b,
                                        input logic[39:0] i_c
);

assign o_sum[8:0] = i_a[8:0];
assign o_carry[1:0] = i_b[1:0];

halfadder halfadder0(//output
                        .o_sum(o_carry[2]),
                        .o_cout(o_carry[3]),
                        //input

                        .i_a(i_b[2]),
                        .i_b(i_c[0])                      
);

csa32bit csa32bit(//output
                      .o_sum(o_sum[40:9]),
                      .o_carry(o_carry[35:4]),
                      //input
                      .i_a(i_a[40:9]),
                      .i_b(i_b[34:3]),
                      .i_c(i_c[32:1])
);

halfadder halfadder1(//output
                        .o_sum(o_sum[41]),
                        .o_cout(o_carry[36]),
                        //input

                        .i_a(i_b[35]),
                        .i_b(i_c[33])
);

halfadder halfadder2(//output
                        .o_sum(o_sum[42]),
                        .o_cout(o_carry[37]),
                        //input

                        .i_a(i_b[36]),
                        .i_b(i_c[34])
);

halfadder halfadder3(//output
                        .o_sum(o_sum[43]),
                        .o_cout(o_carry[38]),
                        //input

                        .i_a(i_b[37]),
                        .i_b(i_c[35])
);

halfadder halfadder4(//output
                        .o_sum(o_sum[44]),
                        .o_cout(o_carry[39]),
                        //input

                        .i_a(i_b[38]),
                        .i_b(i_c[36])
);

halfadder halfadder5(//output
                        .o_sum(o_sum[45]),
                        .o_cout(o_carry[40]),
                        //input

                        .i_a(i_b[39]),
                        .i_b(i_c[37])
);

halfadder halfadder6(//output
                        .o_sum(o_sum[46]),
                        .o_cout(o_carry[41]),
                        //input

                        .i_a(i_b[40]),
                        .i_b(i_c[38])
);

halfadder halfadder7(//output
                        .o_sum(o_sum[47]),
                        .o_cout(o_carry[42]),
                        //input

                        .i_a(i_b[41]),
                        .i_b(i_c[39])
);

assign o_sum[52:48] = i_b[46:42];  

endmodule