//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: sqrt_i3_v1.sv
//  Creating Date: Mon 15 Jan 2024 10:40:18 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Mon 15 Jan 2024 03:05:27 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module sqrt_i3_v1 (                                                                                                                                                
                    input logic i_clk,                                                                                                                           
                    input logic i_reset_n,  
                    input logic i_bus_stall_en,                    
                    input logic[31:0] i_x_cv,                                                                                                                      
                    input logic[31:0] i_y_cv,                                                                                                                      
                    //input logic[31:0] i_b_cv,                                                                                                                      
                    //                                                                                                                                             
                    output logic[63:0] o_x_nv                                                                                                                     
                    //output logic[31:0] o_y_nv,                                                                                                                     
                    //output logic[31:0] o_b_nv                                                                                                                      
);                                                                                                                                                                 
                                                                                                                                                                   
//logic[63:0] b_nv_mid_sqrt;                                                                                                                                         
//logic[31:0] b_nv_mid_sqrt_truncate;                                                                                                                                
//logic[63:0] b_nv_mid;                                                                                                                                              
//logic[63:0] b_nv_mid_fix;                                                                                                                                          
//assign o_x_nv =  i_x_cv * i_y_cv;                                                                                                                                
//assign b_nv_mid_sqrt = i_y_cv * i_y_cv;                                                                                                                          
//logic[63:0] o_x_nv_ex2;                                                                                                                                          
mul32_32_top_improve_sep4 MUL0_0(                                                                                                                                       
                              .i_clk(i_clk),                                                                                                                     
                              .i_reset_n(i_reset_n),
                              .i_bus_stall_en(i_bus_stall_en),                              
                              .i_x(i_x_cv),                                                                                                                        
                              .i_y(i_y_cv),                                                                                                                        
                              //                                                                                                                                   
                              .o_sum_final_out(o_x_nv)                                                                                                             
);                                                                                                                                                                 
                                                                                                                                                                   
//mul32_32_top_improve MUL0_1(                                                                                                                                       
//                              //.i_clk(i_clk),                                                                                                                     
//                              //.i_reset_n(i_reset_n),                                                                                                             
//                              .i_x(i_y_cv),                                                                                                                        
//                              .i_y(i_y_cv),                                                                                                                        
//                              //                                                                                                                                   
//                              .o_sum_final_out(b_nv_mid_sqrt)                                                                                                      
//);                                                                                                                                                                 
                                                                                                                                                                   
//assign b_nv_mid_sqrt_truncate = b_nv_mid_sqrt[63:32];                                                                                                              
////assign b_nv_mid = b_nv_mid_sqrt_truncate * i_b_cv;                                                                                                               
//mul32_32_top_improve MUL1_1(                                                                                                                                       
//                              //.i_clk(i_clk),                                                                                                                     
//                              //.i_reset_n(i_reset_n),                                                                                                             
//                              .i_x(b_nv_mid_sqrt_truncate),                                                                                                        
//                              .i_y(i_b_cv),                                                                                                                        
//                              //                                                                                                                                   
//                              .o_sum_final_out(b_nv_mid)                                                                                                           
//);                                                                                                                                                                 
//                                                                                                                                                                   
//logic[6:0] o_b_nv_lzd_out;                                                                                                                                         
//logic o_b_nv_zero_all;                                                                                                                                             
//leading_zero_detect64 lzd1(                                                                                                                                        
//                                .i_lzd_in(b_nv_mid),                                                                                                               
//                                //                                                                                                                                 
//                                .o_lzd_out(o_b_nv_lzd_out),                                                                                                        
//                                .o_zero_all(o_b_nv_zero_all)                                                                                                       
//);                                                                                                                                                                 
                                                                                                                                                                   
//always@(posedge i_clk or negedge i_reset_n)begin                                                                                                                 
//    if(!i_reset_n)                                                                                                                                               
//      o_x_nv <= 64'h0;                                                                                                                                           
//    else                                                                                                                                                         
//      o_x_nv <= o_x_nv_ex2;                                                                                                                                      
//end                                                                                                                                                              
                                                                                                                                                                   
                                                                                                                                                                   
                                                                                                                                                                   
//assign b_nv_mid_fix = o_b_nv_zero_all ?  64'h0 : b_nv_mid << o_b_nv_lzd_out;                                                                                       
//assign o_b_nv = b_nv_mid_fix[63:32];                                                                                                                               
//assign o_y_nv =  33'h18000_0000 + ~o_b_nv + 1'b1;                                                                                                                  
                                                                                                                                                                   
endmodule