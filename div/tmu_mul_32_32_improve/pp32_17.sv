//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: partial_product.sv
//  Creating Date: Wed 27 Dec 2023 02:35:26 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Mon 15 Jan 2024 05:04:15 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module pp32_17(
                input logic[31:0] i_a,
                input logic[31:0] i_b,
                //
                output logic[35:0] o_pp0,
                output logic[36:0] o_pp1,
                output logic[36:0] o_pp2,
                output logic[36:0] o_pp3,
                output logic[36:0] o_pp4,
                output logic[36:0] o_pp5,
                output logic[36:0] o_pp6,
                output logic[36:0] o_pp7,
                output logic[36:0] o_pp8,
                output logic[36:0] o_pp9,
                output logic[36:0] o_pp10,
                output logic[36:0] o_pp11,
                output logic[36:0] o_pp12,
                output logic[36:0] o_pp13,
                output logic[36:0] o_pp14,
                output logic[36:0] o_pp15,
                output logic[34:0] o_pp16
);

  logic [32:0] w_ppij0;
  logic [32:0] w_ppij1;
  logic [32:0] w_ppij2;
  logic [32:0] w_ppij3;
  logic [32:0] w_ppij4;
  logic [32:0] w_ppij5;
  logic [32:0] w_ppij6;
  logic [32:0] w_ppij7;
  logic [32:0] w_ppij8;
  logic [32:0] w_ppij9;
  logic [32:0] w_ppij10;
  logic [32:0] w_ppij11;
  logic [32:0] w_ppij12;
  logic [32:0] w_ppij13;
  logic [32:0] w_ppij14; 
  logic [32:0] w_ppij15;
  logic [32:0] w_ppij16;


pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij0(
                                                    .o_ppij(w_ppij0),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b({i_b[1:0] , 1'b0})
);

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij1(
                                                    .o_ppij(w_ppij1),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[3:1])
);

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij2(//output
                                                    .o_ppij(w_ppij2),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[5:3])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij3(//output 
                                                    .o_ppij(w_ppij3),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[7:5])
                                                    );   

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij4(//output
                                                    .o_ppij(w_ppij4),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[9:7])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij5(//output
                                                    .o_ppij(w_ppij5),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[11:9])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij6(//output
                                                    .o_ppij(w_ppij6),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[13:11])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij7(//output
                                                    .o_ppij(w_ppij7),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[15:13])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij8(//output
                                                    .o_ppij(w_ppij8),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[17:15])
                                                    );                                                                                                                                                        

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij9(//output
                                                    .o_ppij(w_ppij9),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[19:17])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij10(//output
                                                    .o_ppij(w_ppij10),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[21:19])
                                                    ); 

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij11(//output
                                                    .o_ppij(w_ppij11),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[23:21])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij12(//output
                                                    .o_ppij(w_ppij12),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[25:23])
                                                    );

pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij13(//output
                                                    .o_ppij(w_ppij13),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[27:25])
                                                    );
pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij14(//output
                                                    .o_ppij(w_ppij14),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[29:27])
                                                    );
pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij15(//output
                                                    .o_ppij(w_ppij15),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b(i_b[31:29])
                                                    );
pp32and17_mulbooth_ppij pp32and17_mulbooth_ppij16(//output
                                                    .o_ppij(w_ppij16),   
                                                    //input
                                                    .i_a(i_a),
                                                    .i_b({2'b00,i_b[31]})
                                                    );

assign o_pp0  = {~i_b[1] ,i_b[1] ,i_b[1] ,w_ppij0};
assign o_pp1  = {1'b1 ,~i_b[3] ,w_ppij1 ,1'b0 ,i_b[1]};
assign o_pp2  = {1'b1 ,~i_b[5] ,w_ppij2 ,1'b0 ,i_b[3]};
assign o_pp3  = {1'b1 ,~i_b[7] ,w_ppij3 ,1'b0 ,i_b[5]};
assign o_pp4  = {1'b1 ,~i_b[9] ,w_ppij4 ,1'b0 ,i_b[7]};
assign o_pp5  = {1'b1 ,~i_b[11] ,w_ppij5 ,1'b0 ,i_b[9]};
assign o_pp6  = {1'b1 ,~i_b[13] ,w_ppij6 ,1'b0 ,i_b[11]};
assign o_pp7  = {1'b1 ,~i_b[15] ,w_ppij7 ,1'b0 ,i_b[13]};
assign o_pp8  = {1'b1 ,~i_b[17] ,w_ppij8 ,1'b0 ,i_b[15]};
assign o_pp9  = {1'b1 ,~i_b[19] ,w_ppij9 ,1'b0 ,i_b[17]};
assign o_pp10 = {1'b1 ,~i_b[21] ,w_ppij10 ,1'b0 ,i_b[19]};
assign o_pp11 = {1'b1 ,~i_b[23] ,w_ppij11 ,1'b0 ,i_b[21]};
assign o_pp12 = {1'b1 ,~i_b[25] ,w_ppij12 ,1'b0 ,i_b[23]};
assign o_pp13 = {1'b1 ,~i_b[27] ,w_ppij13 ,1'b0 ,i_b[25]};
assign o_pp14 = {1'b1 ,~i_b[29] ,w_ppij14 ,1'b0 ,i_b[27]};
assign o_pp15 = {1'b1 ,~i_b[31] ,w_ppij15 ,1'b0 ,i_b[29]};
assign o_pp16 = {w_ppij16,1'b0,i_b[31]};



endmodule