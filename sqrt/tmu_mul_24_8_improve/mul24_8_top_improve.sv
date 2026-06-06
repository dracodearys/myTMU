//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul24_8_top_improve.sv
//  Creating Date: Fri 29 Dec 2023 10:11:08 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 03 Jan 2024 10:43:27 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul24_8_top_improve(
                            input logic[23:0] i_x,       
                            input logic[7:0] i_y,
                            //
                            output logic[31:0] o_sum_final_out
);

logic[27:0] o_pp0;
logic[28:0] o_pp1,o_pp2,o_pp3;
logic[26:0] o_pp4;

//partial product

pp24_5 u1(
        .i_a(i_x),
        .i_b(i_y),
        //
        .o_pp0(o_pp0),
        .o_pp1(o_pp1),
        .o_pp2(o_pp2),
        .o_pp3(o_pp3),
        .o_pp4(o_pp4)
);

logic[31:0] wallace_sum;
logic[31:0] wallace_carry;

pp24and5_wallacetree u2(
                          .o_sum(wallace_sum),
                          .o_carry(wallace_carry),
                          //
                          .i_a0(o_pp0),
                          .i_b0(o_pp1),
                          .i_a1(o_pp2),
                          .i_b1(o_pp3),
                          .i_a2(o_pp4)
);


//tmu_cla32 u3(
//                .a(wallace_sum),
//                .b(wallace_carry),
//                .cin(1'b0),
//                //
//                .s(o_sum_final_out),
//                .cout(),
//                .Gm(),
//                .Pm()
//); 

logic[31:0] o_sum_final_out1;

cla32bit u3(
              .a(wallace_sum),
              .b(wallace_carry),
              //
              .sum(o_sum_final_out),
              .carry_final()
);



endmodule