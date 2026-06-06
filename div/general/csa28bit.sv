//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: csa28bit.sv
//  Creating Date: Wed 27 Dec 2023 04:02:26 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Dec 2023 04:35:57 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module csa28bit(//output 
                output logic[27:0] o_sum,
                output logic[27:0] o_carry,
                //
                input logic[27:0] i_a,
                input logic[27:0] i_b,
                input logic[27:0] i_c
);

 //generate block
  genvar i;
  generate 
    for (i=0; i<28; i=i+1)begin : fulladder_instance
              fulladder fulladder0(//output
                                  .o_sum(o_sum[i]),   
                                  .o_carry(o_carry[i]),
                                  //input
                                  .i_a(i_a[i]),
                                  .i_b(i_b[i]),
                                  .i_c(i_c[i])
                                  );
    end
  endgenerate



endmodule
