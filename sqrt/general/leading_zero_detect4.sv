//------------------------------------------
//  File Type: V OR SV 
//  File Name: leading_zero_detect4.sv
//  Creating Author: sunhzh
//  Creating Date: Wed 17 May 2023 05:08:19 PM CST
//  Description: 
//  Last Commit: Thu 26 Oct 2023 10:43:27 AM CST
//------------------------------------------


module leading_zero_detect4(//output
                             output wire [1:0] o_lzd_out,
                             output wire       o_zero_all,
                             //input 
                             input wire [3:0] i_lzd_in
                             );
  reg [1:0] r_ledzerodet_out;
  reg       r_zero_all;

  always @ (i_lzd_in) begin
    r_ledzerodet_out = 2'b00;
    r_zero_all       = 1'b0;
    case(i_lzd_in)
      4'b1000 ,
      4'b1001 ,
      4'b1010 ,
      4'b1011 ,
      4'b1100 ,
      4'b1101 ,
      4'b1110 ,
      4'b1111 : 
        begin 
          r_ledzerodet_out = 2'b00;
          r_zero_all       = 1'b0; 
        end

      4'b0100 ,
      4'b0101 ,
      4'b0110 ,
      4'b0111 : 
        begin 
          r_ledzerodet_out = 2'b01;
          r_zero_all       = 1'b0; 
        end      

      4'b0010 ,
      4'b0011 :
        begin 
          r_ledzerodet_out = 2'b10;
          r_zero_all       = 1'b0; 
        end
      4'b0001 :
        begin 
          r_ledzerodet_out = 2'b11;
          r_zero_all       = 1'b0; 
        end
      default :
        begin 
          r_zero_all       = 1'b1; 
        end
    endcase
  end
  assign o_lzd_out = r_ledzerodet_out;
  assign o_zero_all = r_zero_all;
endmodule