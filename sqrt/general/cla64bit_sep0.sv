//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: cla64bit_sep0.sv
//  Creating Date: Mon 15 Jan 2024 10:23:45 AM CST
//  Creating Author: sunhzh
//  Description: sep front 5 cla4bit and 11 cla4bit
//  Last Commit: Mon 15 Jan 2024 03:00:55 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module cla64bit_sep0(
                        input logic i_clk,
                        input logic i_reset_n,
                        input logic i_bus_stall_en,
                        input logic[63:0] a,
                        input logic[63:0] b,
                        //otuput
                        output logic[63:0] sum,
                        output logic carry_final
);

logic[16:0] c;
assign c[4:0] = 5'b0;
assign carry_final = c[15];

logic[19:0] sum_ex1;
logic[5:0] carry_ex1;
assign carry_ex1[0] = 1'b0;
logic[63:0] a_ex1;
logic[63:0] b_ex1;

genvar i;
generate 
    for(i=0;i<5;i++) begin :label1
      cla4bit cla0(
              .a(a[i*4+3:i*4]),
              .b(b[i*4+3:i*4]),
              .cin(carry_ex1[i]),
              .sum(sum_ex1[i*4+3:i*4]),
              .cout(carry_ex1[i+1])   
      );
    end
endgenerate


always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)
    sum[19:0] <= 40'h0;
  else if(!i_bus_stall_en) 
    sum[19:0] <= sum_ex1;
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)
    c[5] <= 1'b0;
  else if(!i_bus_stall_en)
    c[5] <= carry_ex1[5];
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
      a_ex1 <= 64'h0;
      b_ex1 <= 64'h0;
  end
  else if(!i_bus_stall_en)begin
      a_ex1[63:0] <= a[63:0];
      b_ex1[63:0] <= b[63:0];
  end
end

genvar j;
generate
    for(i=5;i<16;i++) begin :label2
      cla4bit cla0(
              .a(a_ex1[i*4+3:i*4]),
              .b(b_ex1[i*4+3:i*4]),
              //.a(a_ex1[]),
              //.b(b_ex1[63:0]),
              .cin(c[i]),
              .sum(sum[i*4+3:i*4]),
              .cout(c[i+1])   
      );
    end
endgenerate


endmodule