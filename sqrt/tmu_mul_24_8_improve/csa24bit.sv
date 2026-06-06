//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: csa24bit.sv
//  Creating Date: Tue 02 Jan 2024 01:16:20 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 02 Jan 2024 01:23:36 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module csa24bit(//output
                output logic[23:0] o_sum,
                output logic[23:0] o_carry,
                //
                input logic[23:0]i_a,
                input logic[23:0]i_b,
                input logic[23:0]i_c
);

//generate block
 genvar i;
 generate
   for(i=0; i<24; i=i+1)begin :fulladder_instance
              fulladder fulladder0(//output
                                  .o_sum(o_sum[i]),
                                  .o_carry(o_carry[i]),
                                  //
                                  .i_a(i_a[i]),
                                  .i_b(i_b[i]),
                                  .i_c(i_c[i])
              );
   end
 endgenerate


 endmodule