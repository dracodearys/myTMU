//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: cla40bit.sv
//  Creating Date: Thu 04 Jan 2024 08:50:05 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 04 Jan 2024 08:51:15 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module cla40bit (
                    input logic[39:0] a,
                    input logic[39:0] b,
                    //
                    output logic[39:0] sum,
                    output carry_final
);

logic[10:0] c;
assign c[0] = 1'b0;
assign carry_final = c[9];

genvar i;
generate
    for(i=0;i<10;i++) begin :label
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