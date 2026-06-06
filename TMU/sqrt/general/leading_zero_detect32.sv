//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: leading_zero_detect32.sv
//  Creating Date: Mon 06 Nov 2023 10:08:19 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Mon 22 Jan 2024 10:58:00 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module leading_zero_detect32 (
                                input logic[31:0] i_lzd_in,
                                //
                                output logic[4:0] o_lzd_out,
                                output logic      o_zero_all
);

logic w_zero_all_1;
logic w_zero_all_2;
logic w_zero_all_3;
logic w_zero_all_4;

logic[2:0] w_lzd_out_1;
logic[2:0] w_lzd_out_2;
logic[2:0] w_lzd_out_3;
logic[2:0] w_lzd_out_4;
    

leading_zero_detect8 leading_zero_detect8_1(
                                                .o_lzd_out(w_lzd_out_1),
                                                .o_zero_all(w_zero_all_1),
                                                //
                                                .i_lzd_in(i_lzd_in[31:24])
);

leading_zero_detect8 leading_zero_detect8_2(
                                                .o_lzd_out(w_lzd_out_2),
                                                .o_zero_all(w_zero_all_2),
                                                //
                                                .i_lzd_in(i_lzd_in[23:16])
);

leading_zero_detect8 leading_zero_detect8_3(
                                                .o_lzd_out(w_lzd_out_3),
                                                .o_zero_all(w_zero_all_3),
                                                //
                                                .i_lzd_in(i_lzd_in[15:8])
);

leading_zero_detect8 leading_zero_detect8_4(
                                                .o_lzd_out(w_lzd_out_4),
                                                .o_zero_all(w_zero_all_4),
                                                //
                                                .i_lzd_in(i_lzd_in[7:0])
);

assign o_lzd_out = ({2'b0,w_lzd_out_1})
                        | ({5{w_zero_all_1 & ~w_zero_all_2}} & {1'b1,1'b1,w_lzd_out_2})
                        | ({5{w_zero_all_1 & w_zero_all_2 & ~w_zero_all_3}} & {1'b1,1'b0,w_lzd_out_3})
                        | ({5{w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & ~w_zero_all_4}} & {1'b0,1'b1,w_lzd_out_4});


assign o_zero_all = w_zero_all_1 & w_zero_all_2 & w_zero_all_3 & w_zero_all_4;


endmodule