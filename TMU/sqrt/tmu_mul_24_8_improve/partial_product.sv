//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: partial_product.sv
//  Creating Date: Fri 29 Dec 2023 10:35:27 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 03 Jan 2024 08:51:33 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module pp24_5 (
                input logic[23:0] i_a,
                input logic[7:0] i_b,
                //
                output logic[27:0] o_pp0,
                output logic[28:0] o_pp1,
                output logic[28:0] o_pp2,
                output logic[28:0] o_pp3,
                output logic[26:0] o_pp4
);


  logic [24:0] w_ppij0;
  logic [24:0] w_ppij1;
  logic [24:0] w_ppij2;
  logic [24:0] w_ppij3;
  logic [24:0] w_ppij4;

pp24and5_mulbooth_ppij pp24and5_mulbooth_ppij0(
                                                  .o_ppij(w_ppij0),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b({i_b[1:0],1'b0})
);

pp24and5_mulbooth_ppij pp24and5_mulbooth_ppij1(
                                                  .o_ppij(w_ppij1),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b(i_b[3:1])
);

pp24and5_mulbooth_ppij pp24and5_mulbooth_ppij2(
                                                  .o_ppij(w_ppij2),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b(i_b[5:3])
);

pp24and5_mulbooth_ppij pp24and5_mulbooth_ppij3(
                                                  .o_ppij(w_ppij3),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b(i_b[7:5])
);

pp24and5_mulbooth_ppij pp24and5_mulbooth_ppij4(
                                                  .o_ppij(w_ppij4),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b({2'b00,i_b[7]})
);


assign o_pp0 = {~i_b[1],i_b[1] ,i_b[1] ,w_ppij0};
assign o_pp1 = {1'b1 ,~i_b[3] ,w_ppij1 ,1'b0 ,i_b[1]};
assign o_pp2 = {1'b1 ,~i_b[5] ,w_ppij2 ,1'b0 ,i_b[3]};
assign o_pp3 = {1'b1 ,~i_b[7] ,w_ppij3 ,1'b0 ,i_b[5]};
assign o_pp4 = {w_ppij4 ,1'b0 ,i_b[7]};


endmodule