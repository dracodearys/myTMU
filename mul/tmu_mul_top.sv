//------------------------------------------
//  File Type: V OR SV 
//  File Name: tmu_mul_top.sv
//  Creating Author: sunhzh
//  Creating Date: Wed 17 May 2023 05:10:44 PM CST
//  Description: 
//  Last Commit: Fri 22 Dec 2023 10:32:14 AM CST
//------------------------------------------

module tmu_mul_top(     
                  input logic i_tmu_const_en,  
                  input logic i_clk,
                  input logic i_reset_n,
                  input logic i_bus_stall_en,
                  input logic[31:0]i_rm,
                  input logic[31:0]i_rn,                                                                                                                                                                         
                  input logic i_rnd32,                                                                                                                                                                                
                  //output                                                                                                                                                                                            
                  output logic[31:0]o_ex2_result,                                                                                                                                                                     
                  output logic o_ex2_luf,o_ex2_lvf                                                                                                                                                                    
);                                                                                                                                                                                                                    
                                                                                                                                                                                                                      
                                                                                                                                                                                                                      
//pick unit                                                                                                                                                                                                           
logic[23:0] o_rmman;                                                                                                                                                                                                  
logic[7:0] o_rmexp;                                                                                                                                                                                                   
logic o_rmsign;                                                                                                                                                                                                       
logic o_rmvalid;                                                                                                                                                                                                      
logic o_rminf,o_rmzero;                                                                                                                                                                                               
logic[23:0] o_rnman;                                                                                                                                                                                                  
logic[7:0] o_rnexp;                                                                                                                                                                                                   
logic o_rnsign;                                                                                                                                                                                                       
logic o_rnvalid;                                                                                                                                                                                                      
logic o_rninf,o_rnzero;                                                                                                                                                                                               
                                                                                                                                                                                                                      
                                                                                                                                                                                                                      
double_pickdata u1(                                                                                                                                                                                                   
                      .i_rm(i_rm),                                                                                                                                                                                    
                      .i_rn(i_rn),                                                                                                                                                                                    
                      //output                                                                                                                                                                                        
                      .o_rmman(o_rmman),                                                                                                                                                                              
                      .o_rmexp(o_rmexp),                                                                                                                                                                              
                      .o_rmsign(o_rmsign),                                                                                                                                                                            
                      .o_rmvalid(o_rmvalid),                                                                                                                                                                          
                      .o_rminf(o_rminf),                                                                                                                                                                              
                      .o_rmzero(o_rmzero),                                                                                                                                                                            
                      .o_rnman(o_rnman),                                                                                                                                                                              
                      .o_rnexp(o_rnexp),                                                                                                                                                                              
                      .o_rnsign(o_rnsign),                                                                                                                                                                            
                      .o_rnvalid(o_rnvalid),                                                                                                                                                                          
                      .o_rninf(o_rninf),                                                                                                                                                                              
                      .o_rnzero(o_rnzero)                                                                                                                                                                             
);                                                                                                                                                                                                                    
                                                                                                                                                                                                                      
logic[47:0] o_wallace_sum,o_wallace_carry;                                                                                                                                                                            
                                                                                                                                                                                                                      
                                                                                                                                                                                                                      
                                                                                                                                                                                                                      
mul_man u2(                                                                                                                                                                                                           
              .i_rmman(o_rmman),                                                                                                                                                                                      
              .i_rnman(o_rnman),                                                                                                                                                                                      
              //output                                                                                                                                                                                                
              .wallace_sum(o_wallace_sum),                                                                                                                                                                            
              .wallace_carry(o_wallace_carry)                                                                                                                                                                         
);                                                                                                                                                                                                                    
                                                                                                                                                                                                                      
                                                                                                                                                                                                                      
logic[31:0] o_result_mid;                                                                                                                                                                                             
logic o_sign_mid;                                                                                                                                                                                                     
logic[7:0] o_exp_mid;                                                                                                                                                                                                 
logic[8:0] o_exp_sum;                                                                                                                                                                                                 
logic o_luf_mid,o_lvf_mid;                                                                                                                                                                                            
                                                                                                                                                                                                                      
assign o_sign_mid=o_rmsign^o_rnsign;                                                                                                                                                                                  
assign o_exp_sum=o_rmexp+o_rnexp;                                                                                                                                                                                     
                                                                                                                                                                                                                      
//ex1 combination block                                                                                                                                                                                               
always_comb begin                                                                                                                                                                                                     
  o_result_mid=32'h0000_0000;                                                                                                                                                                                         
  o_exp_mid=8'h00;                                                                                                                                                                                                    
  o_lvf_mid=1'b0;                                                                                                                                                                                                     
  o_luf_mid=1'b0;                                                                                                                                                                                                     
    if(!o_rmvalid || !o_rnvalid)begin  //abnormal value                                                                                                                                                               
      if(o_rminf || o_rninf)begin                                                                                                                                                                                     
        o_result_mid={o_sign_mid,31'h7f80_0000}; //+,-inf                                                                                                                                                             
      end                                                                                                                                                                                                             
      else if(o_rmzero && (!o_rninf) || o_rnzero && (!o_rminf))begin                                                                                                                                                  
        o_result_mid={o_sign_mid,31'h0000_0000}; //+,-0                                                                                                                                                               
      end                                                                                                                                                                                                             
    end                                                                                                                                                                                                               
    else begin                                                                                                                                                                                                        
      if(o_exp_sum < 8'd127)begin
      //if(o_exp_sum < 8'd126)begin                                                                                                                                                                                     
        o_result_mid={o_sign_mid,31'h0000_0000};                                                                                                                                                                      
        o_luf_mid=1'b1;                                                                                                                                                                                               
      end                                                                                                                                                                                                             
      //else if(o_exp_sum > 9'h17c)begin      //same as fpu unit mul operation                                                                                                                                                                          
      //  o_result_mid={o_sign_mid,31'h7f7f_ffff};                                                                                                                                                                      
      //  o_lvf_mid=1'b1;                                                                                                                                                                                               
      //end
      else if(o_exp_sum > 9'h17d)begin
        o_lvf_mid = 1'b1;
        if(i_rnd32)
          o_result_mid={o_sign_mid,31'h7f80_0000};
        else
          o_result_mid={o_sign_mid,31'h7f7f_ffff};
      end        
      else                                                                                                                                                                                                            
        o_exp_mid=o_exp_sum-8'd127;                                                                                                                                                                                   
    end                                                                                                                                                                                                               
end                                                                                                                                                                                                                   
                                                                                                                                                                                                                      
                                                                                                                                                                                                                      
//ex1 pipeline  
logic i_ex1_tmu_const_en;                                                                                                                                                                                                      
logic i_ex1_rnd32;                                                                                                                                                                                                    
logic o_ex1_luf,o_ex1_lvf;                                                                                                                                                                                            
logic[47:0] o_ex1_wallace_sum,o_ex1_wallace_carry;                                                                                                                                                                    
logic[31:0] o_ex1_result_mid;                                                                                                                                                                                         
logic[7:0] o_ex1_exp_mid;                                                                                                                                                                                             
logic o_ex1_sign_mid;                                                                                                                                                                                                 
logic o_ex1_rmvalid;                                                                                                                                                                                                  
logic o_ex1_rnvalid;                                                                                                                                                                                                  
logic o_ex1_rminf;                                                                                                                                                                                                    
logic o_ex1_rninf;                                                                                                                                                                                                    
logic o_ex1_rmzero;                                                                                                                                                                                                   
logic o_ex1_rnzero;                                                                                                                                                                                                   
                                                                                                                                                                                                                      
always@(posedge i_clk or negedge i_reset_n)begin                                                                                                                                                                      
    if(!i_reset_n)begin
      i_ex1_tmu_const_en<=1'b0;      
      i_ex1_rnd32<=1'b0;                                                                                                                                                                                              
      o_ex1_luf<=1'b0;                                                                                                                                                                                                
      o_ex1_lvf<=1'b0;                                                                                                                                                                                                
      o_ex1_rmvalid<=1'b0;                                                                                                                                                                                            
      o_ex1_rnvalid<=1'b0;                                                                                                                                                                                            
      o_ex1_rminf<=1'b0;                                                                                                                                                                                              
      o_ex1_rninf<=1'b0;                                                                                                                                                                                              
      o_ex1_rmzero<=1'b0;                                                                                                                                                                                             
      o_ex1_rnzero<=1'b0;                                                                                                                                                                                             
      o_ex1_sign_mid<=1'b0;                                                                                                                                                                                           
      o_ex1_result_mid<=32'h0000_0000;                                                                                                                                                                                
      o_ex1_exp_mid<=8'h00;                                                                                                                                                                                           
      o_ex1_wallace_sum<=48'h0000_0000_0000;                                                                                                                                                                          
      o_ex1_wallace_carry<=48'h0000_0000_0000;                                                                                                                                                                        
    end                                                                                                                                                                                                               
    //else begin
    else if(!i_bus_stall_en)begin
      i_ex1_tmu_const_en<=i_tmu_const_en;      
      i_ex1_rnd32<=i_rnd32;                                                                                                                                                                                           
      o_ex1_luf<=o_luf_mid;                                                                                                                                                                                           
      o_ex1_lvf<=o_lvf_mid;                                                                                                                                                                                           
      o_ex1_rmvalid<=o_rmvalid;                                                                                                                                                                                       
      o_ex1_rnvalid<=o_rnvalid;                                                                                                                                                                                       
      o_ex1_rminf<=o_rminf;                                                                                                                                                                                           
      o_ex1_rninf<=o_rninf;                                                                                                                                                                                           
      o_ex1_rmzero<=o_rmzero;                                                                                                                                                                                         
      o_ex1_rnzero<=o_rnzero;                                                                                                                                                                                         
      o_ex1_sign_mid<=o_sign_mid;                                                                                                                                                                                     
      o_ex1_result_mid<=o_result_mid;                                                                                                                                                                                 
      o_ex1_exp_mid<=o_exp_mid;                                                                                                                                                                                       
      o_ex1_wallace_sum<=o_wallace_sum;                                                                                                                                                                               
      o_ex1_wallace_carry<=o_wallace_carry;                                                                                                                                                                           
    end                                                                                                                                                                                                               
end                                                                                                                                                                                                                   
                                                                                                                                                                                                                      
                                                                                                                                                                                                                      
logic[48:0] o_man_mid;                                                                                                                                                                                                
logic[47:0] o_pman_mid;                                                                                                                                                                                               
logic o_man_carry;                                                                                                                                                                                                    
                                                                                                                                                                                                                      
CLA_48bit u3(                                                                                                                                                                                                         
              .a(o_ex1_wallace_sum),                                                                                                                                                                                  
              .b(o_ex1_wallace_carry),                                                                                                                                                                                
              //output                                                                                                                                                                                                
              //.cin(cin)//uselesss                                                                                                                                                                                   
              .sum(o_pman_mid),                                                                                                                                                                                       
              .carry_final(o_man_carry)                                                                                                                                                                               
);                                                                                                                                                                                                                    
                                                                                                                                                                                                                      
assign o_man_mid={o_man_carry,o_pman_mid};//include the hidden 1 ,but not o_man_carry                                                                                                                                 
                                                                                                                                                                                                                      
logic o_gb,o_rb,o_sb;                                                                                                                                                                                                 
logic[22:0] o_man_result;                                                                                                                                                                                             
logic[24:0] o_man_unshift_result;                                                                                                                                                                                     
logic[31:0] o_result;                                                                                                                                                                                                 
logic o_luf,o_lvf;                                                                                                                                                                                                    
logic[7:0] o_ex1_shift_exp;                                                                                                                                                                                           
                                                                                                                                                                                                                      

//old version
//assign o_gb=o_man_mid[22];                                                                                                                                                                                            
//assign o_rb=o_man_mid[21];                                                                                                                                                                                            
//assign o_sb=(|o_man_mid[20:0]);                                                                                                                                                                                       
             
logic o_lb;
assign o_gb = o_man_mid[47] ? o_man_mid[23] : o_man_mid[22];
assign o_rb = o_man_mid[47] ? o_man_mid[22] : o_man_mid[21];
assign o_sb = o_man_mid[47] ? (|o_man_mid[21:0]) : (|o_man_mid[20:0]);
assign o_lb = o_man_mid[47] ? o_man_mid[24] : o_man_mid[23];


//ex2 combination block                                                                                                                                                                                               
always_comb begin                                                                                                                                                                                                     
  o_man_result=23'h00_0000;                                                                                                                                                                                           
  o_man_unshift_result=25'h000_0000;                                                                                                                                                                                  
  o_luf=1'b0;                                                                                                                                                                                                         
  o_lvf=1'b0;                                                                                                                                                                                                         
  o_ex1_shift_exp=8'h00;                                                                                                                                                                                              
  o_result=32'h0000_0000;                                                                                                                                                                                             
  if(~i_ex1_tmu_const_en)begin
    o_result = 32'h0000_0000;
  end
  else if(!o_ex1_rmvalid || !o_ex1_rnvalid)begin  //abnormal value                                                                                                                                                         
      if(o_ex1_rminf || o_ex1_rninf)                                                                                                                                                                                  
        o_result=o_ex1_result_mid; //+,-inf                                                                                                                                                                           
      else if(o_ex1_rmzero && (!o_ex1_rninf) || o_ex1_rnzero && (!o_ex1_rminf))                                                                                                                                       
        o_result=o_ex1_result_mid; //+,-0                                                                                                                                                                             
      else                                                                                                                                                                                                            
        o_result=32'h0000_0000;                                                                                                                                                                                       
  end                                                                                                                                                                                                                 
  else if(o_ex1_luf || o_ex1_lvf)begin                                                                                                                                                                                
    o_result=o_ex1_result_mid;                                                                                                                                                                                        
    o_luf=o_ex1_luf;                                                                                                                                                                                                  
    o_lvf=o_ex1_lvf;                                                                                                                                                                                                  
  end                                                                                                                                                                                                                 
  else begin                                                                                                                                                                                                          
    if(i_ex1_rnd32)begin                                                                                                                                                                                              
      //if(o_gb==1 && (o_rb ||o_sb) || o_gb==1 && o_man_mid[23])begin   //old version 
      if(o_gb==1 && (o_rb ||o_sb) || o_gb==1 && o_lb)begin                                                                                                                                                  
        //o_man_result=o_man_mid[45:23]+1'b1; // without hidden one                                                                                                                                                   
        o_man_unshift_result=o_man_mid[47:23]+1'b1;                                                                                                                                                                   
        //if(o_man_mid[47])begin
        
        if(o_man_unshift_result[24])begin
          o_ex1_shift_exp=o_ex1_exp_mid+1'b1;                                                                                                                                                                         
          o_man_result=o_man_unshift_result[23:1];                                                                                                                                                                    
          //if(o_ex1_shift_exp<8'd127)begin
          if(o_ex1_shift_exp<8'd0)begin                                                                                                                                                                             
            o_result={o_ex1_sign_mid,31'h0000_0000};                                                                                                                                                                  
            o_luf=1'b1;                                                                                                                                                                                               
          end                                                                                                                                                                                                         
          //else if(o_ex1_shift_exp > 9'h17c)begin 
          else if(o_ex1_shift_exp > 8'hfe)begin                                                                                                                                                                     
            //o_result={o_ex1_sign_mid,31'h7f7f_ffff};                                                                                                                                                                  
            o_result={o_ex1_sign_mid,31'h7f80_0000};
            o_lvf=1'b1;                                                                                                                                                                                               
          end                                                                                                                                                                                                         
          else begin                                                                                                                                                                                                  
            //o_result={o_ex1_sign_mid,o_ex1_shift_exp,o_man_result};// not consider the shifted man part                                                                                                             
            o_result={o_ex1_sign_mid,o_ex1_shift_exp,o_man_result};                                                                                                                                                   
            o_luf=o_ex1_luf;                                                                                                                                                                                          
            o_lvf=o_ex1_lvf;                                                                                                                                                                                          
          end                                                                                                                                                                                                         
        end                                                                                                                                                                                                           
        else begin
          if(|o_ex1_exp_mid)begin                     //new constrict          
            o_man_result=o_man_unshift_result[22:0];                                                                                                                                                                    
            o_result={o_ex1_sign_mid,o_ex1_exp_mid,o_man_result};
          end
          else begin
            o_result={o_ex1_sign_mid,31'h0};
            o_luf=1'b1;  
          end          
        end                                                                                                                                                                                                           
      end                                                                                                                                                                                                             
      else begin                                                                                                                                                                                                      
        //o_man_result=o_man_mid[45:23];                                                                                                                                                                              
        o_man_unshift_result=o_man_mid[47:23];                                                                                                                                                                        
        if(o_man_mid[47])begin                                                                                                                                                                                        
          o_ex1_shift_exp=o_ex1_exp_mid+1'b1;                                                                                                                                                                         
          o_man_result=o_man_unshift_result[23:1];                                                                                                                                                                    
          //if()begin
          //
          //
          //end
          if(o_ex1_shift_exp > 8'hfe)begin
            o_result={o_ex1_sign_mid,31'h7f80_0000};
            o_lvf=1'b1;
          end
          else begin
            o_result={o_ex1_sign_mid,o_ex1_shift_exp,o_man_result};
            o_luf=o_ex1_luf;
            o_lvf=o_ex1_lvf; 
          end            
        end                                                                                                                                                                                                           
        else begin
          if(|o_ex1_exp_mid)begin                      //new constrict
            o_man_result=o_man_unshift_result[22:0];                                                                                                                                                                    
            o_result={o_ex1_sign_mid,o_ex1_exp_mid,o_man_result};
          end
          else begin          
            o_result={o_ex1_sign_mid,31'h0};
            o_luf=1'b1;
          end            
        end                                                                                                                                                                                                           
      end                                                                                                                                                                                                             
    end                                                                                                                                                                                                               
    else begin                                                                                                                                                                                                        
      o_man_unshift_result=o_man_mid[47:23];                                                                                                                                                                          
      if(o_man_mid[47])begin                                                                                                                                                                                          
          o_ex1_shift_exp=o_ex1_exp_mid+1'b1;                                                                                                                                                                         
          o_man_result=o_man_unshift_result[23:1];                                                                                                                                                                    
          //if(o_ex1_shift_exp<8'd127)begin
          if(o_ex1_shift_exp<8'd0)begin                                                                                                                                                                             
            o_result={o_ex1_sign_mid,31'h0000_0000};                                                                                                                                                                  
            o_luf=1'b1;                                                                                                                                                                                               
          end                                                                                                                                                                                                         
          //else if(o_ex1_shift_exp > 9'h17c)begin
          else if(o_ex1_shift_exp > 8'hfe)begin                                                                                                                                                                      
            o_result={o_ex1_sign_mid,31'h7f7f_ffff};                                                                                                                                                                  
            o_lvf=1'b1;                                                                                                                                                                                               
          end                                                                                                                                                                                                         
          else begin                                                                                                                                                                                                  
            o_result={o_ex1_sign_mid,o_ex1_shift_exp,o_man_result};                                                                                                                                                   
            o_luf=o_ex1_luf;                                                                                                                                                                                          
            o_lvf=o_ex1_lvf;                                                                                                                                                                                          
          end                                                                                                                                                                                                         
      end                                                                                                                                                                                                             
      else begin
        if(|o_ex1_exp_mid)begin                           //add epx = 0 situation 
          o_man_result=o_man_unshift_result[22:0];                                                                                                                                                                      
          o_result={o_ex1_sign_mid,o_ex1_exp_mid,o_man_result}; 
        end
        else begin        
          o_result ={o_ex1_sign_mid,31'h0};
          o_luf=1'b1;
        end          
      end                                                                                                                                                                                                             
    end                                                                                                                                                                                                               
  end                                                                                                                                                                                                                 
end                                                                                                                                                                                                                   
                                                                                                                                                                                                                      
//pipeline 2                                                                                                                                                                                                          
//always@(posedge i_clk or negedge i_reset_n)begin                                                                                                                                                                      
//  if(!i_reset_n)begin                                                                                                                                                                                                 
//    o_ex2_result<=32'h0000_0000;                                                                                                                                                                                      
//    o_ex2_luf<=1'b0;                                                                                                                                                                                                  
//    o_ex2_lvf<=1'b0;                                                                                                                                                                                                  
//  end                                                                                                                                                                                                                 
//  else begin                                                                                                                                                                                                          
//    o_ex2_result<=o_result;                                                                                                                                                                                           
//    o_ex2_luf<=o_luf;                                                                                                                                                                                                 
//    o_ex2_lvf<=o_lvf;                                                                                                                                                                                                 
//  end                                                                                                                                                                                                                 
//end

assign o_ex2_result = o_result;
assign o_ex2_luf    = o_luf;
assign o_ex2_lvf    = o_lvf;

                                                                                                                                                                                                                      
endmodule