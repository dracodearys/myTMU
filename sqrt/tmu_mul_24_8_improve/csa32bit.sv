//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: csa32bit.sv
//  Creating Date: Wed 27 Dec 2023 03:57:37 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Dec 2023 04:33:11 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module csa32bit(//output 
                output logic[31:0] o_sum,
                output logic[31:0] o_carry,
                //
                input logic[31:0] i_a,
                input logic[31:0] i_b,
                input logic[31:0] i_c
);

csa28bit csa28bit0(//output 
                   .o_sum(o_sum[27:0]),
                   .o_carry(o_carry[27:0]),
                //
                   .i_a(i_a[27:0]),
                   .i_b(i_b[27:0]),
                   .i_c(i_c[27:0])
);

fulladder fulladder0(//output
          .o_sum(o_sum[28]),   
          .o_carry(o_carry[28]),
          //input
          .i_a(i_a[28]),
          .i_b(i_b[28]),
          .i_c(i_c[28])
);

fulladder fulladder1(//output
          .o_sum(o_sum[29]),   
          .o_carry(o_carry[29]),
          //input
          .i_a(i_a[29]),
          .i_b(i_b[29]),
          .i_c(i_c[29])
);

fulladder fulladder2(//output
          .o_sum(o_sum[30]),   
          .o_carry(o_carry[30]),
          //input
          .i_a(i_a[30]),
          .i_b(i_b[30]),
          .i_c(i_c[30])
);

fulladder fulladder3(//output
          .o_sum(o_sum[31]),   
          .o_carry(o_carry[31]),
          //input
          .i_a(i_a[31]),
          .i_b(i_b[31]),
          .i_c(i_c[31])
);



endmodule
