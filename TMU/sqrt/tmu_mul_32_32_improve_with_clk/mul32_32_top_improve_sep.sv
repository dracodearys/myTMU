//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul32_32_top_improve_sep.sv
//  Creating Date: Wed 27 Dec 2023 02:33:58 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Mon 15 Jan 2024 02:56:20 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32_32_top_improve_sep (
                    input logic i_clk,
                    input logic i_reset_n,
                    input logic i_bus_stall_en,
                    input logic[31:0] i_x,
                    input logic[31:0] i_y,
                    //
                    //output logic[65:0] o_ex1_wallace_sum,
                    //output logic[65:0] o_ex1_wallace_carry,
                    output logic[63:0] o_sum_final_out
);


logic[35:0] o_pp0;
logic[36:0] o_pp1,o_pp2,o_pp3,o_pp4,o_pp5,o_pp6,o_pp7,o_pp8,o_pp9,o_pp10,o_pp11,o_pp12,o_pp13,o_pp14,o_pp15;
logic[34:0] o_pp16;
    
//partial product
pp32_17 u1(
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
            .o_pp8(o_pp8),
            .o_pp9(o_pp9),
            .o_pp10(o_pp10),
            .o_pp11(o_pp11),
            .o_pp12(o_pp12),
            .o_pp13(o_pp13),
            .o_pp14(o_pp14),
            .o_pp15(o_pp15),
            .o_pp16(o_pp16)
);


logic[65:0] wallace_sum;
logic[65:0] wallace_carry;


pp32and17_wallacetree u2(
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
                            .i_a4(o_pp8),
                            .i_b4(o_pp9),
                            .i_a5(o_pp10),
                            .i_b5(o_pp11),
                            .i_a6(o_pp12),
                            .i_b6(o_pp13),
                            .i_a7(o_pp14),
                            .i_b7(o_pp15),
                            .i_a8(o_pp16)
);

logic[63:0] wallace_sum_ex1;
logic[63:0] wallace_carry_ex1;

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)begin
     wallace_sum_ex1 <= 64'h0;
     wallace_carry_ex1 <= 64'h0;
    end
    else if(!i_bus_stall_en)begin
     wallace_sum_ex1 <= wallace_sum[63:0];
     wallace_carry_ex1 <= wallace_carry[63:0];
    end
end

cla64bit u4(
             .a(wallace_sum_ex1),
             .b(wallace_carry_ex1),
             //.cin(1'b0),
             //output
             .sum(o_sum_final_out),
             .carry_final()
);



endmodule