//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24_16_top_improve.sv
//  Creating Date: Wed 03 Jan 2024 01:24:32 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 08:54:51 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24_16_top_improve(
                              input logic[23:0] i_x,
                              input logic[15:0] i_y,
                              //
                              output logic[39:0] o_sum_final_out 
);

logic[27:0] o_pp0;
logic[28:0] o_pp1,o_pp2,o_pp3,o_pp4,o_pp5,o_pp6,o_pp7;
logic[26:0] o_pp8;

//partial product

pp24_9 u1(
            .i_a(i_x),
            .i_b(i_y),
            //
            .o_pp0(o_pp0),
            .o_pp1(o_pp1),
            .o_pp2(o_pp2),
            .o_pp3(o_pp3),
            .o_pp4(o_pp4),
            .o_pp5(o_pp5),
            .o_pp6(o_pp6),
            .o_pp7(o_pp7),
            .o_pp8(o_pp8)
);

logic[39:0] wallace_sum;
logic[39:0] wallace_carry;

pp24and9_wallacetree u2(
                          .o_sum(wallace_sum),
                          .o_carry(wallace_carry),
                          //
                          .i_a0(o_pp0),
                          .i_b0(o_pp1),
                          .i_a1(o_pp2),
                          .i_b1(o_pp3),
                          .i_a2(o_pp4),
                          .i_b2(o_pp5),
                          .i_a3(o_pp6),
                          .i_b3(o_pp7),
                          .i_a4(o_pp8)
);


cla40bit u3(
              .a(wallace_sum),
              .b(wallace_carry),
              //
              .sum(o_sum_final_out),
              .carry_final()
);

endmodule