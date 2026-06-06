//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: csa20bit.sv
//  Creating Date: Thu 04 Jan 2024 08:57:10 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 09:02:36 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module csa20bit(//otuput
                output logic[19:0] o_sum,
                output logic[19:0] o_carry,
                //
                input logic[19:0] i_a,
                input logic[19:0] i_b,
                input logic[19:0] i_c
);

//gnerate block
   genvar i;
   generate
      for(i=0; i<20; i=i+1)begin : fulladder_instance
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