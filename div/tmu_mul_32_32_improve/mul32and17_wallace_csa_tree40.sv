//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallace_csa_tree40.sv
//  Creating Date: Wed 27 Dec 2023 02:41:36 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 28 Dec 2023 03:24:10 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32and17_wallace_csa_tree40 (//output
                                    output logic[64:0] o_sum,
                                    output logic[63:0] o_carry,
                                    //input
                                    input logic[62:0] i_a,
                                    input logic[51:0] i_b,
                                    input logic[48:0] i_c                
);

assign o_sum[16:0] = i_a[16:0];
assign o_carry[15:0] = i_b[15:0]; 

halfadder halfadder0(//output
                        .o_sum(o_carry[16]),
                        .o_cout(o_carry[17]),
                        //input

                        .i_a(i_b[16]),
                        .i_b(i_c[0]) 
);

csa32bit csa32bit(//output
                    .o_sum(o_sum[48:17]),
                    .o_carry(o_carry[49:18]),
                    //input
                    .i_a(i_a[48:17]),
                    .i_b(i_b[48:17]),
                    .i_c(i_c[32:1])
);

fulladder fulladder0(//output
                        .o_sum(o_sum[49]),   
                        .o_carry(o_carry[50]),
                        //input
                        .i_a(i_a[49]),
                        .i_b(i_b[49]),
                        .i_c(i_c[33])
);

fulladder fulladder1(//output
                        .o_sum(o_sum[50]),   
                        .o_carry(o_carry[51]),
                        //input
                        .i_a(i_a[50]),
                        .i_b(i_b[50]),
                        .i_c(i_c[34])
);

fulladder fulladder2(//output
                        .o_sum(o_sum[51]),   
                        .o_carry(o_carry[52]),
                        //input
                        .i_a(i_a[51]),
                        .i_b(i_b[51]),
                        .i_c(i_c[35])
);

//genvar i;
//generate
//    for(i=1;i<12;i++)begin :label
//        halfadder halfadder1(//output
//                        .o_sum(o_sum[51+i]),
//                        .o_cout(o_carry[52+i]),
//                        //input
//                        .i_a(i_a[51+i]),
//                        .i_b(i_c[35+i]) 
//        );
//    end
//endgenerate

halfadder halfadder1(//output
                        .o_sum(o_sum[52]),
                        .o_cout(o_carry[53]),
                        //input

                        .i_a(i_a[52]),
                        .i_b(i_c[36]) 
);

halfadder halfadder2(//output
                        .o_sum(o_sum[53]),
                        .o_cout(o_carry[54]),
                        //input

                        .i_a(i_a[53]),
                        .i_b(i_c[37]) 
);

halfadder halfadder3(//output
                        .o_sum(o_sum[54]),
                        .o_cout(o_carry[55]),
                        //input

                        .i_a(i_a[54]),
                        .i_b(i_c[38]) 
);

halfadder halfadder4(//output
                        .o_sum(o_sum[55]),
                        .o_cout(o_carry[56]),
                        //input

                        .i_a(i_a[55]),
                        .i_b(i_c[39]) 
);

halfadder halfadder5(//output
                        .o_sum(o_sum[56]),
                        .o_cout(o_carry[57]),
                        //input

                        .i_a(i_a[56]),
                        .i_b(i_c[40]) 
);

halfadder halfadder6(//output
                        .o_sum(o_sum[57]),
                        .o_cout(o_carry[58]),
                        //input

                        .i_a(i_a[57]),
                        .i_b(i_c[41]) 
);

halfadder halfadder7(//output
                        .o_sum(o_sum[58]),
                        .o_cout(o_carry[59]),
                        //input

                        .i_a(i_a[58]),
                        .i_b(i_c[42]) 
);

halfadder halfadder8(//output
                        .o_sum(o_sum[59]),
                        .o_cout(o_carry[60]),
                        //input

                        .i_a(i_a[59]),
                        .i_b(i_c[43]) 
);

halfadder halfadder9(//output
                        .o_sum(o_sum[60]),
                        .o_cout(o_carry[61]),
                        //input

                        .i_a(i_a[60]),
                        .i_b(i_c[44]) 
);

halfadder halfadder10(//output
                        .o_sum(o_sum[61]),
                        .o_cout(o_carry[62]),
                        //input

                        .i_a(i_a[61]),
                        .i_b(i_c[45]) 
);

halfadder halfadder11(//output
                        .o_sum(o_sum[62]),
                        .o_cout(o_carry[63]),
                        //input

                        .i_a(i_a[62]),
                        .i_b(i_c[46]) 
);




assign o_sum[64:63] = i_c[48:47];

endmodule