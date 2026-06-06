//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: tmu_top.sv
//  Creating Date: Fri 12 Jan 2024 03:45:27 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 09 May 2024 10:05:39 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module tmu_top#(
                 parameter TPIE            =       32'h40c90fdb,
                 parameter EINVF_TPIE      =       32'h3e22f983
)
(
                 input logic        i_clk, 
                 input logic        i_reset_n,
                 input logic        i_bus_stall_en,
                 input logic        i_d2_tmu_decoder_en,
                 input logic        i_intr_oprun,
                 input logic        i_intr_stall,
                 input logic        i_d2_tmu_instruction16_en,
                 input logic[31:0]  i_opcode,
                 input logic        i_rpt_data_notzero,
                 //reg
                 input logic[31:0]  i_reg_stf,
                 //input logic[31:0]  i_reg_rb,
                 //input logic[21:0]  i_reg_pc,
                 input logic[31:0]  i_reg_data1,
                 input logic[31:0]  i_reg_data2,
                 //output port
                 output logic       o_illegal_en,
                 output logic       o_rpt_clear_en,
                 //output logic       o_rptb_tmu_rc_dec_en,                 
                 output logic[5:0]  o_tmu2regf_rselection_id1,
                 output logic       o_tmu2regf_rselection_id1_valid,     
                 output logic[5:0]  o_tmu2regf_rselection_id2,
                 output logic       o_tmu2regf_rselection_id2_valid,
                 //
                 output logic[31:0] o_tmu2bus_wdata1, 
                 output logic[5:0]  o_tmu2bus_id1,
                 output logic       o_tmu2bus_en1,    
                 output logic[31:0] o_tmu2bus_wdata2,
                 output logic[5:0]  o_tmu2bus_id2,
                 output logic       o_tmu2bus_en2,
                 output logic[31:0] o_tmu2bus_wdata3,
                 output logic[5:0]  o_tmu2bus_id3,
                 output logic       o_tmu2bus_en3,
                 output logic[31:0] o_tmu2bus_wdata4,
                 output logic[5:0]  o_tmu2bus_id4,
                 output logic       o_tmu2bus_en4,
                 output logic       o_reg_lvf,
                 output logic       o_reg_lvf_en,
                 output logic       o_reg_luf,
                 output logic       o_reg_luf_en
);

logic[2:0] o_mid_r_op_id1;      
logic      o_mid_r_op_id1_valid;
logic[2:0] o_mid_r_op_id2;      
logic      o_mid_r_op_id2_valid;
logic[2:0] o_mid_w_op_id1;
logic[2:0] o_mid_w_op_id2;
logic      o_mid_mul_const_en;
logic      o_mid_div_const_en;
logic      o_mid_div_en;
logic      o_mid_sqrt_en;
logic      o_mid_sin_en;
logic      o_mid_cos_en;
logic      o_mid_atan_en;
logic      o_mid_quadf_en;

tmu_decoder decoder(      
              .i_clk(i_clk),
              .i_reset_n(i_reset_n),
              .i_bus_stall_en(i_bus_stall_en),
              .i_d2_tmu_decoder_en(i_d2_tmu_decoder_en),
              .i_d2_opcode(i_opcode),
              .i_d2_tmu_instruction16_en(i_d2_tmu_instruction16_en),
              //.i_reg_rb(i_reg_rb),
              //.i_reg_pc(i_reg_pc),
              .i_rpt_data_notzero(i_rpt_data_notzero),
              //output 
              .o_illegal_en(o_illegal_en),
              .o_rpt_clear_en(o_rpt_clear_en),
              .o_r_op_id1(o_mid_r_op_id1),
              .o_r_op_id1_valid(o_mid_r_op_id1_valid),
              .o_r_op_id2(o_mid_r_op_id2),      
              .o_r_op_id2_valid(o_mid_r_op_id2_valid),
              .o_w_op_id1(o_mid_w_op_id1),
              .o_w_op_id2(o_mid_w_op_id2),
              //.o_rptb_tmu_rc_dec_en(o_rptb_tmu_rc_dec_en),
              .o_mul_const_en(o_mid_mul_const_en),
              .o_div_const_en(o_mid_div_const_en),
              .o_div_en(o_mid_div_en), 
              .o_sqrt_en(o_mid_sqrt_en),
              .o_sin_en(o_mid_sin_en), 
              .o_cos_en(o_mid_cos_en), 
              .o_atan_en(o_mid_atan_en),
              .o_quadf_en(o_mid_quadf_en)
); 


logic[5:0] o_wdataselect_id1_mid;
logic[5:0] o_wdataselect_id2_mid;
logic      o_mul_const_en_mid;
logic      o_div_const_en_mid;
logic      o_div_en_mid;
logic      o_sqrt_en_mid;
logic      o_sin_en_mid;
logic      o_cos_en_mid;
logic      o_atan_en_mid;
logic      o_quadf_en_mid;

tmu_read read(
           .i_clk(i_clk),
           .i_reset_n(i_reset_n),
           .i_bus_stall_en(i_bus_stall_en),
           .i_idu_stall(i_d2_tmu_decoder_en),
           .i_intr_oprun(i_intr_oprun),
           .i_intr_stall(i_intr_stall),
           //
           .i_r_op_id1(o_mid_r_op_id1),
           .i_r_op_id1_valid(o_mid_r_op_id1_valid),
           .i_r_op_id2(o_mid_r_op_id2),      
           .i_r_op_id2_valid(o_mid_r_op_id2_valid),
           .i_w_op_id1(o_mid_w_op_id1),      
           .i_w_op_id2(o_mid_w_op_id2),      
           .i_mul_const_en(o_mid_mul_const_en),  
           .i_div_const_en(o_mid_div_const_en),  
           .i_div_en(o_mid_div_en),        
           .i_sqrt_en(o_mid_sqrt_en),       
           .i_sin_en(o_mid_sin_en),        
           .i_cos_en(o_mid_cos_en),        
           .i_atan_en(o_mid_atan_en),       
           .i_quadf_en(o_mid_quadf_en),
           //
           .o_tmu_to_regfile_rselection_id1(o_tmu2regf_rselection_id1),      
           .o_tmu_to_regfile_rselection_id1_valid(o_tmu2regf_rselection_id1_valid),
           .o_tmu_to_regfile_rselection_id2(o_tmu2regf_rselection_id2),      
           .o_tmu_to_regfile_rselection_id2_valid(o_tmu2regf_rselection_id2_valid),
           .o_wdataselect_id1(o_wdataselect_id1_mid),                    
           .o_wdataselect_id2(o_wdataselect_id2_mid),                    
           .o_mul_const_en(o_mul_const_en_mid),                       
           .o_div_const_en(o_div_const_en_mid),                       
           .o_div_en(o_div_en_mid),                             
           .o_sqrt_en(o_sqrt_en_mid),                            
           .o_sin_en(o_sin_en_mid),                             
           .o_cos_en(o_cos_en_mid),                             
           .o_atan_en(o_atan_en_mid),                            
           .o_quadf_en(o_quadf_en_mid)                           
);  



tmu_alu_top#(
                  .TPIE(TPIE),
                  .EINVF_TPIE(EINVF_TPIE)
)
alu(
                  .i_clk(i_clk),                 
                  .i_reset_n(i_reset_n),            
                  .i_bus_stall_en(i_bus_stall_en),       
                  .i_reg_stf(i_reg_stf),      
                  .i_reg_data1(i_reg_data1),    
                  .i_reg_data2(i_reg_data2),    
                  .i_wdataselect_id1(o_wdataselect_id1_mid),
                  .i_wdataselect_id2(o_wdataselect_id2_mid),
                  .i_mul_const_en(o_mul_const_en_mid),       
                  .i_div_const_en(o_div_const_en_mid),       
                  .i_div_en(o_div_en_mid),             
                  .i_sqrt_en(o_sqrt_en_mid),            
                  .i_sin_en(o_sin_en_mid),             
                  .i_cos_en(o_cos_en_mid),             
                  .i_atan_en(o_atan_en_mid),            
                  .i_quadf_en(o_quadf_en_mid),
                  //
                  .o_w_id1(o_tmu2bus_id1),    
                  //o_w_data1(o_tmu2bus_wdata1),  
                  .o_wdata1(o_tmu2bus_wdata1),
                  .o_reg1_wen(o_tmu2bus_en1), 
                  .o_w_id2(o_tmu2bus_id2),    
                  //.o_w_data2(o_tmu2bus_wdata2),  
                  .o_wdata2(o_tmu2bus_wdata2),
                  .o_reg2_wen(o_tmu2bus_en2), 
                  .o_w_id3(o_tmu2bus_id3),    
                  //.o_w_data3(o_tmu2bus_wdata3),  
                  .o_wdata3(o_tmu2bus_wdata3),
                  .o_reg3_wen(o_tmu2bus_en3), 
                  .o_w_id4(o_tmu2bus_id4),    
                  .o_wdata4(o_tmu2bus_wdata4),   
                  .o_reg4_wen(o_tmu2bus_en4), 
                  .o_reg_lvf(o_reg_lvf),  
                  .o_reg_lvf_en(o_reg_lvf_en),
                  .o_reg_luf(o_reg_luf),  
                  .o_reg_luf_en(o_reg_luf_en)
);
          


endmodule