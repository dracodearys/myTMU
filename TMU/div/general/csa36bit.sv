//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: csa36bit.sv
//  Creating Date: Wed 27 Dec 2023 04:03:51 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Dec 2023 04:34:04 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module csa36bit(//output 
                output logic[35:0] o_sum,
                output logic[35:0] o_carry,
                //
                input logic[35:0] i_a,
                input logic[35:0] i_b,
                input logic[35:0] i_c
);

csa32bit csa32bit(//output 
                    .o_sum(o_sum[31:0]),
                    .o_carry(o_carry[31:0]),
                   //
                    .i_a(i_a[31:0]),
                    .i_b(i_b[31:0]),
                    .i_c(i_c[31:0])
);

fulladder fulladder0(//output
          .o_sum(o_sum[32]),   
          .o_carry(o_carry[32]),
          //input
          .i_a(i_a[32]),
          .i_b(i_b[32]),
          .i_c(i_c[32])
);

fulladder fulladder1(//output
          .o_sum(o_sum[33]),   
          .o_carry(o_carry[33]),
          //input
          .i_a(i_a[33]),
          .i_b(i_b[33]),
          .i_c(i_c[33])
);

fulladder fulladder2(//output
          .o_sum(o_sum[34]),   
          .o_carry(o_carry[34]),
          //input
          .i_a(i_a[34]),
          .i_b(i_b[34]),
          .i_c(i_c[34])
);

fulladder fulladder3(//output
          .o_sum(o_sum[35]),   
          .o_carry(o_carry[35]),
          //input
          .i_a(i_a[35]),
          .i_b(i_b[35]),
          .i_c(i_c[35])
);




endmodule
