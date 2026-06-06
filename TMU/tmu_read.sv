//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: tmu_read.sv
//  Creating Date: Thu 21 Dec 2023 01:20:13 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 09 May 2024 10:01:28 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module tmu_read (
                    input logic             i_clk,
                    input logic             i_reset_n,
                    input logic             i_bus_stall_en,
                    input logic             i_idu_stall,
                    input logic             i_intr_oprun,    //intr sysctrl signal(one more cycle than pipprotect stall)
                    input logic             i_intr_stall,    //intr sysctrl signal(one more cycle than pipprotect stall)
                    //
                    input logic[2:0]        i_r_op_id1,
                    input logic             i_r_op_id1_valid,
                    input logic[2:0]        i_r_op_id2,
                    input logic             i_r_op_id2_valid,
                    input logic[2:0]        i_w_op_id1,
                    input logic[2:0]        i_w_op_id2,
                    input logic             i_mul_const_en,
                    input logic             i_div_const_en,
                    input logic             i_div_en,
                    input logic             i_sqrt_en,
                    input logic             i_sin_en,
                    input logic             i_cos_en,
                    input logic             i_atan_en,
                    input logic             i_quadf_en,
                    //input logic             i_exp_en,
                    //input logic             i_log_en,         
                    //
                    output logic[5:0]       o_tmu_to_regfile_rselection_id1,              
                    output logic            o_tmu_to_regfile_rselection_id1_valid,       
                    output logic[5:0]       o_tmu_to_regfile_rselection_id2,                           
                    output logic            o_tmu_to_regfile_rselection_id2_valid,
                    output logic[5:0]       o_wdataselect_id1,
                    output logic[5:0]       o_wdataselect_id2,
                    output logic            o_mul_const_en,
                    output logic            o_div_const_en,
                    output logic            o_div_en,
                    output logic            o_sqrt_en,
                    output logic            o_sin_en,
                    output logic            o_cos_en,
                    output logic            o_atan_en,
                    output logic            o_quadf_en
                    //output logic            o_exp_en,
                    //output logic            o_log_en      
                                    
);

logic[2:0]        dffr1_r_op_id1     ;
logic             dffr1_r_op_id1_valid;
logic[2:0]        dffr1_r_op_id2     ;
logic             dffr1_r_op_id2_valid;
logic[2:0]        dffr1_w_op_id1     ;
logic[2:0]        dffr1_w_op_id2     ;
logic             dffr1_mul_const_en ;
logic             dffr1_div_const_en ;
logic             dffr1_div_en       ;
logic             dffr1_sqrt_en      ;
logic             dffr1_sin_en       ;
logic             dffr1_cos_en       ;
logic             dffr1_atan_en      ;
logic             dffr1_quadf_en     ;
//logic             dffr1_exp_en       ;
//logic             dffr1_log_en       ;     

//r1
//always @(posedge i_clk or negedge i_reset_n) begin   //old version
//    if(!i_reset_n)begin
//        dffr1_r_op_id1       <=    3'b000;
//        dffr1_r_op_id1_valid <=    1'b0;
//        dffr1_r_op_id2       <=    3'b000;
//        dffr1_r_op_id2_valid <=    1'b0;
//        dffr1_w_op_id1       <=    3'b000;
//        dffr1_w_op_id2       <=    3'b000;
//        dffr1_mul_const_en   <=    1'b0;
//        dffr1_div_const_en   <=    1'b0;
//        dffr1_div_en         <=    1'b0;
//        dffr1_sqrt_en        <=    1'b0;
//        dffr1_sin_en         <=    1'b0;
//        dffr1_cos_en         <=    1'b0;
//        dffr1_atan_en        <=    1'b0;
//        dffr1_quadf_en       <=    1'b0;
//        //dffr1_exp_en         <=    1'b0;
//        //dffr1_log_en         <=    1'b0; 
//    end
//    else if(~i_bus_stall_en) begin
//        dffr1_r_op_id1       <=    i_r_op_id1    ;
//        dffr1_r_op_id1_valid <=    i_r_op_id1_valid;
//        dffr1_r_op_id2       <=    i_r_op_id2    ;
//        dffr1_r_op_id2_valid <=    i_r_op_id2_valid;
//        dffr1_w_op_id1       <=    i_w_op_id1    ;
//        dffr1_w_op_id2       <=    i_w_op_id2    ;
//        dffr1_mul_const_en   <=    i_mul_const_en;
//        dffr1_div_const_en   <=    i_div_const_en;
//        dffr1_div_en         <=    i_div_en      ;
//        dffr1_sqrt_en        <=    i_sqrt_en     ;
//        dffr1_sin_en         <=    i_sin_en      ;
//        dffr1_cos_en         <=    i_cos_en      ;
//        dffr1_atan_en        <=    i_atan_en     ;
//        dffr1_quadf_en       <=    i_quadf_en    ;
//        //dffr1_exp_en         <=    i_exp_en      ;
//        //dffr1_log_en         <=    i_log_en      ;
//    end
//    
//end

always @(posedge i_clk or negedge i_reset_n) begin  
    if(!i_reset_n)begin                             
      dffr1_r_op_id1       <=    3'b000;          
      dffr1_r_op_id1_valid <=    1'b0;            
      dffr1_r_op_id2       <=    3'b000;          
      dffr1_r_op_id2_valid <=    1'b0;            
      dffr1_w_op_id1       <=    3'b000;          
      dffr1_w_op_id2       <=    3'b000;          
      dffr1_mul_const_en   <=    1'b0;            
      dffr1_div_const_en   <=    1'b0;            
      dffr1_div_en         <=    1'b0;            
      dffr1_sqrt_en        <=    1'b0;            
      dffr1_sin_en         <=    1'b0;            
      dffr1_cos_en         <=    1'b0;            
      dffr1_atan_en        <=    1'b0;            
      dffr1_quadf_en       <=    1'b0;            
      //dffr1_exp_en         <=    1'b0;          
      //dffr1_log_en         <=    1'b0;          
    end
    else if(i_bus_stall_en)begin
      dffr1_r_op_id1       <=    dffr1_r_op_id1      ;     
      dffr1_r_op_id1_valid <=    dffr1_r_op_id1_valid;
      dffr1_r_op_id2       <=    dffr1_r_op_id2      ;
      dffr1_r_op_id2_valid <=    dffr1_r_op_id2_valid;
      dffr1_w_op_id1       <=    dffr1_w_op_id1      ;
      dffr1_w_op_id2       <=    dffr1_w_op_id2      ;
      dffr1_mul_const_en   <=    dffr1_mul_const_en  ;
      dffr1_div_const_en   <=    dffr1_div_const_en  ;
      dffr1_div_en         <=    dffr1_div_en        ;
      dffr1_sqrt_en        <=    dffr1_sqrt_en       ;
      dffr1_sin_en         <=    dffr1_sin_en        ;
      dffr1_cos_en         <=    dffr1_cos_en        ;
      dffr1_atan_en        <=    dffr1_atan_en       ;
      dffr1_quadf_en       <=    dffr1_quadf_en      ;
    end
    else if(i_intr_oprun)begin
      dffr1_r_op_id1       <=    i_r_op_id1    ;  
      dffr1_r_op_id1_valid <=    i_r_op_id1_valid;
      dffr1_r_op_id2       <=    i_r_op_id2    ;  
      dffr1_r_op_id2_valid <=    i_r_op_id2_valid;
      dffr1_w_op_id1       <=    i_w_op_id1    ;  
      dffr1_w_op_id2       <=    i_w_op_id2    ;  
      dffr1_mul_const_en   <=    i_mul_const_en;  
      dffr1_div_const_en   <=    i_div_const_en;  
      dffr1_div_en         <=    i_div_en      ;  
      dffr1_sqrt_en        <=    i_sqrt_en     ;  
      dffr1_sin_en         <=    i_sin_en      ;  
      dffr1_cos_en         <=    i_cos_en      ;  
      dffr1_atan_en        <=    i_atan_en     ;  
      dffr1_quadf_en       <=    i_quadf_en    ;  
    end
    else if(i_idu_stall || i_intr_stall)begin
      dffr1_r_op_id1         <=  3'b000;
      dffr1_r_op_id1_valid   <=  1'b0;  
      dffr1_r_op_id2         <=  3'b000;
      dffr1_r_op_id2_valid   <=  1'b0;  
      dffr1_w_op_id1         <=  3'b000;
      dffr1_w_op_id2         <=  3'b000;
      dffr1_mul_const_en     <=  1'b0;  
      dffr1_div_const_en     <=  1'b0;  
      dffr1_div_en           <=  1'b0;  
      dffr1_sqrt_en          <=  1'b0;  
      dffr1_sin_en           <=  1'b0;  
      dffr1_cos_en           <=  1'b0;  
      dffr1_atan_en          <=  1'b0;  
      dffr1_quadf_en         <=  1'b0;  
    end    
    else begin                  
      dffr1_r_op_id1       <=    i_r_op_id1    ;  
      dffr1_r_op_id1_valid <=    i_r_op_id1_valid;
      dffr1_r_op_id2       <=    i_r_op_id2    ;  
      dffr1_r_op_id2_valid <=    i_r_op_id2_valid;
      dffr1_w_op_id1       <=    i_w_op_id1    ;  
      dffr1_w_op_id2       <=    i_w_op_id2    ;  
      dffr1_mul_const_en   <=    i_mul_const_en;  
      dffr1_div_const_en   <=    i_div_const_en;  
      dffr1_div_en         <=    i_div_en      ;  
      dffr1_sqrt_en        <=    i_sqrt_en     ;  
      dffr1_sin_en         <=    i_sin_en      ;  
      dffr1_cos_en         <=    i_cos_en      ;  
      dffr1_atan_en        <=    i_atan_en     ;  
      dffr1_quadf_en       <=    i_quadf_en    ;  
      //dffr1_exp_en         <=    i_exp_en      ;
      //dffr1_log_en         <=    i_log_en      ;
    end                                             
                                                    
end                                                 



logic[5:0] r_id1;
logic[5:0] r_id2;


always_comb begin
    case (dffr1_r_op_id1)
        3'b000: r_id1 = 6'h14;
        3'b001: r_id1 = 6'h15;  
        3'b010: r_id1 = 6'h16; 
        3'b011: r_id1 = 6'h17; 
        3'b100: r_id1 = 6'h18; 
        3'b101: r_id1 = 6'h19; 
        3'b110: r_id1 = 6'h1A; 
        3'b111: r_id1 = 6'h1B; 
    endcase
end

always_comb begin
    case (dffr1_r_op_id2)
        3'b000: r_id2 = 6'h14;
        3'b001: r_id2 = 6'h15;  
        3'b010: r_id2 = 6'h16; 
        3'b011: r_id2 = 6'h17; 
        3'b100: r_id2 = 6'h18; 
        3'b101: r_id2 = 6'h19; 
        3'b110: r_id2 = 6'h1A; 
        3'b111: r_id2 = 6'h1B;  
    endcase
end

logic[5:0] w_id1;
logic[5:0] w_id2;

always_comb begin
    case (dffr1_w_op_id1)
        3'b000: w_id1 = 6'h14;
        3'b001: w_id1 = 6'h15;  
        3'b010: w_id1 = 6'h16; 
        3'b011: w_id1 = 6'h17; 
        3'b100: w_id1 = 6'h18; 
        3'b101: w_id1 = 6'h19; 
        3'b110: w_id1 = 6'h1A; 
        3'b111: w_id1 = 6'h1B;  
    endcase
end

always_comb begin
    case (dffr1_w_op_id2)
        3'b000: w_id2 = 6'h14;
        3'b001: w_id2 = 6'h15;  
        3'b010: w_id2 = 6'h16; 
        3'b011: w_id2 = 6'h17; 
        3'b100: w_id2 = 6'h18; 
        3'b101: w_id2 = 6'h19; 
        3'b110: w_id2 = 6'h1A; 
        3'b111: w_id2 = 6'h1B;  
    endcase
end

logic[5:0] dffr2_r_id1;
logic dffr2_r_id1_valid;
logic[5:0] dffr2_r_id2;
logic dffr2_r_id2_valid;
logic[5:0] dffr2_w_id1;
logic[5:0] dffr2_w_id2;
logic dffr2_mul_const_en;
logic dffr2_div_const_en;
logic dffr2_div_en      ;
logic dffr2_sqrt_en     ;
logic dffr2_sin_en      ;
logic dffr2_cos_en      ;
logic dffr2_atan_en     ;
logic dffr2_quadf_en    ;
//logic dffr2_exp_en      ;
//logic dffr2_log_en      ;

//r2
always @(posedge i_clk or negedge i_reset_n ) begin
    if(!i_reset_n)begin
        dffr2_w_id1             <=  6'h00;
        dffr2_r_id1             <=  6'h00;
        dffr2_r_id1_valid       <=  1'b0;
        dffr2_w_id2             <=  6'h00;
        dffr2_r_id2             <=  6'h00;
        dffr2_r_id2_valid       <=  1'b0;
        dffr2_mul_const_en      <=  1'b0;
        dffr2_div_const_en      <=  1'b0;
        dffr2_div_en            <=  1'b0;
        dffr2_sqrt_en           <=  1'b0;
        dffr2_sin_en            <=  1'b0;
        dffr2_cos_en            <=  1'b0;
        dffr2_atan_en           <=  1'b0;
        dffr2_quadf_en          <=  1'b0;
        //dffr2_exp_en            <=  1'b0;
        //dffr2_log_en            <=  1'b0;
    end
    else if(~i_bus_stall_en)begin
        dffr2_r_id1             <=  r_id1;
        dffr2_r_id1_valid       <=  dffr1_r_op_id1_valid;
        dffr2_r_id2             <=  r_id2;
        dffr2_r_id2_valid       <=  dffr1_r_op_id2_valid;
        dffr2_w_id1             <=  w_id1;
        dffr2_w_id2             <=  w_id2;
        dffr2_mul_const_en      <=  dffr1_mul_const_en;
        dffr2_div_const_en      <=  dffr1_div_const_en;
        dffr2_div_en            <=  dffr1_div_en      ;
        dffr2_sqrt_en           <=  dffr1_sqrt_en     ;
        dffr2_sin_en            <=  dffr1_sin_en      ;
        dffr2_cos_en            <=  dffr1_cos_en      ;
        dffr2_atan_en           <=  dffr1_atan_en     ;
        dffr2_quadf_en          <=  dffr1_quadf_en    ;
        //dffr2_exp_en            <=  dffr1_exp_en      ;
        //dffr2_log_en            <=  dffr1_log_en      ;
    end
end


assign o_tmu_to_regfile_rselection_id1        =  dffr2_r_id1;      
assign o_tmu_to_regfile_rselection_id1_valid  =  dffr2_r_id1_valid;
assign o_tmu_to_regfile_rselection_id2        =  dffr2_r_id2;      
assign o_tmu_to_regfile_rselection_id2_valid  =  dffr2_r_id2_valid; 

//e1
logic[5:0] dffe1_w_id1;
logic[5:0] dffe1_w_id2;
logic dffe1_mul_const_en; 
logic dffe1_div_const_en; 
logic dffe1_div_en      ;
logic dffe1_sqrt_en     ;
logic dffe1_sin_en      ;
logic dffe1_cos_en      ;
logic dffe1_atan_en     ;
logic dffe1_quadf_en    ;
//logic dffe1_exp_en      ;
//logic dffe1_log_en      ;

always @(posedge i_clk or negedge i_reset_n ) begin
    if(!i_reset_n)begin
        dffe1_w_id1         <=  6'h00;
        dffe1_w_id2         <=  6'h00;
        dffe1_mul_const_en  <=  1'b0;
        dffe1_div_const_en  <=  1'b0;
        dffe1_div_en        <=  1'b0;      
        dffe1_sqrt_en       <=  1'b0;   
        dffe1_sin_en        <=  1'b0;     
        dffe1_cos_en        <=  1'b0;      
        dffe1_atan_en       <=  1'b0;     
        dffe1_quadf_en      <=  1'b0;    
        //dffe1_exp_en        <=  1'b0;     
        //dffe1_log_en        <=  1'b0;     
    end
    else if(~i_bus_stall_en)begin
        dffe1_w_id1         <=  dffr2_w_id1       ;
        dffe1_w_id2         <=  dffr2_w_id2       ;
        dffe1_mul_const_en  <=  dffr2_mul_const_en;
        dffe1_div_const_en  <=  dffr2_div_const_en;
        dffe1_div_en        <=  dffr2_div_en      ;
        dffe1_sqrt_en       <=  dffr2_sqrt_en     ;
        dffe1_sin_en        <=  dffr2_sin_en      ;
        dffe1_cos_en        <=  dffr2_cos_en      ;
        dffe1_atan_en       <=  dffr2_atan_en     ;
        dffe1_quadf_en      <=  dffr2_quadf_en    ;
        //dffe1_exp_en        <=  dffr2_exp_en      ;
        //dffe1_log_en        <=  dffr2_log_en      ;   
    end
end

assign o_wdataselect_id1  =  dffe1_w_id1       ;          
assign o_wdataselect_id2  =  dffe1_w_id2       ;          
assign o_mul_const_en     =  dffe1_mul_const_en;       
assign o_div_const_en     =  dffe1_div_const_en;       
assign o_div_en           =  dffe1_div_en      ; 
assign o_sqrt_en          =  dffe1_sqrt_en     ;  
assign o_sin_en           =  dffe1_sin_en      ; 
assign o_cos_en           =  dffe1_cos_en      ; 
assign o_atan_en          =  dffe1_atan_en     ;  
assign o_quadf_en         =  dffe1_quadf_en    ;   
//assign o_exp_en           =  dffe1_exp_en      ; 
//assign o_log_en           =  dffe1_log_en      ;       



endmodule