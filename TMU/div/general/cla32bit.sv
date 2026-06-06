//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: cla32bit.sv
//  Creating Date: Tue 02 Jan 2024 02:40:45 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 02 Jan 2024 02:47:49 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module cla32bit (
                    input logic[31:0] a,
                    input logic[31:0] b,
                    //
                    output logic[31:0] sum,
                    output carry_final
);

logic[8:0] c;
assign c[0] = 1'b0;
assign carry_final = c[7];

genvar i;
generate
    for(i=0;i<8;i++) begin :label
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