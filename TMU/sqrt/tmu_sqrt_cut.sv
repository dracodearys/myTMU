//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: tmu_full_sqrt_top_cut.sv
//  Creating Date: Wed 10 Jan 2024 05:08:53 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 11 Jul 2024 01:19:58 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module tmu_sqrt_cut (
                    input logic i_clk,
                    input logic i_reset_n,
                    input logic i_bus_stall_en,
                    input logic i_sqrt_en,
                    input logic[31:0] i_rm,
                    //
                    output logic[31:0] o_result,
                    output logic o_lvf
);

parameter DEPTH=128,WIDTH=40;


logic [23:0] o_rmman;                                                                                                                      
logic [7:0] o_rmexp;                                                                                                                       
logic o_rmsigfn;                                                                                                                           
logic o_rmvalid;                                                                                                                           
logic o_rminf;
logic o_rmzero;

single_pickdata pre(                                                                                                                        
                    .i_rm(i_rm),                                                                                                           
                    //                                                                                                                     
                    .o_rmman(o_rmman),                                                                                                     
                    .o_rmexp(o_rmexp),                                                                                                     
                    .o_rmsign(o_rmsign),                                                                                                   
                    .o_rmvalid(o_rmvalid),                                                                                                 
                    .o_rminf(o_rminf),                                                                                                     
                    .o_rmzero(o_rmzero)                                                                                                    
);

logic o_sp_sign;
logic[7:0] o_sp_exp;
logic[22:0] o_sp_man;
logic o_sp_lvf;
logic table_en;
//special case
    always_comb begin
        o_sp_sign = 1'b0;
        o_sp_exp  = 8'h0;
        o_sp_man  = 23'h0;
        o_sp_lvf  = 1'b0;
        table_en  = 1'b0;
        if(o_rmsign)begin         //neg
            o_sp_sign = 1'b0;
            o_sp_exp  = 8'h0;
            o_sp_man  = 23'h0;
            table_en  = 1'b0;
            if(~o_rmvalid)begin
                if(o_rmzero)
                    o_sp_lvf = 1'b0;
                else
                    o_sp_lvf = 1'b1;
            end
            else begin
                o_sp_lvf = 1'b1;
            end
        end
        else begin            //pos
            if(~o_rmvalid)begin
                o_sp_sign = 1'b0;
                o_sp_man  = 23'h0;
                if(o_rminf)begin
                    o_sp_exp = 8'hff;
                    o_sp_lvf = 1'b1;
                end
                else begin 
                    o_sp_exp = 8'h00;
                    o_sp_lvf = 1'b0;
                end
            end
            else begin
                table_en = 1'b1;
            end
        end
    end

logic o_sp_sign_ex2;
logic[7:0] o_sp_exp_ex2;
logic[22:0] o_sp_man_ex2;
logic o_sp_sign_ex3;
logic[7:0] o_sp_exp_ex3;
logic[22:0] o_sp_man_ex3;
logic o_sp_sign_ex4;
logic[7:0] o_sp_exp_ex4;
logic[22:0] o_sp_man_ex4;
logic o_sp_sign_ex5;
logic[7:0] o_sp_exp_ex5;
logic[22:0] o_sp_man_ex5;
//ex2
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_sign_ex2 <= 1'b0; 
    else if(!i_bus_stall_en)
      o_sp_sign_ex2 <= o_sp_sign;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_exp_ex2 <= 8'h00;
    else if(!i_bus_stall_en) 
      o_sp_exp_ex2 <= o_sp_exp;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_man_ex2 <= 23'h0;
    else if(!i_bus_stall_en)
      o_sp_man_ex2 <= o_sp_man;
end
//ex3
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_sign_ex3 <= 1'b0; 
    else if(!i_bus_stall_en)
      o_sp_sign_ex3 <= o_sp_sign_ex2;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_exp_ex3 <= 8'h00;
    else if(!i_bus_stall_en) 
      o_sp_exp_ex3 <= o_sp_exp_ex2;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_man_ex3 <= 23'h0;
    else if(!i_bus_stall_en) 
      o_sp_man_ex3 <= o_sp_man_ex2;
end
//ex4
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_sign_ex4 <= 1'b0; 
    else if(!i_bus_stall_en)
      o_sp_sign_ex4 <= o_sp_sign_ex3;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_exp_ex4 <= 8'h00;
    else if(!i_bus_stall_en) 
      o_sp_exp_ex4 <= o_sp_exp_ex3;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_man_ex4 <= 23'h0;
    else if(!i_bus_stall_en) 
      o_sp_man_ex4 <= o_sp_man_ex3;
end
//ex5
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_sign_ex5 <= 1'b0; 
    else if(!i_bus_stall_en)
      o_sp_sign_ex5 <= o_sp_sign_ex4;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_exp_ex5 <= 8'h00;
    else if(!i_bus_stall_en) 
      o_sp_exp_ex5 <= o_sp_exp_ex4;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_man_ex5 <= 23'h0;
    else if(!i_bus_stall_en)
      o_sp_man_ex5 <= o_sp_man_ex4;
end

//assign o_lvf = o_sp_lvf;
logic o_sp_lvf_ex2;
logic o_sp_lvf_ex3;
logic o_sp_lvf_ex4;
logic o_sp_lvf_ex5;

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_lvf_ex2 <= 1'b0;    
    else if(!i_bus_stall_en)
      o_sp_lvf_ex2 <= o_sp_lvf;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_lvf_ex3 <= 1'b0;
    else if(!i_bus_stall_en)
      o_sp_lvf_ex3 <= o_sp_lvf_ex2;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_lvf_ex4 <= 1'b0;
    else if(!i_bus_stall_en)
      o_sp_lvf_ex4 <= o_sp_lvf_ex3;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_sp_lvf_ex5 <= 1'b0;
    else if(!i_bus_stall_en)
      o_sp_lvf_ex5 <= o_sp_lvf_ex4;
end

assign o_lvf = o_sp_lvf_ex5;

//normal sign part
logic o_final_sign;
assign o_final_sign = 1'b0;
//normal exp part
logic[7:0] o_final_exp;
logic[7:0] o_exp_real;         //using for rounding 
logic      o_exp_real_pos_en;  //using for rounding
sqrt_exp exp(
                .i_exp(o_rmexp),
                //
                .o_final_exp(o_final_exp),
                .o_exp_real(o_exp_real),
                .o_exp_real_pos_en(o_exp_real_pos_en)
);

logic o_final_sign_ex2;
logic[7:0] o_final_exp_ex2;
logic o_final_sign_ex3;
logic[7:0] o_final_exp_ex3;
logic o_final_sign_ex4;
logic[7:0] o_final_exp_ex4;
logic o_final_sign_ex5;
logic[7:0] o_final_exp_ex5;
//ex2
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_sign_ex2 <= 1'b0;
    else if(!i_bus_stall_en)
      o_final_sign_ex2 <= o_final_sign;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_exp_ex2 <= 8'b0;
    else if(!i_bus_stall_en)
      o_final_exp_ex2 <= o_final_exp;
end
//ex3
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_sign_ex3 <= 1'b0;
    else if(!i_bus_stall_en)
      o_final_sign_ex3 <= o_final_sign_ex2;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_exp_ex3 <= 8'b0;
    else if(!i_bus_stall_en)
      o_final_exp_ex3 <= o_final_exp_ex2;
end

//ex4
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_sign_ex4 <= 1'b0;
    else if(!i_bus_stall_en)
      o_final_sign_ex4 <= o_final_sign_ex3;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_exp_ex4 <= 8'b0;
    else if(!i_bus_stall_en)
      o_final_exp_ex4 <= o_final_exp_ex3;
end
//ex5
always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_sign_ex5 <= 1'b0;
    else if(!i_bus_stall_en)
      o_final_sign_ex5 <= o_final_sign_ex4;
end

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)
      o_final_exp_ex5 <= 8'b0;
    else if(!i_bus_stall_en)
      o_final_exp_ex5 <= o_final_exp_ex4;
end


//man iteration part
logic exp_low;                                                                                                                                                                                                                                        
logic [7:0] man_check; 
logic [7:0] man_est_eisqrt;                                                                                                                 
logic [15:0] man_est_einvf;
logic[7:0]  man_est_eisqrt_s;
logic[15:0] man_est_einvf_s;
                                                                                                                                           
assign exp_low=o_rmexp[0];                                                                                                                                                                                                                          
assign man_check={o_rmexp[0],o_rmman[22:16]};                                                                                            
                                                                                                                                           
est_sqrt_and_einvf_table #(                                                                                                                           
                 .DEPTH(DEPTH),                                                                                                            
                 .WIDTH(WIDTH)                                                                                                             
)                                                                                                                                          
table_check                                                                                                                                         
(                                                                                                                                          
                     .exp_low(exp_low),                                                                                         
                     .man_check(man_check),
                     .table_en(table_en),                                                                                            
                     //                                                                                                                    
                     .man_est_eisqrt(man_est_eisqrt),
                     .man_est_einvf(man_est_einvf),
                     .man_est_eisqrt_s(man_est_eisqrt_s),
                     .man_est_einvf_s(man_est_einvf_s)                                                                                       
); 

//est 1    
logic[31:0] x_0;
logic[39:0] b_0;
logic[31:0] y_0;

//assign x_0 = o_rmman * man_est_eisqrt;
//assign b_0 = o_rmman * man_est_einvf;
mul24_8_top_improve mul0_0(
                            .i_x(o_rmman),
                            .i_y(man_est_eisqrt),
                            //output
                            .o_sum_final_out(x_0)
);

//mul24_8_top_improve mul0_1(
//                            .i_x(o_rmman),
//                            .i_y(man_est_einvf),
//                            //output
//                            .o_sum_final_out(b_0)
//);
mul24_16_top_improve mul0_1(
                              .i_x(o_rmman),
                              .i_y(man_est_einvf),
                              //output
                              .o_sum_final_out(b_0)
);

logic[5:0] b_0_lzd_out;
logic      b_0_zero_all;
leading_zero_detect40 lzd1_1(
                        .i_lzd_in(b_0),
                        //
                        .o_lzd_out(b_0_lzd_out),
                        .o_zero_all(b_0_zero_all)
);

logic[39:0] b_0_fix;
logic[31:0] b_0_fix_truncate;

assign b_0_fix = b_0_zero_all ? 40'h00_0000_0000 : b_0 << b_0_lzd_out;
assign b_0_fix_truncate = b_0_fix[39:8];
assign y_0 = 33'h18000_0000 + ~b_0_fix_truncate + 1'b1;

//est 2
logic[31:0] x_0_s;
logic[39:0] b_0_s;
logic[31:0] y_0_s;

//assign x_0_s = o_rmman * man_est_eisqrt_s;
//assign b_0_s = o_rmman * man_est_einvf_s;
mul24_8_top_improve mul1_0(
                      .i_x(o_rmman),
                      .i_y(man_est_eisqrt_s),
                      //
                      .o_sum_final_out(x_0_s)
);

//mul32_32_top_improve mul1_1(
//                       .i_x(o_rmman),
//                       .i_y(man_est_einvf_s),
//                       //
//                       .o_sum_final_out(b_0_s)
//);
mul24_16_top_improve mul1_1(
                        .i_x(o_rmman),
                        .i_y(man_est_einvf_s),
                        //
                        .o_sum_final_out(b_0_s)
);



logic[5:0] b_0_s_lzd_out;
logic      b_0_s_zero_all;
leading_zero_detect40 lzd1_2(
                        .i_lzd_in(b_0_s),
                        //
                        .o_lzd_out(b_0_s_lzd_out),
                        .o_zero_all(b_0_s_zero_all)
);

logic[39:0] b_0_s_fix;
logic[31:0] b_0_s_fix_truncate;

assign b_0_s_fix = b_0_s_zero_all ? 40'h00_0000_0000 : b_0_s << b_0_s_lzd_out;
assign b_0_s_fix_truncate = b_0_s_fix[39:8];
assign y_0_s = 33'h18000_0000 + ~b_0_s_fix_truncate + 1'b1;


logic est_low_en;
always_comb begin
    if(b_0_fix_truncate[31:28]==4'h8)
        est_low_en = 1'b0;
    else 
        est_low_en = 1'b1;
end



//two estimate path 
logic[31:0] x_path_sel;
logic[31:0] y_path_sel;
logic[31:0] b_path_sel;

assign x_path_sel = est_low_en ? x_0_s: x_0;
assign y_path_sel = est_low_en ? y_0_s: y_0;
assign b_path_sel = est_low_en ? b_0_s_fix_truncate: b_0_fix_truncate;


logic[31:0] x_path_sel_ex1;
logic[31:0] y_path_sel_ex1;
logic[31:0] b_path_sel_ex1;

always@(posedge i_clk or negedge i_reset_n)begin
    if(!i_reset_n)begin
      x_path_sel_ex1 <= 32'h0000_0000;
      y_path_sel_ex1 <= 32'h0000_0000;
      b_path_sel_ex1 <= 32'h0000_0000;
    end
    else if(!i_bus_stall_en)begin
      x_path_sel_ex1 <= x_path_sel;
      y_path_sel_ex1 <= y_path_sel;
      b_path_sel_ex1 <= b_path_sel;
    end
end


logic[63:0] x_1;
logic[31:0] b_1; 
logic[31:0] y_1;
sqrt_i1_v1 i1(
                    .i_clk(i_clk),
                    .i_reset_n(i_reset_n),
                    .i_bus_stall_en(i_bus_stall_en),
                    .i_x_cv(x_path_sel_ex1),
                    .i_y_cv(y_path_sel_ex1),
                    .i_b_cv(b_path_sel_ex1),
                    //
                    .o_x_nv(x_1),
                    .o_b_nv(b_1),
                    .o_y_nv(y_1)
);

logic[63:0] x_2;
logic[31:0] b_2; 
logic[31:0] y_2;
sqrt_i2_v1 i2(
                    .i_clk(i_clk),
                    .i_reset_n(i_reset_n),
                    .i_bus_stall_en(i_bus_stall_en),
                    .i_x_cv(x_1[63:32]), //[31:0]        
                    .i_y_cv(y_1),        //[31:0] 
                    .i_b_cv(b_1),        //[31:0] 
                    //
                    .o_x_nv(x_2),        //[63:0] 
                    .o_b_nv(b_2),        //[63:0] 
                    .o_y_nv(y_2)         //[31:0] 
);

//iteration judgement

logic man_supplement;
logic cmp_carry;
logic[31:0] cmp_sum;
assign {cmp_carry,cmp_sum} = y_2 + 32'h0009_34d0; 

assign man_supplement = cmp_carry ?  1'b0 : 1'b1;

logic man_supplement_ex1;

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)
    man_supplement_ex1 <= 1'b0;
  else if(!i_bus_stall_en) 
    man_supplement_ex1 <= man_supplement;
end

logic[63:0] x_3;
//logic[31:0] b_3; 
//logic[31:0] y_3;
sqrt_i3_v1 i3(
                    .i_clk(i_clk),
                    .i_reset_n(i_reset_n),
                    .i_bus_stall_en(i_bus_stall_en),
                    .i_x_cv(x_2[63:32]), //[31:0]        
                    .i_y_cv(y_2),        //[31:0] 
                    //.i_b_cv(b_2),        //[31:0] 
                    //
                    .o_x_nv(x_3)        //[63:0] 
                    //.o_b_nv(b_3),        //[63:0] 
                    //.o_y_nv(y_3)         //[31:0] 
);

//iteration judgement

//logic man_supplement;

//assign man_supplement = |y_3[11:8] ?   1'b1 : 1'b0;

logic[6:0] o_lzd_out; 
logic o_lzd_zero_all;
logic[63:0] o_final_man_mid_fix;
logic[22:0] o_final_man;

leading_zero_detect64 lzd_final(
                            .i_lzd_in(x_3),
                            //
                            .o_lzd_out(o_lzd_out),
                            .o_zero_all(o_lzd_zero_all)
);

assign  o_final_man_mid_fix = o_lzd_zero_all ?  64'h0 : (x_3 << o_lzd_out);


logic round_en;
//logic[31:0] shift_value;
//logic shift_l;
//logic shift_g;
//logic shift_r;
//logic shift_s;
logic shift_l_fix;
logic shift_g_fix;
logic shift_r_fix;
logic shift_s_fix;

//assign shift_value = o_exp_real_pos_en ? o_final_man_mid_fix[63:32] << o_exp_real : 24'h00_0000;
//assign shift_l = shift_value[31];
//assign shift_g = shift_value[30];
//assign shift_r = shift_value[29];
//assign shift_s = |shift_value[28:0];
assign shift_l_fix = o_final_man_mid_fix[40];
assign shift_g_fix = o_final_man_mid_fix[39];
assign shift_r_fix = o_final_man_mid_fix[38];
assign shift_s_fix = |o_final_man_mid_fix[37:0];



logic      o_exp_real_pos_en_ex2;
logic[7:0] o_exp_real_ex2;       
logic      table_en_ex2;
logic      i_sqrt_en_ex2;
logic      o_exp_real_pos_en_ex3;
logic[7:0] o_exp_real_ex3;       
logic      table_en_ex3;
logic      i_sqrt_en_ex3;
logic      o_exp_real_pos_en_ex4;
logic[7:0] o_exp_real_ex4;       
logic      table_en_ex4;
logic      i_sqrt_en_ex4;
logic      o_exp_real_pos_en_ex5;
logic[7:0] o_exp_real_ex5;       
logic      table_en_ex5;
logic      i_sqrt_en_ex5;


//ex2
always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin  
    o_exp_real_pos_en_ex2 <= 1'b0;
    o_exp_real_ex2        <= 8'h00;
    table_en_ex2          <= 1'b0;
    i_sqrt_en_ex2         <= 1'b0;
  end
  else if(!i_bus_stall_en)begin
    o_exp_real_pos_en_ex2 <=     o_exp_real_pos_en ;
    o_exp_real_ex2        <=     o_exp_real        ;
    table_en_ex2          <=     table_en          ;
    i_sqrt_en_ex2         <=     i_sqrt_en         ;   
  end
end

//ex3
always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin  
    o_exp_real_pos_en_ex3 <= 1'b0;
    o_exp_real_ex3        <= 8'h00;
    table_en_ex3          <= 1'b0;
    i_sqrt_en_ex3         <= 1'b0;
  end
  else if(!i_bus_stall_en)begin
    o_exp_real_pos_en_ex3 <=     o_exp_real_pos_en_ex2 ;
    o_exp_real_ex3        <=     o_exp_real_ex2        ;
    table_en_ex3          <=     table_en_ex2          ;
    i_sqrt_en_ex3         <=     i_sqrt_en_ex2         ;   
  end
end

//ex4
always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin  
    o_exp_real_pos_en_ex4 <= 1'b0;
    o_exp_real_ex4        <= 8'h00;
    table_en_ex4          <= 1'b0;
    i_sqrt_en_ex4         <= 1'b0;
  end
  else if(!i_bus_stall_en)begin
    o_exp_real_pos_en_ex4 <=     o_exp_real_pos_en_ex3 ;
    o_exp_real_ex4        <=     o_exp_real_ex3        ;
    table_en_ex4          <=     table_en_ex3          ;
    i_sqrt_en_ex4         <=     i_sqrt_en_ex3         ;   
  end
end

//ex5
always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin  
    o_exp_real_pos_en_ex5 <= 1'b0;
    o_exp_real_ex5        <= 8'h00;
    table_en_ex5          <= 1'b0;
    i_sqrt_en_ex5         <= 1'b0;
  end
  else if(!i_bus_stall_en)begin
    o_exp_real_pos_en_ex5 <=     o_exp_real_pos_en_ex4 ;
    o_exp_real_ex5        <=     o_exp_real_ex4        ;
    table_en_ex5          <=     table_en_ex4          ;
    i_sqrt_en_ex5         <=     i_sqrt_en_ex4         ;   
  end
end



always_comb begin
    if(o_exp_real_pos_en_ex5)begin
      if(o_exp_real_ex5 == 5'd23)begin
        if(shift_g_fix && (shift_r_fix || shift_s_fix))
          round_en = 1'b1;
        else if(shift_g_fix && shift_l_fix)
          round_en = 1'b1;
        else
          round_en = 1'b0;
      end
      else if(o_exp_real_ex5 > 5'd23)begin
        if(shift_g_fix && (shift_r_fix||shift_s_fix))
          round_en = 1'b1;
        else if(shift_g_fix && shift_l_fix)
          round_en = 1'b1;
        else
          round_en = 1'b0;
      end
      else if(o_exp_real_ex5 < 5'd23)begin
        if(shift_g_fix && (shift_r_fix||shift_s_fix))
          round_en = 1'b1;
        else if(shift_g_fix && shift_l_fix)
          round_en = 1'b1;
        else
          round_en = 1'b0;
      end
      else
        round_en = 1'b0;
    end
    else begin
      //if(o_exp_real < 5'd23)begin
        if(shift_g_fix && (shift_r_fix||shift_s_fix))
          round_en = 1'b1;
        else if(shift_g_fix && shift_l_fix)
          round_en = 1'b1;
        else
          round_en = 1'b0;
      //end
      //else 
      //  round_en  = 1'b0;
    end
end

assign  o_final_man = o_final_man_mid_fix[62:40] + round_en + man_supplement_ex1;
   
always_comb begin
  if(i_sqrt_en_ex5)begin
    if(~table_en_ex5)
       o_result = {o_sp_sign_ex5,o_sp_exp_ex5[7:0],o_sp_man_ex5[22:0]};
    else 
        o_result = {o_final_sign_ex5,o_final_exp_ex5,o_final_man}; 
  end
  else 
    o_result = 32'h0000_0000;
end


//always@(posedge i_clk or negedge i_reset_n)begin
//  if(!i_reset_n)
//    o_result_ex1 <= 32'h0;
//  else 
//    o_result_ex1 <= o_result;
//end
//
//always@(posedge i_clk or negedge i_reset_n)begin
//  if(!i_reset_n)
//    o_lvf_ex1 <= 1'b0;
//  else 
//    o_lvf_ex1 <= o_lvf;
//end




endmodule