//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: tmu_decoder.sv
//  Creating Date: Wed 20 Dec 2023 06:26:47 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Wed 27 Mar 2024 04:45:09 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

`define TMU_LABEL         12'he27
module tmu_decoder(
                        input logic i_clk,
                        input logic i_reset_n,
                        input logic i_bus_stall_en,
                        input logic i_d2_tmu_decoder_en,
                        input logic[31:0] i_d2_opcode,
                        input logic i_d2_tmu_instruction16_en,
                        //input logic[31:0] i_reg_rb,
                        //input logic[21:0] i_reg_pc,
                        input logic i_rpt_data_notzero,
                        //output
                        //r_id
                        output logic[2:0] o_r_op_id1,
                        output logic      o_r_op_id1_valid,
                        output logic[2:0] o_r_op_id2,
                        output logic      o_r_op_id2_valid,
                        //w_id
                        output logic[2:0] o_w_op_id1,
                        output logic[2:0] o_w_op_id2,
                        //op_selec
                        output logic o_illegal_en,
                        output logic o_rpt_clear_en,
                        //output logic o_rptb_tmu_rc_dec_en,
                        output logic o_mul_const_en,
                        output logic o_div_const_en,
                        output logic o_div_en,
                        output logic o_sqrt_en,
                        output logic o_sin_en,
                        output logic o_cos_en,
                        output logic o_atan_en,
                        output logic o_quadf_en
                        //output logic o_exp_en,
                        //output logic o_log_en,            
);

//signals for test
`ifdef UVM_TEST
logic double_inst_flg;
logic quatra_inst_flg;
logic penta_inst_flg;
`endif

//logic i_tmu_decoder_en;
logic[31:0] i_opcode;
logic i_tmu_instruction16_en;

always @(posedge i_clk or negedge i_reset_n) begin
    if(!i_reset_n)begin
        i_opcode                   <=   32'h0000_0000;
        //i_tmu_decoder_en           <=   1'b0;
        i_tmu_instruction16_en     <=   1'b0;
    end
    else if(i_bus_stall_en || i_d2_tmu_decoder_en)begin
        i_opcode                   <=   i_opcode;
        //i_tmu_decoder_en           <=   i_d2_tmu_decoder_en;
        i_tmu_instruction16_en     <=   i_tmu_instruction16_en;
    end
    else begin
        i_opcode                   <=   i_d2_opcode;
        i_tmu_instruction16_en     <=   i_d2_tmu_instruction16_en;
    end
end

//always_comb begin
//  o_rptb_tmu_rc_dec_en = 1'b0;
//  if(i_reg_rb[30] && (i_reg_pc[6:0] == i_reg_rb[22:16]))
//    o_rptb_tmu_rc_dec_en = 1'b1;
//  else 
//    o_rptb_tmu_rc_dec_en = 1'b0;  
//end


assign o_rpt_clear_en = i_rpt_data_notzero & (~o_illegal_en);


always_comb begin
    `ifdef UVM_TEST
    double_inst_flg  =    1'b0;
    quatra_inst_flg  =    1'b0;
    penta_inst_flg   =    1'b0;
    `endif    
    o_r_op_id1       =    3'b0;
    o_r_op_id1_valid =    1'b0;
    o_r_op_id2       =    3'b0;
    o_r_op_id2_valid =    1'b0;
    o_w_op_id1       =    3'b0;
    o_w_op_id2       =    3'b0;
    o_illegal_en     =    1'b1; 
    o_mul_const_en   =    1'b0;
    o_div_const_en   =    1'b0;
    o_div_en         =    1'b0;
    o_sqrt_en        =    1'b0; 
    o_sin_en         =    1'b0; 
    o_cos_en         =    1'b0;
    o_atan_en        =    1'b0; 
    o_quadf_en       =    1'b0;
    //o_exp_en         =    1'b0;
    //o_log_en         =    1'b0;   
    if(~i_tmu_instruction16_en) begin
        if(i_opcode[31:20] == `TMU_LABEL)begin        
            case (i_opcode[19:16])
                4'b0000:begin
                    if(~|i_opcode[15:6])begin                                  //mpy2pif32
                        `ifdef UVM_TEST
                        double_inst_flg = 1'b1;
                        `endif
                        o_mul_const_en  =  1'b1;
                        o_r_op_id1      =  i_opcode[5:3];
                        o_r_op_id1_valid=  1'b1; 
                        o_w_op_id1      =  i_opcode[2:0];
                        o_illegal_en    = 1'b0;
                    end
                    else
                        o_illegal_en    = 1'b1;
                end
                4'b0001:begin                                                 //div2pif32
                    if(~|i_opcode[15:6])begin                        
                        `ifdef UVM_TEST
                        double_inst_flg = 1'b1;
                        `endif                        
                        o_div_const_en  =  1'b1;
                        o_r_op_id1      =  i_opcode[5:3];
                        o_r_op_id1_valid=  1'b1;
                        o_w_op_id1      =  i_opcode[2:0];
                        o_illegal_en    = 1'b0;
                    end
                    else 
                        o_illegal_en    =  1'b1;
                end
                4'b0010:begin
                    //if(~|i_opcode[15:6])begin
                    //    o_log_en        =  1'b1;
                    //    o_r_op_id1      =  i_opcode[5:3];
                    //    o_r_op_id1_valid=  1'b1;
                    //    o_w_op_id1      =  i_opcode[2:0];
                    //end
                    //else
                    //    o_illegal_en    =  1'b1;
                    o_illegal_en = 1'b1;
                end
                4'b0011:begin
                    //if(~|i_opcode[15:6])begin
                    //    o_exp_en       =   1'b1;
                    //    o_r_op_id1     =   i_opcode[5:3];
                    //    o_r_op_id1_valid=  1'b1;
                    //    o_w_op_id1     =   i_opcode[2:0];
                    //end
                    //else
                    //    o_illegal_en   =   1'b1;
                    o_illegal_en = 1'b1;
                end
                4'b0100:begin                                                 //divf32              
                    if(~|i_opcode[15:9])begin
                        `ifdef UVM_TEST
                        penta_inst_flg = 1'b1;
                        `endif
                        o_div_en      =    1'b1;
                        o_r_op_id1    =    i_opcode[5:3];
                        o_r_op_id1_valid=  1'b1;
                        o_r_op_id2    =    i_opcode[8:6];
                        o_r_op_id2_valid = 1'b1;
                        o_w_op_id1    =    i_opcode[2:0];
                        o_illegal_en    = 1'b0;
                    end
                    else 
                        o_illegal_en  =    1'b1;
                end
                4'b0111:begin                                                 //sqrtf32
                    if(~|i_opcode[15:6])begin
                        `ifdef UVM_TEST
                        penta_inst_flg = 1'b1;
                        `endif                        
                        o_sqrt_en     =   1'b1;
                        o_r_op_id1    =   i_opcode[5:3];
                        o_r_op_id1_valid=  1'b1;
                        o_w_op_id1    =   i_opcode[2:0];
                        o_illegal_en    = 1'b0;
                    end
                    else 
                        o_illegal_en  =   1'b1;
                end
                4'b1000:begin                                                 //sin
                    if(~|i_opcode[15:6])begin
                        `ifdef UVM_TEST
                        quatra_inst_flg = 1'b1;
                        `endif                      
                        o_sin_en     =   1'b1;  
                        o_r_op_id1   =   i_opcode[5:3];
                        o_r_op_id1_valid=  1'b1;
                        o_w_op_id1   =   i_opcode[2:0];
                        o_illegal_en    = 1'b0;  
                    end
                    else 
                        o_illegal_en  =  1'b1;
                end
                4'b1001:begin                                                 //cos
                    if(~|i_opcode[15:6])begin
                        `ifdef UVM_TEST
                        quatra_inst_flg = 1'b1;
                        `endif                      
                        o_cos_en     =  1'b1;
                        o_r_op_id1   =  i_opcode[5:3]; 
                        o_r_op_id1_valid=  1'b1;
                        o_w_op_id1   =  i_opcode[2:0];
                        o_illegal_en    = 1'b0;
                    end
                    else
                        o_illegal_en  =  1'b1;
                end
                4'b1010:begin                                                 //atan
                    if(~|i_opcode[15:6])begin
                        `ifdef UVM_TEST
                        quatra_inst_flg = 1'b1;
                        `endif                      
                        o_atan_en   =   1'b1;
                        o_r_op_id1  =   i_opcode[5:3];
                        o_r_op_id1_valid=  1'b1;
                        o_w_op_id1  =   i_opcode[2:0];
                        o_illegal_en    = 1'b0;
                    end
                    else 
                        o_illegal_en  = 1'b1;
                end
                4'b1100:begin                                                 //quadf32
                    if(~|i_opcode[15:12])begin
                        `ifdef UVM_TEST
                        penta_inst_flg = 1'b1;
                        `endif                      
                        o_quadf_en    =  1'b1;
                        o_r_op_id1    =  i_opcode[11:9]; 
                        o_r_op_id1_valid =  1'b1; 
                        o_r_op_id2    =  i_opcode[8:6];
                        o_r_op_id2_valid = 1'b1;
                        o_w_op_id1    =  i_opcode[5:3];
                        o_w_op_id2    =  i_opcode[2:0];
                        o_illegal_en    = 1'b0;
                    end
                    else 
                        o_illegal_en  = 1'b1;
                end 
                default: 
                        o_illegal_en  = 1'b1;
            endcase
        end
        else begin
          `ifdef UVM_TEST
          double_inst_flg      =    1'b0;
          quatra_inst_flg      =    1'b0;
          penta_inst_flg       =    1'b0;
          `endif           
          o_illegal_en         =    1'b1;
          o_mul_const_en       =    1'b0;
          o_div_const_en       =    1'b0;
          o_div_en             =    1'b0;
          o_sqrt_en            =    1'b0;
          o_sin_en             =    1'b0;
          o_cos_en             =    1'b0;
          o_atan_en            =    1'b0;
          o_quadf_en           =    1'b0;
          //o_exp_en             =    1'b0;
          //o_log_en             =    1'b0;
          o_r_op_id1           =    3'b0;
          o_r_op_id1_valid     =    1'b0;
          o_r_op_id2           =    3'b0;
          o_r_op_id2_valid     =    1'b0;
          o_w_op_id1           =    3'b0;
          o_w_op_id2           =    3'b0;
        end
    end
    else begin
      `ifdef UVM_TEST                  
      double_inst_flg      =    1'b0;  
      quatra_inst_flg      =    1'b0;  
      penta_inst_flg       =    1'b0;  
      `endif                           
      o_illegal_en         =    1'b1;  
      o_mul_const_en       =    1'b0;  
      o_div_const_en       =    1'b0;  
      o_div_en             =    1'b0;  
      o_sqrt_en            =    1'b0;  
      o_sin_en             =    1'b0;  
      o_cos_en             =    1'b0;  
      o_atan_en            =    1'b0;  
      o_quadf_en           =    1'b0;  
      //o_exp_en             =    1'b0;
      //o_log_en             =    1'b0;
      o_r_op_id1           =    3'b0;  
      o_r_op_id1_valid     =    1'b0;  
      o_r_op_id2           =    3'b0;  
      o_r_op_id2_valid     =    1'b0;  
      o_w_op_id1           =    3'b0;  
      o_w_op_id2           =    3'b0;  
    end
end
    
endmodule


`undef TMU_LABEL