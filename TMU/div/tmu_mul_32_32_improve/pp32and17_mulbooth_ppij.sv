//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_mulbooth_ppij.sv
//  Creating Date: Wed 27 Dec 2023 02:36:12 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Dec 2023 06:22:19 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module pp32and17_mulbooth_ppij (
                                                     output logic[32:0]o_ppij,   
                                                     //input
                                                     input logic[31:0] i_a,
                                                     input logic[2:0] i_b
);

logic w_sign;
logic w_sel_m;
logic w_sel_2m;

//booth code 
mulbooth_code mulbooth_code(
                                .i_x2i_l(i_b[0]),
                                .i_x2i  (i_b[1]),
                                .i_x2i_m(i_b[2]),
                                //output 
                                .o_sign  (w_sign),
                                .o_sel_m (w_sel_m),
                                .o_sel_2m(w_sel_2m)
);


//bit chose
mulbooth_sel  mulbooth_sel00(//output
                              .o_ppij(o_ppij[0]),
                              //input
                              .i_sign(w_sign),
                              .i_sel_m(w_sel_m),
                              .i_sel_2m(w_sel_2m),
                              .i_yj(i_a[0]),
                              .i_yi_l(1'b0)
                            );

generate
    genvar n;
        for(n=1; n<32 ; n=n+1)begin: mulbooth_sel_inatance
                mulbooth_sel  mulbooth_sel01(//output
                                        .o_ppij(o_ppij[n]),
                                        //input
                                        .i_sign(w_sign),
                                        .i_sel_m(w_sel_m),
                                        .i_sel_2m(w_sel_2m),
                                        .i_yj(i_a[n]),
                                        .i_yi_l(i_a[n-1])
                                          );//generate block
    end
  endgenerate

  mulbooth_sel  mulbooth_sel32(//output
                              .o_ppij(o_ppij[32]),
                              //input
                              .i_sign(w_sign),
                              .i_sel_m(w_sel_m),
                              .i_sel_2m(w_sel_2m),
                              .i_yj(1'b0),
                              .i_yi_l(i_a[31])
                              );


endmodule