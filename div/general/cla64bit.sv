//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: cla64bit.sv
//  Creating Date: Tue 02 Jan 2024 02:58:06 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 02 Jan 2024 03:04:46 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module cla64bit (
                    input logic[63:0] a,
                    input logic[63:0] b,
                    //
                    output logic[63:0] sum,
                    output carry_final
);

logic[16:0] c;
assign c[0] = 1'b0;
assign carry_final = c[15];

genvar i;
generate
    for(i=0;i<16;i++) begin :label
      cla4bit cla0(
              .a(a[i*4+3:i*4]),
              .b(b[i*4+3:i*4]),
              .cin(c[i]),
              .sum(sum[i*4+3:i*4]),
              .cout(c[i+1])   
      );
    end
endgenerate
    
endmodule