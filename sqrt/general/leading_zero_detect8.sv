//------------------------------------------
//  File Type: V OR SV 
//  File Name: leading_zero_detect8.sv
//  Creating Author: sunhzh
//  Creating Date: Wed 17 May 2023 05:07:58 PM CST
//  Description: 
//  Last Commit: Thu 26 Oct 2023 10:44:10 AM CST
//------------------------------------------

module leading_zero_detect8(//output
                             output wire [2:0] o_lzd_out,
                             output wire       o_zero_all,
                             //input 
                             input wire [7:0] i_lzd_in
                             );

  wire w_zero_all_1;
  wire w_zero_all_2;
  wire [1:0] w_ledzerodet_out_1;
  wire [1:0] w_ledzerodet_out_2;

  leading_zero_detect4 leading_zero_detect_4_1(//output
                                                .o_lzd_out(w_ledzerodet_out_1),
                                                .o_zero_all(w_zero_all_1),
                                                //input 
                                                .i_lzd_in(i_lzd_in[7:4])
                                                );
  leading_zero_detect4 leading_zero_detect_4_2(//output
                                                .o_lzd_out(w_ledzerodet_out_2),
                                                .o_zero_all(w_zero_all_2),
                                                 //input 
                                                .i_lzd_in(i_lzd_in[3:0])
                                                 );

  // assign o_lzd_out = ({3{~w_zero_all_1}} & {1'b0 , w_ledzerodet_out_1})
  //                         |({3{w_zero_all_1 & ~w_zero_all_2}} & {1'b1 , w_ledzerodet_out_2});
  assign o_lzd_out = ({1'b0 , w_ledzerodet_out_1})
                          |({3{w_zero_all_1 & ~w_zero_all_2}} & {1'b1 , w_ledzerodet_out_2});

  assign o_zero_all = w_zero_all_1 & w_zero_all_2;

endmodule