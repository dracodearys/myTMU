//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: tmu_divsion_quadf32_top.sv
//  Creating Date: Mon 18 Dec 2023 06:43:35 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Fri 29 Mar 2024 03:18:24 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module tmu_division_quadf_top (
                                    input logic i_clk,
                                    input logic i_reset_n,
                                    input logic i_bus_stall_en,
                                    input logic i_division_en,
                                    input logic i_quadf_en,
                                    input logic[31:0] i_x,
                                    input logic[31:0] i_y,
                                    //
                                    output logic[31:0] o_result,
                                    output logic[31:0] o_qu,
                                    output logic o_lvf,
                                    output logic o_luf
);

logic[23:0] i_x_man;
logic[7:0]  i_x_exp;
logic       i_x_sign;
logic       i_x_valid;
logic       i_x_inf;
logic       i_x_zero;

logic[23:0] i_y_man;
logic[7:0]  i_y_exp;
logic       i_y_sign;
logic       i_y_valid;
logic       i_y_inf;
logic       i_y_zero;

double_pickdata dp(
                        .i_rm(i_x),
                        .i_rn(i_y),
                        //
                        .o_rmman   (i_x_man),
                        .o_rmexp   (i_x_exp),
                        .o_rmsign  (i_x_sign),
                        .o_rmvalid (i_x_valid),
                        .o_rminf   (i_x_inf),
                        .o_rmzero  (i_x_zero),
                        //
                        .o_rnman   (i_y_man),
                        .o_rnexp   (i_y_exp),
                        .o_rnsign  (i_y_sign),
                        .o_rnvalid (i_y_valid),
                        .o_rninf   (i_y_inf),
                        .o_rnzero  (i_y_zero)                        
);

logic value_en;
logic quadf_ratio;
assign value_en = (i_x_valid && i_y_valid) ?  1'b1 : 1'b0;
assign quadf_ratio = (i_x[30:0] < i_y[30:0]) ?  1'b1 : 1'b0;  // 1: -x/y   0: y/x

logic[23:0] dividend_man;  
logic[7:0] dividend_exp;  
logic dividend_sign;
logic dividend_valid;
logic dividend_inf;
logic dividend_zero;
logic[23:0] divisor_man;
logic[7:0] divisor_exp;
logic divisor_sign;
logic divisor_valid;
logic divisor_inf;
logic divisor_zero;
logic ratio_ex_sign;
logic[31:0] o_qu_mid;

always_comb begin
    dividend_man   = 24'h0_0000;
    dividend_exp   = 8'h00;
    dividend_sign  = 1'b0;
    dividend_valid = 1'b0;
    dividend_inf   = 1'b0;
    dividend_zero  = 1'b0;
    divisor_man    = 24'h0_0000;
    divisor_exp    = 8'h00;
    divisor_sign   = 1'b0;
    divisor_valid  = 1'b0;
    divisor_inf    = 1'b0;
    divisor_zero   = 1'b0;
    ratio_ex_sign = 1'b0;
    o_qu_mid          = 32'h0000_0000;
    if(i_division_en && ~i_quadf_en)begin
        dividend_man   = i_x_man;
        dividend_exp   = i_x_exp;
        dividend_sign  = i_x_sign;
        dividend_valid = i_x_valid;
        dividend_inf   = i_x_inf;
        dividend_zero  = i_x_zero; 
        divisor_man    = i_y_man;
        divisor_exp    = i_y_exp;
        divisor_sign   = i_y_sign;
        divisor_valid  = i_y_valid;
        divisor_inf    = i_y_inf;
        divisor_zero   = i_y_zero;         
    end
    else if(~i_division_en && i_quadf_en) begin
        if(quadf_ratio)begin
            ratio_ex_sign = 1'b1;
            dividend_man   = i_x_man;  
            dividend_exp   = i_x_exp;  
            dividend_sign  = i_x_sign; 
            dividend_valid = i_x_valid;
            dividend_inf   = i_x_inf;  
            dividend_zero  = i_x_zero; 
            divisor_man    = i_y_man;  
            divisor_exp    = i_y_exp;  
            divisor_sign   = i_y_sign; 
            divisor_valid  = i_y_valid;
            divisor_inf    = i_y_inf;  
            divisor_zero   = i_y_zero; 
            if(value_en)begin
              if(~i_y[31])
                  o_qu_mid = 32'h3e800000;
              else
                  o_qu_mid = 32'hbe800000;
            end
            else if(i_y_valid && i_x_zero)begin //lose one situation(when y is valid x is zero)   //maybe canbe included in the above situation
              if(~i_y[31])
                  o_qu_mid = 32'h3e800000;
              else
                  o_qu_mid = 32'hbe800000;
            end
            else if(i_y_inf && (i_x_valid || i_x_zero))begin
                if(~i_y[31])
                    o_qu_mid = 32'h3e800000;
                else
                    o_qu_mid = 32'hbe800000;
            end
            else if(i_y_inf && i_x_inf)begin
                ratio_ex_sign = 1'b0;           //quadf sign is depend on (abs|y| > abs|x| -result // abs|y| <= abs|x| result) in TMU NO NEG ZERO
                o_qu_mid = 32'h0000_0000;
            end
        end
        else begin
          dividend_man   = i_y_man;    
          dividend_exp   = i_y_exp;  
          dividend_sign  = i_y_sign; 
          dividend_valid = i_y_valid;
          dividend_inf   = i_y_inf;  
          dividend_zero  = i_y_zero; 
          divisor_man    = i_x_man;  
          divisor_exp    = i_x_exp;  
          divisor_sign   = i_x_sign; 
          divisor_valid  = i_x_valid;
          divisor_inf    = i_x_inf;  
          divisor_zero   = i_x_zero; 
          if(value_en)begin
            if(~i_x[31])
                o_qu_mid = 32'h0000_0000;
            else if(~i_y[31])
                o_qu_mid = 32'h3f00_0000;
            else if(i_y[31])
                o_qu_mid = 32'hbf00_0000;
          end
          else if(i_x_valid && i_y_zero)begin //lose one situation(when x is valid y is zero)   //maybe canbe included in the above situation
            ratio_ex_sign = 1'b0;           //quadf sign is depend on (abs|y| > abs|x| -result // abs|y| <= abs|x| result) in TMU NO NEG ZERO
            if(~i_x[31])
              o_qu_mid = 32'h0000_0000;
            else if(i_x[31])
              o_qu_mid = 32'h3f00_0000;  
          end
          else if(i_x_inf && (i_y_valid || i_y_zero || i_y_inf))begin
            ratio_ex_sign = 1'b0;           //quadf sign is depend on (abs|y| > abs|x| -result // abs|y| <= abs|x| result) in TMU NO NEG ZERO  
            if(~i_x[31])
               o_qu_mid = 32'h0000_0000;
            else if(~i_y[31])
              o_qu_mid = 32'h3f00_0000;
            else if(i_y[31])
              o_qu_mid = 32'hbf00_0000;
          end
        end    
    end    
end

//
logic[23:0] dividend_man_dff;
logic[7:0]  dividend_exp_dff;
logic       dividend_sign_dff;
logic       dividend_valid_dff;
logic       dividend_inf_dff;
logic       dividend_zero_dff;
logic[23:0] divisor_man_dff;
logic[7:0]  divisor_exp_dff;
logic       divisor_sign_dff;
logic       divisor_valid_dff;
logic       divisor_inf_dff;
logic       divisor_zero_dff;
logic       i_quadf_en_dff;
logic       ratio_ex_sign_dff;
logic[31:0] o_qu_mid_dff;

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)begin
      dividend_man_dff      <= 24'h00_0000;
      dividend_exp_dff      <= 8'h00;
      dividend_sign_dff     <= 1'b0;
      dividend_valid_dff    <= 1'b0;
      dividend_inf_dff      <= 1'b0;
      dividend_zero_dff     <= 1'b0;
      divisor_man_dff       <= 24'h00_0000; 
      divisor_exp_dff       <= 8'h00; 
      divisor_sign_dff      <= 1'b0; 
      divisor_valid_dff     <= 1'b0; 
      divisor_inf_dff       <= 1'b0;
      divisor_zero_dff      <= 1'b0;
      i_quadf_en_dff        <= 1'b0;
      ratio_ex_sign_dff     <= 1'b0;
      o_qu_mid_dff          <= 32'b0;
    end
    else if(!i_bus_stall_en)begin
      dividend_man_dff      <= dividend_man;
      dividend_exp_dff      <= dividend_exp;
      dividend_sign_dff     <= dividend_sign;
      dividend_valid_dff    <= dividend_valid;
      dividend_inf_dff      <= dividend_inf;
      dividend_zero_dff     <= dividend_zero;
      divisor_man_dff       <= divisor_man;
      divisor_exp_dff       <= divisor_exp;
      divisor_sign_dff      <= divisor_sign;
      divisor_valid_dff     <= divisor_valid;
      divisor_inf_dff       <= divisor_inf;
      divisor_zero_dff      <= divisor_zero;
      i_quadf_en_dff        <= i_quadf_en;
      ratio_ex_sign_dff     <= ratio_ex_sign;
      o_qu_mid_dff          <= o_qu_mid;
    end
end


logic[31:0] o_result_mid;
logic o_ab_en;

tmu_division_top tdv(
                        .i_clk         (i_clk),
                        .i_reset_n     (i_reset_n),
                        .i_bus_stall_en(i_bus_stall_en),
                        .dividend_man  (dividend_man_dff),
                        .dividend_exp  (dividend_exp_dff),
                        .dividend_sign (dividend_sign_dff),
                        .dividend_valid(dividend_valid_dff),
                        .sp_dividend_inf  (dividend_inf_dff),
                        .sp_dividend_zero (dividend_zero_dff),                        
                        //
                        .divisor_man   (divisor_man_dff),
                        .divisor_exp   (divisor_exp_dff),
                        .divisor_sign  (divisor_sign_dff),
                        .divisor_valid (divisor_valid_dff),
                        .sp_divisor_inf   (divisor_inf_dff),
                        .sp_divisor_zero  (divisor_zero_dff),
                        //output 
                        .o_division_out(o_result_mid),
                        .o_lvf(o_lvf),
                        .o_luf(o_luf),
                        .o_ab_en(o_ab_en)                        
);

//e2
logic i_quadf_en_ex2;   
logic ratio_ex_sign_ex2;
logic[31:0] o_qu_mid_ex2;
always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_quadf_en_ex2    <= 1'b0;  
    ratio_ex_sign_ex2 <= 1'b0;
    o_qu_mid_ex2      <= 32'b0;
  end
  else if(!i_bus_stall_en)begin
    i_quadf_en_ex2    <= i_quadf_en_dff;  
    ratio_ex_sign_ex2 <= ratio_ex_sign_dff; 
    o_qu_mid_ex2      <= o_qu_mid_dff;   
  end
end

//e3
logic i_quadf_en_ex3;   
logic ratio_ex_sign_ex3;
logic[31:0] o_qu_mid_ex3;
always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_quadf_en_ex3    <= 1'b0;  
    ratio_ex_sign_ex3 <= 1'b0;
    o_qu_mid_ex3      <= 32'b0;
  end
  else if(!i_bus_stall_en)begin
    i_quadf_en_ex3    <= i_quadf_en_ex2;  
    ratio_ex_sign_ex3 <= ratio_ex_sign_ex2;
    o_qu_mid_ex3      <= o_qu_mid_ex2;    
  end
end

//e4
logic i_quadf_en_ex4;   
logic ratio_ex_sign_ex4;
logic[31:0] o_qu_mid_ex4;
always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_quadf_en_ex4    <= 1'b0;  
    ratio_ex_sign_ex4 <= 1'b0;
    o_qu_mid_ex4      <= 32'b0;
  end
  else if(!i_bus_stall_en)begin
    i_quadf_en_ex4    <= i_quadf_en_ex3;  
    ratio_ex_sign_ex4 <= ratio_ex_sign_ex3;  
    o_qu_mid_ex4      <= o_qu_mid_ex3;  
  end
end




always_comb begin
  o_result = 32'h0000_0000;
  o_qu     = 32'h0000_0000;
  if(i_quadf_en_ex4)begin
    o_qu = o_qu_mid_ex4;
    if(o_ab_en)
      o_result = {1'b0,o_result_mid[30:0]};
    else begin
      if(ratio_ex_sign_ex4)
        o_result = {~o_result_mid[31],o_result_mid[30:0]};
      else
        o_result = o_result_mid;
    end
  end
  else begin
    o_result = o_result_mid;
  end
end





endmodule