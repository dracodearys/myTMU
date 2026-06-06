//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: tmu_alu_top.sv
//  Creating Date: Wed 20 Dec 2023 06:32:29 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Fri 19 Jul 2024 11:00:53 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module tmu_alu_top#(
                     parameter TPIE            =        32'h40c90fdb,
                     parameter EINVF_TPIE      =        32'h3e22f983
) 
(
                        input logic i_clk,
                        input logic i_reset_n,
                        input logic i_bus_stall_en,
                        input logic[31:0] i_reg_stf,
                        input logic[31:0] i_reg_data1,
                        input logic[31:0] i_reg_data2,
                        input logic[5:0] i_wdataselect_id1,
                        input logic[5:0] i_wdataselect_id2,
                        input logic i_mul_const_en,
                        input logic i_div_const_en,
                        input logic i_div_en,
                        input logic i_sqrt_en,
                        input logic i_sin_en,
                        input logic i_cos_en,
                        input logic i_atan_en,
                        input logic i_quadf_en,
                        //input logic i_exp_en,
                        //input logic i_log_en,      
                        //
                        output logic[5:0]  o_w_id1,
                        //output logic[31:0] o_w_data1, 
                        output logic[31:0] o_wdata1,
                        output logic       o_reg1_wen,
                        output logic[5:0]  o_w_id2,
                        //output logic[31:0] o_w_data2,
                        output logic[31:0] o_wdata2,
                        output logic       o_reg2_wen,
                        output logic[5:0]  o_w_id3,
                        //output logic[31:0] o_w_data3,
                        output logic[31:0] o_wdata3,
                        output logic       o_reg3_wen,
                        output logic[5:0]  o_w_id4,
                        output logic[31:0] o_wdata4,
                        output logic       o_reg4_wen,
                        output logic       o_reg_lvf,
                        output logic       o_reg_lvf_en,
                        output logic       o_reg_luf,
                        output logic       o_reg_luf_en
);


logic[31:0] op1;
logic[31:0] op2;
logic rnd;
logic[31:0] const_selection;
logic[31:0] mul_const_out;
logic[31:0] div_const_out;
logic[31:0] div_out;
logic[31:0] sqrt_out;
logic[31:0] sin_out;
logic[31:0] cos_out;
logic[31:0] atan_out;
logic[31:0] quadf_out1;
logic[31:0] quadf_out2;
logic[31:0] exp_out;
logic[31:0] log_out;
logic o_wen1;
logic o_wen2;

logic block_enable;
logic single_op_en_rnd;
logic single_op_en_urnd;
 
assign block_enable= i_mul_const_en || i_div_const_en || i_div_en || i_sqrt_en || i_sin_en || i_cos_en  || i_atan_en || i_quadf_en; // || i_exp_en || i_log_en;
assign single_op_en_urnd =  i_sqrt_en || i_sin_en || i_cos_en || i_atan_en; // || i_exp_en || i_log_en; 
assign single_op_en_rnd = i_mul_const_en || i_div_const_en;

always_comb begin
    //o_w_id1       =   6'h00; 
    //o_w_data1     =   32'h0000_0000;  
    //o_wdata1      =   32'h0000_0000;
    //o_reg1_wen    =   1'b0; 
    //o_w_id2       =   6'h00; 
    //o_w_data2     =   32'h0000_0000; 
    //o_wdata2      =   32'h0000_0000;
    //o_reg2_wen    =   1'b0;  
    //o_reg_lvf     =   1'b0;   
    //o_reg_lvf_en  =   1'b0;  
    //o_reg_luf     =   1'b0;
    //o_reg_luf_en  =   1'b0;
    op1             =   32'h0000_0000;
    op2             =   32'h0000_0000;
    rnd             =   1'b0;
    const_selection = 32'h0000_0000;
    if(~block_enable)begin
        op1    = 32'h0000_0000;
        op2    = 32'h0000_0000;
        //o_wen1  = 1'b0;
        //o_wen2  = 1'b0;
        //o_w_id1 = 6'h00; 
        //o_w_id2 = 6'h00;
    end
    else if(i_mul_const_en)begin
        op1    = i_reg_data1;
        //o_wen1  = 1'b1;
        //o_w_id1 = i_wdataselect_id1;
        rnd     = i_reg_stf[9];
        const_selection = TPIE;
    end
    else if(i_div_const_en)begin
        op1    = i_reg_data1;
        //o_wen1  = 1'b1;
        //o_w_id1 = i_wdataselect_id1;
        rnd     = i_reg_stf[9];  
        const_selection = EINVF_TPIE;
    end
    else if(single_op_en_urnd)begin
        op1    = i_reg_data1;
        //o_wen1  = 1'b1;
        //o_w_id1 = i_wdataselect_id1;
    end
    else if(i_div_en)begin
        op1    = i_reg_data1;
        op2    = i_reg_data2;
        //o_wen1 = 1'b1;
        //o_w_id1 = i_wdataselect_id1;
    end
    else if(i_quadf_en)begin
        op1   = i_reg_data1;
        //o_wen1 = 1'b1;
        //o_w_id1 = i_wdataselect_id1;
        op2   = i_reg_data2;
        //o_wen2 = 1'b1;
        //o_w_id2 = i_wdataselect_id2;
    end
end

logic[5:0] i_wdataselect_id1_ex2;
logic[5:0] i_wdataselect_id1_ex3;
logic[5:0] i_wdataselect_id1_ex4;
logic[5:0] i_wdataselect_id1_ex5;

logic[5:0] i_wdataselect_id2_ex2;
logic[5:0] i_wdataselect_id2_ex3;
logic[5:0] i_wdataselect_id2_ex4;
logic[5:0] i_wdataselect_id2_ex5;

//always@(posedge i_clk or negedge i_reset_n)begin
//  if(!i_reset_n)begin
//    i_wdataselect_id1_ex1 <= 6'h0;
//    i_wdataselect_id2_ex1 <= 6'h0;
//  end
//  else begin
//    i_wdataselect_id1_ex1 <= i_wdataselect_id1;
//    i_wdataselect_id2_ex1 <= i_wdataselect_id2;
//  end
//end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_wdataselect_id1_ex2 <= 6'h0;
    i_wdataselect_id2_ex2 <= 6'h0;
  end
  else begin
    i_wdataselect_id1_ex2 <= i_wdataselect_id1;
    i_wdataselect_id2_ex2 <= i_wdataselect_id2;
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_wdataselect_id1_ex3 <= 6'h0;
    i_wdataselect_id2_ex3 <= 6'h0;
  end
  else begin
    i_wdataselect_id1_ex3 <= i_wdataselect_id1_ex2;
    i_wdataselect_id2_ex3 <= i_wdataselect_id2_ex2;
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_wdataselect_id1_ex4 <= 6'h0;
    i_wdataselect_id2_ex4 <= 6'h0;
  end
  else begin
    i_wdataselect_id1_ex4 <= i_wdataselect_id1_ex3;
    i_wdataselect_id2_ex4 <= i_wdataselect_id2_ex3;
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_wdataselect_id1_ex5 <= 6'h0;
    i_wdataselect_id2_ex5 <= 6'h0;
  end
  else begin
    i_wdataselect_id1_ex5 <= i_wdataselect_id1_ex4;
    i_wdataselect_id2_ex5 <= i_wdataselect_id2_ex4;
  end
end

logic[31:0] tmu_mul_const_out;
logic mul_const_lvf;
logic mul_const_luf;
//
logic[31:0] tmu_divsion_out;
logic[31:0] tmu_quadf_out;
logic mul_division_quadf_lvf;
logic mul_division_quadf_luf;
//
logic[31:0] tmu_sqrt_out;
logic sqrt_lvf;
//
logic[31:0] tmu_poly_out;
logic poly_lvf;

tmu_mul_top mul_const(
                        .i_tmu_const_en(single_op_en_rnd),
                        .i_clk(i_clk),
                        .i_reset_n(i_reset_n),
                        .i_bus_stall_en(i_bus_stall_en),
                        .i_rm(op1),
                        .i_rn(const_selection),
                        .i_rnd32(rnd),
                        //
                        .o_ex2_result(tmu_mul_const_out),
                        .o_ex2_luf(mul_const_luf),
                        .o_ex2_lvf(mul_const_lvf)
);
//2p instrucation control signal
logic single_op_en_rnd_ex2;

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    single_op_en_rnd_ex2 <= 1'b0;
  end
  else begin
    single_op_en_rnd_ex2 <= single_op_en_rnd;
  end
end

tmu_division_quadf_top div(
                            .i_clk(i_clk),
                            .i_reset_n(i_reset_n),
                            .i_bus_stall_en(i_bus_stall_en),
                            .i_division_en(i_div_en),
                            .i_quadf_en(i_quadf_en),
                            .i_x(op1),
                            .i_y(op2),
                            //
                            .o_result(tmu_divsion_out),
                            .o_qu(tmu_quadf_out),
                            .o_lvf(mul_division_quadf_lvf),
                            .o_luf(mul_division_quadf_luf)
);
//5p instruction control signal
logic i_division_en_ex2;
logic i_division_en_ex3;
logic i_division_en_ex4;
logic i_division_en_ex5;
logic i_quadf_en_ex2;
logic i_quadf_en_ex3;
logic i_quadf_en_ex4;
logic i_quadf_en_ex5;

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_division_en_ex2 <= 1'b0;
    i_quadf_en_ex2    <= 1'b0;
  end
  else begin
    i_division_en_ex2 <= i_div_en;
    i_quadf_en_ex2    <= i_quadf_en;    
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_division_en_ex3 <= 1'b0;
    i_quadf_en_ex3    <= 1'b0;
  end
  else begin
    i_division_en_ex3 <= i_division_en_ex2;
    i_quadf_en_ex3    <= i_quadf_en_ex2;    
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_division_en_ex4 <= 1'b0;
    i_quadf_en_ex4    <= 1'b0;
  end
  else begin
    i_division_en_ex4 <= i_division_en_ex3;
    i_quadf_en_ex4    <= i_quadf_en_ex3;    
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    i_division_en_ex5 <= 1'b0;
    i_quadf_en_ex5    <= 1'b0;
  end
  else begin
    i_division_en_ex5 <= i_division_en_ex4;
    i_quadf_en_ex5    <= i_quadf_en_ex4;    
  end
end

//manual dff version
tmu_sqrt_cut sqrt(
                   .i_clk(i_clk),
                   .i_reset_n(i_reset_n),
                   .i_bus_stall_en(i_bus_stall_en),
                   .i_sqrt_en(i_sqrt_en),
                   .i_rm(op1),
                   //
                   .o_result(tmu_sqrt_out),
                   .o_lvf(sqrt_lvf)
);

//combination version
//tmu_sqrt_cut_comb sqrt(
//                   .i_sqrt_en(i_sqrt_en),
//                   .i_rm(op1),
//                   //
//                   .o_result(tmu_sqrt_out),
//                   .o_lvf(sqrt_lvf)
//);

tmu_multipoly_top poly(
                        .sys_clk(i_clk),
                        .sys_rst(i_reset_n),
                        .stall_en(i_bus_stall_en),
                        .sin_en(i_sin_en),
                        .cos_en(i_cos_en),
                        .atan_en(i_atan_en),
                        //.exp_en(i_exp_en),
                        //.log_en(i_log_en),
                        .float_x(op1),
                        //
                        .float_y(tmu_poly_out),
                        .lvf_flag(poly_lvf)
);

// urnd instruction signal control
logic single_op_en_urnd_ex2;
logic single_op_en_urnd_ex3;
logic single_op_en_urnd_ex4;
logic i_sqrt_en_ex2;
logic i_sqrt_en_ex3;
logic i_sqrt_en_ex4;
logic i_sqrt_en_ex5;
//logic single_op_en_urnd_ex5;

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    single_op_en_urnd_ex2 <= 1'b0;
    i_sqrt_en_ex2         <= 1'b0;
  end
  else begin    
    single_op_en_urnd_ex2 <= single_op_en_urnd;
    i_sqrt_en_ex2         <= i_sqrt_en;
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    single_op_en_urnd_ex3 <= 1'b0;
    i_sqrt_en_ex3         <= 1'b0;
  end
  else begin   
    single_op_en_urnd_ex3 <= single_op_en_urnd_ex2;
    i_sqrt_en_ex3         <= i_sqrt_en_ex2;
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n) begin
    single_op_en_urnd_ex4 <= 1'b0;
    i_sqrt_en_ex4         <= 1'b0;
  end
  else begin    
    single_op_en_urnd_ex4 <= single_op_en_urnd_ex3;
    i_sqrt_en_ex4         <= i_sqrt_en_ex3;
  end
end

always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)
    //single_op_en_urnd_ex5 <= 1'b0;
    i_sqrt_en_ex5         <= 1'b0;
  else    
    //single_op_en_urnd_ex5 <= single_op_en_urnd_ex4;
    i_sqrt_en_ex5         <= i_sqrt_en_ex4;
end


logic five_ex_en;
//logic four_ex_en;
//logic two_ex_en;

assign five_ex_en = i_division_en_ex5 || i_quadf_en_ex5 || i_sqrt_en_ex5; //single_op_en_urnd_ex5;
//assign four_ex_en = single_op_en_urnd_ex4;
//assign two_ex_en = single_op_en_rnd_ex2;


//output selection
always_comb begin
  o_w_id1      = 6'h00; 
  //o_w_data1    = 32'h0000_0000; 
  o_wdata1     = 32'h0000_0000;
  o_reg1_wen   = 1'b0; 
  o_w_id2      = 6'h00;         
  //o_w_data2    = 32'h0000_0000; 
  o_wdata2     = 32'h0000_0000;
  o_reg2_wen   = 1'b0;          
  o_w_id3      = 6'h00;        
  //o_w_data3    = 32'h0000_0000; 
  o_wdata3     = 32'h0000_0000;
  o_reg3_wen   = 1'b0;          
  o_w_id4      = 6'h00;        
  o_wdata4     = 32'h0000_0000;
  o_reg4_wen   = 1'b0;         
  o_reg_lvf    = 1'b0;
  o_reg_lvf_en = 1'b0;
  o_reg_luf    = 1'b0;
  o_reg_luf_en = 1'b0; 
  if(single_op_en_rnd_ex2 && ~single_op_en_urnd_ex4 && ~five_ex_en)begin             //mul_const
    o_w_id1      = i_wdataselect_id1_ex2;
    o_wdata1     = tmu_mul_const_out;
    //o_reg1_wen   = o_wen1_ex2;
    o_reg1_wen   = 1'b1;
    o_reg_lvf    = mul_const_lvf;
    o_reg_lvf_en = mul_const_lvf;     //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;   
    o_reg_luf    = mul_const_luf;
    o_reg_luf_en = mul_const_luf;    //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;
  end
  else if(single_op_en_rnd_ex2 && single_op_en_urnd_ex4 && ~five_ex_en)begin       //4ex instruction after 2 cycle follow 2ex instruction
    o_w_id1      =  i_wdataselect_id1_ex4;
    o_wdata1     =  tmu_poly_out;
    o_reg1_wen   =  1'b1;
    o_w_id2      =  i_wdataselect_id1_ex2;
    o_wdata2     =  tmu_mul_const_out;
    o_reg2_wen   =  1'b1;
    o_reg_lvf    =  mul_const_lvf | poly_lvf;   //(add poly lvf)
    o_reg_lvf_en =  mul_const_lvf | poly_lvf;   //(add poly lvf) due to the flag can not be clear by calculation type instruction(only can be written 1) 
    //o_reg_lvf_en =  1'b1;
    o_reg_luf    =  mul_const_luf;
    o_reg_luf_en =  mul_const_luf;   //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en =  1'b1;
  end
  else if(single_op_en_rnd_ex2 && ~single_op_en_urnd_ex4 && i_division_en_ex5)begin     //5ex(division) instruction after 3 cycle follow 2ex instruction
    o_w_id1      = i_wdataselect_id1_ex5; 
    o_wdata1     = tmu_divsion_out;
    o_reg1_wen   = 1'b1;
    //o_w_id2      = i_wdataselect_id2_ex2;
    o_w_id2      = i_wdataselect_id1_ex2;
    o_wdata2     = tmu_mul_const_out;
    o_reg2_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf | mul_const_lvf;
    o_reg_lvf_en = mul_division_quadf_lvf | mul_const_lvf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_division_quadf_luf | mul_const_luf;
    o_reg_luf_en = mul_division_quadf_luf | mul_const_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;    
  end
  else if(single_op_en_rnd_ex2 && ~single_op_en_urnd_ex4 && i_sqrt_en_ex5)begin    //5ex(sqrt) instruction after 3 cycle follow 2ex instruction(single_op_en_urnd_ex5)
    o_w_id1      = i_wdataselect_id1_ex5; 
    o_wdata1     = tmu_sqrt_out;
    o_reg1_wen   = 1'b1;
    //o_w_id2      = i_wdataselect_id2_ex2;
    o_w_id2      = i_wdataselect_id1_ex2;
    o_wdata2     = tmu_mul_const_out;
    o_reg2_wen   = 1'b1;
    o_reg_lvf    = sqrt_lvf | mul_const_lvf;
    o_reg_lvf_en = sqrt_lvf | mul_const_lvf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_const_luf;
    o_reg_luf_en = mul_const_luf;             //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;
  end
  else if(single_op_en_rnd_ex2 && ~single_op_en_urnd_ex4 && i_quadf_en_ex5)begin    //5ex(quadf) instruction after 3 cycle follow 2ex instruction
    o_w_id1      = i_wdataselect_id1_ex5; 
    o_wdata1     = tmu_divsion_out; 
    o_reg1_wen   = 1'b1; 
    o_w_id2      = i_wdataselect_id2_ex5; 
    o_wdata2     = tmu_quadf_out;
    o_reg2_wen   = 1'b1; 
    o_w_id3      = i_wdataselect_id1_ex2; 
    o_wdata3     = tmu_mul_const_out;
    o_reg3_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf | mul_const_lvf;
    o_reg_lvf_en = mul_division_quadf_lvf | mul_const_lvf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_division_quadf_luf | mul_const_luf;
    o_reg_luf_en = mul_division_quadf_luf | mul_const_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1) 
    //o_reg_luf_en = 1'b1;
  end
  else if(single_op_en_rnd_ex2 && single_op_en_urnd_ex4 && i_division_en_ex5)begin   //5ex(division) instruction after 1 cycle follow 4ex isntruction after 2cycle follow 2ex instruction
    o_w_id1      = i_wdataselect_id1_ex5;
    o_wdata1     = tmu_divsion_out;
    o_reg1_wen   = 1'b1;
    o_w_id2      = i_wdataselect_id1_ex4;
    o_wdata2     = tmu_poly_out;
    o_reg2_wen   = 1'b1;
    o_w_id3      = i_wdataselect_id1_ex2;
    o_wdata3     = tmu_mul_const_out;
    o_reg3_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf | mul_const_lvf; 
    o_reg_lvf_en = mul_division_quadf_lvf | mul_const_lvf; //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;   
    o_reg_luf    = mul_division_quadf_luf | mul_const_luf;
    o_reg_luf    = mul_division_quadf_luf | mul_const_luf; //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;   
  end
  else if(single_op_en_rnd_ex2 && single_op_en_urnd_ex4 && i_sqrt_en_ex5)begin   //5ex(sqrt) instruction after 1 cycle follow 4ex isntruction after 2cycle follow 2ex instruction(single_op_en_urnd_ex5)
   o_w_id1      = i_wdataselect_id1_ex5;
   o_wdata1     = tmu_sqrt_out;
   o_reg1_wen   = 1'b1;
   o_w_id2      = i_wdataselect_id1_ex4;
   o_wdata2     = tmu_poly_out;
   o_reg2_wen   = 1'b1;
   o_w_id3      = i_wdataselect_id1_ex2;
   o_wdata3     = tmu_mul_const_out;
   o_reg3_wen   = 1'b1;
   o_reg_lvf    = sqrt_lvf | mul_const_lvf | poly_lvf;  //(add poly lvf)
   o_reg_lvf_en = sqrt_lvf | mul_const_lvf | poly_lvf;  //(add poly lvf) due to the flag can not be clear by calculation type instruction(only can be written 1)
   //o_reg_lvf_en = 1'b1;   
   o_reg_luf    = mul_const_luf;
   o_reg_luf_en = mul_const_luf;             //due to the flag can not be clear by calculation type instruction(only can be written 1)
   //o_reg_luf_en = 1'b1;   
  end
  else if(single_op_en_rnd_ex2 && single_op_en_urnd_ex4 && i_quadf_en_ex5)begin   //5ex(quadf) instruction after 1 cycle follow 4ex isntruction after 2cycle follow 2ex instruction
    o_w_id1      = i_wdataselect_id1_ex5;
    o_wdata1     = tmu_divsion_out;
    o_reg1_wen   = 1'b1;
    o_w_id2      = i_wdataselect_id2_ex5;
    o_wdata2     = tmu_quadf_out;
    o_reg2_wen   = 1'b1;
    o_w_id3      = i_wdataselect_id1_ex4;
    o_wdata3     = tmu_poly_out;
    o_reg3_wen   = 1'b1;
    o_w_id4      = i_wdataselect_id1_ex2;
    o_wdata4     = tmu_mul_const_out;
    o_reg4_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf | mul_const_lvf | poly_lvf;  //(add poly lvf)
    o_reg_lvf_en = mul_division_quadf_lvf | mul_const_lvf | poly_lvf;  //(add poly lvf) due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_division_quadf_luf | mul_const_luf;
    o_reg_luf_en = mul_division_quadf_luf | mul_const_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;
  end
  else if(i_division_en_ex5 && ~single_op_en_rnd_ex2 && ~single_op_en_urnd_ex4)begin           //div
    o_w_id1      = i_wdataselect_id1_ex5;
    o_wdata1     = tmu_divsion_out;
    //o_reg1_wen   = o_wen1_ex5;
    o_reg1_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf;
    o_reg_lvf_en = mul_division_quadf_lvf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_division_quadf_luf;
    o_reg_luf_en = mul_division_quadf_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;
  end
  else if(i_quadf_en_ex5 && ~single_op_en_rnd_ex2 && ~single_op_en_urnd_ex4)begin             //quadf
    o_w_id1      = i_wdataselect_id1_ex5;
    o_wdata1     = tmu_divsion_out;
    //o_reg1_wen   = o_wen1_ex5;
    o_reg1_wen   = 1'b1;
    o_w_id2      = i_wdataselect_id2_ex5;
    o_wdata2     = tmu_quadf_out;
    //o_reg2_wen  = o_wen2_ex5;
    o_reg2_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf;
    o_reg_lvf_en = mul_division_quadf_lvf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_division_quadf_luf;
    o_reg_luf_en = mul_division_quadf_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;   
  end
  else if(i_sqrt_en_ex5 && ~single_op_en_rnd_ex2 && ~single_op_en_urnd_ex4)begin      //sqrt(single_op_en_urnd_ex5)
    o_w_id1      = i_wdataselect_id1_ex5;
    o_wdata1     = tmu_sqrt_out;
    //o_reg1_wen  = o_wen1_ex5;
    o_reg1_wen   = 1'b1;
    o_reg_lvf    = sqrt_lvf;
    o_reg_lvf_en = sqrt_lvf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
  end
  else if(single_op_en_urnd_ex4 && i_division_en_ex5 && ~single_op_en_rnd_ex2)begin    //5ex(division) instruction after 1 cycle follow 4ex instruction 
    o_w_id1      = i_wdataselect_id1_ex5; 
    o_wdata1     = tmu_divsion_out;
    o_reg1_wen   = 1'b1;
    o_w_id2      = i_wdataselect_id1_ex4;
    o_wdata2     = tmu_poly_out;
    o_reg2_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf | poly_lvf;  //(add poly lvf)
    o_reg_lvf_en = mul_division_quadf_lvf | poly_lvf;  //(add poly lvf) due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_division_quadf_luf; 
    o_reg_luf_en = mul_division_quadf_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;
  end
  //else if(single_op_en_urnd_ex4 && i_division_en_ex5 && ~single_op_en_rnd_ex2)begin    //5ex(sqrt) instruction after 1 cycle follow 4ex instruction 
  //  o_w_id1      = i_wdataselect_id1_ex5; 
  //  o_wdata1     = tmu_sqrt_out;
  //  o_reg1_wen   = 1'b1;
  //  o_w_id2      = i_wdataselect_id1_ex4;
  //  o_wdata2     = tmu_poly_out;
  //  o_reg2_wen   = 1'b1;
  //  o_reg_lvf    = mul_division_quadf_lvf | poly_lvf;  //(add poly lvf)
  //  o_reg_lvf_en = mul_division_quadf_lvf | poly_lvf;  //(add poly lvf) due to the flag can not be clear by calculation type instruction(only can be written 1)
  //  //o_reg_lvf_en = 1'b1;
  //  o_reg_luf    = mul_division_quadf_luf; 
  //  o_reg_luf_en = mul_division_quadf_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
  //  //o_reg_luf_en = 1'b1;
  //end
  else if(single_op_en_urnd_ex4 && i_sqrt_en_ex5 && ~single_op_en_rnd_ex2)begin    //5ex(sqrt) instruction after 1 cycle follow 4ex instruction 
    o_w_id1      = i_wdataselect_id1_ex5; 
    o_wdata1     = tmu_sqrt_out;
    o_reg1_wen   = 1'b1;
    o_w_id2      = i_wdataselect_id1_ex4;
    o_wdata2     = tmu_poly_out;
    o_reg2_wen   = 1'b1;
    o_reg_lvf    = sqrt_lvf | poly_lvf;  //(add poly lvf)
    o_reg_lvf_en = sqrt_lvf | poly_lvf;  //(add poly lvf) due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    //o_reg_luf    = mul_division_quadf_luf; 
    //o_reg_luf_en = mul_division_quadf_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;
  end
  else if(single_op_en_urnd_ex4 && i_quadf_en_ex5 && ~single_op_en_rnd_ex2)begin    //5ex(quad) instruction after 1 cycle follow 4ex instruction 
    o_w_id1      = i_wdataselect_id1_ex5; 
    o_wdata1     = tmu_divsion_out;
    o_reg1_wen   = 1'b1;
    o_w_id2      = i_wdataselect_id2_ex5;
    o_wdata2     = tmu_quadf_out;
    o_reg2_wen   = 1'b1;
    o_w_id3      = i_wdataselect_id1_ex4;
    o_wdata3     = tmu_poly_out;
    o_reg3_wen   = 1'b1;
    o_reg_lvf    = mul_division_quadf_lvf | poly_lvf;  //(add poly lvf)
    o_reg_lvf_en = mul_division_quadf_lvf | poly_lvf;  //(add poly lvf) due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_lvf_en = 1'b1;
    o_reg_luf    = mul_division_quadf_luf; 
    o_reg_luf_en = mul_division_quadf_luf;  //due to the flag can not be clear by calculation type instruction(only can be written 1)
    //o_reg_luf_en = 1'b1;
  end
  else if(single_op_en_urnd_ex4  && ~single_op_en_rnd_ex2 && ~i_sqrt_en_ex5 && ~i_sqrt_en_ex4)begin     //tri arith (single_op_en_urnd_ex5) increse i_sqrt_en_exd4 reason : find the sqrt also go throuth this path will write a wrong data
    o_w_id1      = i_wdataselect_id1_ex4;
    o_wdata1     = tmu_poly_out;
    //o_reg1_wen  = o_wen1_ex4;
    o_reg1_wen   = 1'b1;
    o_reg_lvf    = poly_lvf;  //(add poly lvf)
    o_reg_lvf_en = poly_lvf;  //(add poly lvf)
  end
end
endmodule 