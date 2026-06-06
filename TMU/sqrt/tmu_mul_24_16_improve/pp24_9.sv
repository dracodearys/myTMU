//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp24_9.sv
//  Creating Date: Wed 03 Jan 2024 01:42:14 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 03 Jan 2024 06:43:30 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module pp24_9(
                input logic[23:0] i_a,
                input logic[15:0] i_b,
                //
                output logic[27:0] o_pp0,
                output logic[28:0] o_pp1,
                output logic[28:0] o_pp2,
                output logic[28:0] o_pp3,
                output logic[28:0] o_pp4,
                output logic[28:0] o_pp5,
                output logic[28:0] o_pp6,
                output logic[28:0] o_pp7,
                output logic[26:0] o_pp8
);

logic[24:0] w_ppij0;
logic[24:0] w_ppij1;
logic[24:0] w_ppij2;
logic[24:0] w_ppij3;
logic[24:0] w_ppij4;
logic[24:0] w_ppij5;
logic[24:0] w_ppij6;
logic[24:0] w_ppij7;
logic[24:0] w_ppij8;

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij0(
                                                  .o_ppij(w_ppij0),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b({i_b[1:0],1'b0})
);

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij1(
                                                  .o_ppij(w_ppij1),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b(i_b[3:1])
);

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij2(
                                                  .o_ppij(w_ppij2),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b(i_b[5:3])
);

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij3(
                                                  .o_ppij(w_ppij3),
                                                  //input
                                                  .i_a(i_a),
                                                  .i_b(i_b[7:5])
);

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij4(//output
                                                    .o_ppij(w_ppij4),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[9:7])
);

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij5(//output
                                                    .o_ppij(w_ppij5),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[11:9])
);    

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij6(//output
                                                    .o_ppij(w_ppij6),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[13:11])
); 

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij7(//output
                                                    .o_ppij(w_ppij7),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[15:13])
); 

pp24and9_mulbooth_ppij pp24and9_mulbooth_ppij8(//output
                                                    .o_ppij(w_ppij8),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b({2'b00,i_b[15]})
);

assign o_pp0 = {~i_b[1] ,i_b[1] ,i_b[1] ,w_ppij0};
assign o_pp1 = {1'b1 ,~i_b[3] ,w_ppij1 ,1'b0 ,i_b[1]};
assign o_pp2 = {1'b1 ,~i_b[5] ,w_ppij2 ,1'b0 ,i_b[3]};
assign o_pp3 = {1'b1 ,~i_b[7] ,w_ppij3 ,1'b0 ,i_b[5]};
assign o_pp4 = {1'b1 ,~i_b[9] ,w_ppij4 ,1'b0 ,i_b[7]};
assign o_pp5 = {1'b1 ,~i_b[11] ,w_ppij5 ,1'b0 ,i_b[9]};
assign o_pp6 = {1'b1 ,~i_b[13] ,w_ppij6 ,1'b0 ,i_b[11]};
assign o_pp7 = {1'b1 ,~i_b[15] ,w_ppij7 ,1'b0 ,i_b[13]};
assign o_pp8 = {w_ppij8 ,1'b0 ,i_b[15]};


endmodule 