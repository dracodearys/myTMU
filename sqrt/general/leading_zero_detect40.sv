//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: leading_zero_detect40.sv
//  Creating Date: Tue 05 Dec 2023 09:34:38 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 05 Dec 2023 09:53:49 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module leading_zero_detect40 (
                                input logic[39:0] i_lzd_in,
                                //
                                output logic[5:0] o_lzd_out,
                                output logic      o_zero_all
);

logic w_zero_all_1;
logic w_zero_all_2;
logic w_zero_all_3;
logic w_zero_all_4;
logic w_zero_all_5;

logic[2:0] w_lzd_out_1;
logic[2:0] w_lzd_out_2;
logic[2:0] w_lzd_out_3;
logic[2:0] w_lzd_out_4;
logic[2:0] w_lzd_out_5;


leading_zero_detect8 leading_zero_detect8_1(
                                                .o_lzd_out(w_lzd_out_1),
                                                .o_zero_all(w_zero_all_1),
                                                //
                                                .i_lzd_in(i_lzd_in[39:32])
);

leading_zero_detect8 leading_zero_detect8_2(
                                                .o_lzd_out(w_lzd_out_2),
                                                .o_zero_all(w_zero_all_2),
                                                //
                                                .i_lzd_in(i_lzd_in[31:24])
);

leading_zero_detect8 leading_zero_detect8_3(
                                                .o_lzd_out(w_lzd_out_3),
                                                .o_zero_all(w_zero_all_3),
                                                //
                                                .i_lzd_in(i_lzd_in[23:16])
);

leading_zero_detect8 leading_zero_detect8_4(
                                                .o_lzd_out(w_lzd_out_4),
                                                .o_zero_all(w_zero_all_4),
                                                //
                                                .i_lzd_in(i_lzd_in[15:8])
);
leading_zero_detect8 leading_zero_detect8_5(
                                                .o_lzd_out(w_lzd_out_5),
                                                .o_zero_all(w_zero_all_5),
                                                //
                                                .i_lzd_in(i_lzd_in[7:0])


);

assign o_lzd_out = ({2'b0,w_lzd_out_1})
                        | ({5{w_zero_all_1 & ~w_zero_all_2}} & {1'b1,1'b1,w_lzd_out_2})
                        | ({5{w_zero_all_1 & w_zero_all_2 & ~w_zero_all_3}} & {1'b1,1'b0,w_lzd_out_3})
                        | ({5{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & ~w_zero_all_4}} & {1'b0,1'b1,w_lzd_out_4})
                        | ({5{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4 & ~w_zero_all_5}} & {1'b1,1'b0,w_lzd_out_5});


assign o_zero_all = w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4 & w_zero_all_5;


endmodule