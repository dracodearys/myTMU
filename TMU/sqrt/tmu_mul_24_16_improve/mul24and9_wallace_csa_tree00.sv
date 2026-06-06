//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24and9_wallace_csa_tree00.sv
//  Creating Date: Wed 03 Jan 2024 03:08:30 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 09:32:34 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24and9_wallace_csa_tree00(//output
                                      output logic[30:0] o_sum,
                                      output logic[29:0] o_carry,
                                      //
                                      input logic[27:0] i_a,
                                      input logic[28:0] i_b,
                                      input logic[28:0] i_c
);

assign o_sum[2:0] = i_a[2:0];
assign o_carry[1:0] = i_b[1:0];

halfadder halfadder0(//output
                      .o_sum(o_carry[2]),
                      .o_cout(o_carry[3]),
                      //input
                      .i_a(i_b[2]),
                      .i_b(i_c[0])
);

csa24bit csa24bit(//output
                    .o_sum(o_sum[26:3]),
                    .o_carry(o_carry[27:4]),
                    //input
                    .i_a(i_a[26:3]),
                    .i_b(i_b[26:3]),
                    .i_c(i_c[24:1])  
);

fulladder fulladder0(//output
                      .o_sum(o_sum[27]),
                      .o_carry(o_carry[28]),
                      //input 
                      .i_a(i_a[27]),
                      .i_b(i_b[27]),
                      .i_c(i_c[25])
);



halfadder halfadder1(//output
                      .o_sum(o_sum[28]),
                      .o_cout(o_carry[29]),
                      //input
                      .i_a(i_b[28]),
                      .i_b(i_c[26])
);

assign o_sum[30:29] = i_c[28:27];

endmodule