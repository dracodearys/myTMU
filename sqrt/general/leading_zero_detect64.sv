//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: leading_zero_detect_64.sv
//  Creating Date: Thu 26 Oct 2023 10:07:37 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 26 Oct 2023 10:07:52 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module leading_zero_detect64 (
                                    input logic[63:0] i_lzd_in,
                                    //
                                    output logic[6:0] o_lzd_out,
                                    output logic      o_zero_all
);

logic w_zero_all_1;
logic w_zero_all_2;
logic w_zero_all_3;
logic w_zero_all_4;
logic w_zero_all_5;
logic w_zero_all_6;
logic w_zero_all_7;
logic w_zero_all_8;

logic[2:0] w_lzd_out_1;
logic[2:0] w_lzd_out_2;
logic[2:0] w_lzd_out_3;
logic[2:0] w_lzd_out_4;
logic[2:0] w_lzd_out_5;
logic[2:0] w_lzd_out_6;
logic[2:0] w_lzd_out_7;
logic[2:0] w_lzd_out_8;

leading_zero_detect8 leading_zero_detect8_1(
                                                .o_lzd_out(w_lzd_out_1),
                                                .o_zero_all(w_zero_all_1),
                                                //
                                                .i_lzd_in(i_lzd_in[63:56])
);

leading_zero_detect8 leading_zero_detect8_2(
                                                .o_lzd_out(w_lzd_out_2),
                                                .o_zero_all(w_zero_all_2),
                                                //
                                                .i_lzd_in(i_lzd_in[55:48])
);

leading_zero_detect8 leading_zero_detect8_3(
                                                .o_lzd_out(w_lzd_out_3),
                                                .o_zero_all(w_zero_all_3),
                                                //
                                                .i_lzd_in(i_lzd_in[47:40])
);

leading_zero_detect8 leading_zero_detect8_4(
                                                .o_lzd_out(w_lzd_out_4),
                                                .o_zero_all(w_zero_all_4),
                                                //
                                                .i_lzd_in(i_lzd_in[39:32])
);

leading_zero_detect8 leading_zero_detect8_5(
                                                .o_lzd_out(w_lzd_out_5),
                                                .o_zero_all(w_zero_all_5),
                                                //
                                                .i_lzd_in(i_lzd_in[31:24])
);

leading_zero_detect8 leading_zero_detect8_6(
                                                .o_lzd_out(w_lzd_out_6),
                                                .o_zero_all(w_zero_all_6),
                                                //
                                                .i_lzd_in(i_lzd_in[23:16])
);

leading_zero_detect8 leading_zero_detect8_7(
                                                .o_lzd_out(w_lzd_out_7),
                                                .o_zero_all(w_zero_all_7),
                                                //
                                                .i_lzd_in(i_lzd_in[15:8])
);

leading_zero_detect8 leading_zero_detect8_8(
                                                .o_lzd_out(w_lzd_out_8),
                                                .o_zero_all(w_zero_all_8),
                                                //
                                                .i_lzd_in(i_lzd_in[7:0])
);

assign o_lzd_out = ({3'b0,w_lzd_out_1})
                        | ({6{w_zero_all_1 & ~w_zero_all_2}} & {1'b0,1'b0,1'b1,w_lzd_out_2})
                        | ({6{w_zero_all_1 & w_zero_all_2 & ~w_zero_all_3}} & {1'b0,1'b1,1'b0,w_lzd_out_3})
                        | ({6{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & ~w_zero_all_4}} & {1'b0,1'b1,1'b1,w_lzd_out_4})
                        | ({6{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4 & ~w_zero_all_5}} & {1'b1,1'b0,1'b0,w_lzd_out_5})
                        | ({6{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4 & w_zero_all_5 & ~w_zero_all_6}} & {1'b1,1'b0,1'b1,w_lzd_out_6})
                        | ({6{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4 & w_zero_all_5 & w_zero_all_6 & ~w_zero_all_7}} & {1'b1,1'b1,1'b0,w_lzd_out_7})
                        | ({6{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4 & w_zero_all_5 & w_zero_all_6 & w_zero_all_7 & ~w_zero_all_8}} & {1'b1,1'b1,1'b1,w_lzd_out_8});


assign o_zero_all = w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4 & w_zero_all_5 & w_zero_all_6 & w_zero_all_7 & w_zero_all_8;




endmodule