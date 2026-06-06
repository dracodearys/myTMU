/*-------------------------------------------------------------
+FHDR--------------------------------------------------
#  File Name: mul32_32_top_improve_sep4.sv
#  Creating Date: Tue Apr 09 16:45:50 CST 2024
#  Creating Author: dangqc
#  Description: Describe module
#  Related Document Path: xx/xxxx/xxx/xxx/
#  Last Modify: Tue Apr 09 16:45:50 CST 2024 
#-FDHR-------------------------------------------------
-------------------------------------------------------------*/
//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: mul32_32_top_improve_sep4.sv
//  Creating Date: Mon 15 Jan 2024 11:12:48 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 09 Apr 2024 04:42:36 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module mul32_32_top_improve_sep4 (
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


pp32and17_wallacetree_sep0 u2(
                            .o_sum(wallace_sum),
                            .o_carry(wallace_carry),
                            //
                            .i_clk(i_clk),
                            .i_reset_n(i_reset_n),
                            .i_bus_stall_en(i_bus_stall_en),
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

//logic[63:0] wallace_sum_ex1;
//logic[63:0] wallace_carry_ex1;
//
//always@(posedge i_clk or negedge i_reset_n)begin
//    if(!i_reset_n)begin
//     wallace_sum_ex1 <= 64'h0;
//     wallace_carry_ex1 <= 64'h0;
//    end
//    else begin
//     wallace_sum_ex1 <= wallace_sum[63:0];
//     wallace_carry_ex1 <= wallace_carry[63:0];
//    end
//end

cla64bit u4(
             //.i_clk(i_clk),
             //.i_reset_n(i_reset_n),
             .a(wallace_sum[63:0]),
             .b(wallace_carry[63:0]),
             //.cin(1'b0),
             //output
             .sum(o_sum_final_out),
             .carry_final()
);



endmodule