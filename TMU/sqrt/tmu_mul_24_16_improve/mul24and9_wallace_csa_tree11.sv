//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24and9_wallace_csa_tree11.sv
//  Creating Date: Wed 03 Jan 2024 04:19:48 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 03 Jan 2024 06:42:11 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24and9_wallace_csa_tree11(//output
                                      output logic[35:0] o_sum,
                                      output logic[31:0] o_carry,
                                      //
                                      input logic[29:0] i_a,
                                      input logic[30:0] i_b,
                                      input logic[29:0] i_c
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

csa20bit csa20bit(//output
                   .o_sum(o_sum[26:7]),
                   .o_carry(o_carry[23:4]),
                   //input
                   .i_a(i_a[26:7]),
                   .i_b(i_b[22:3]),
                   .i_c(i_c[20:1])
);

fulladder fulladder0(//output
                      .o_sum(o_sum[27]),
                      .o_carry(o_carry[24]),
                      //input
                      .i_a(i_a[27]),
                      .i_b(i_b[23]),
                      .i_c(i_c[21])
);

fulladder fulladder1(//output
                      .o_sum(o_sum[28]),
                      .o_carry(o_carry[25]),
                      //input
                      .i_a(i_a[28]),
                      .i_b(i_b[24]),
                      .i_c(i_c[22])
);

fulladder fulladder2(//output
                      .o_sum(o_sum[29]),
                      .o_carry(o_carry[26]),
                      //input
                      .i_a(i_a[29]),
                      .i_b(i_b[25]),
                      .i_c(i_c[23])  
);

halfadder halfadder1(//output
                      .o_sum(o_sum[30]),
                      .o_cout(o_carry[27]),
                      //input
                      .i_a(i_b[26]),
                      .i_b(i_c[24])
);

halfadder halfadder2(//output
                      .o_sum(o_sum[31]),
                      .o_cout(o_carry[28]),
                      //input
                      .i_a(i_b[27]),
                      .i_b(i_c[25])
);

halfadder halfadder3(//output
                      .o_sum(o_sum[32]),
                      .o_cout(o_carry[29]),
                      //input
                      .i_a(i_b[28]),
                      .i_b(i_c[26])
);

halfadder halfadder4(//output
                      .o_sum(o_sum[33]),
                      .o_cout(o_carry[30]),
                      //input
                      .i_a(i_b[29]),
                      .i_b(i_c[27])
);

halfadder halfadder5(//output
                      .o_sum(o_sum[34]),
                      .o_cout(o_carry[31]),
                      //input
                      .i_a(i_b[30]),
                      .i_b(i_c[28])
);

assign o_sum[35] = i_c[29];

endmodule