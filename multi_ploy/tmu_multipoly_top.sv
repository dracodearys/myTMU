/*-------------------------------------------------------------
+FHDR--------------------------------------------------
#  File Name: tmu_multipoly_top.sv
#  Creating Date: Tue May 14 13:58:28 CST 2024
#  Creating Author: dangqc
#  Description: Describe module
#  Related Document Path: xx/xxxx/xxx/xxx/
#  Last Modify:	Tue May 14 13:59:13 CST 2024 
#-FDHR-------------------------------------------------
-------------------------------------------------------------*/
//+FHDR---------------------------------------
//--------------------------------------------
//    FileName : tmu_multipoly_top.sv
//    CreateTime : 2023-11-27 14:25
//    Author : Jiyz
//    LastModified : 2024-02-06 15:41
//    Description : 
//--------------------------------------------
//-FHDR---------------------------------------

module tmu_multipoly_top (
  input   logic           sys_clk,
  input   logic           sys_rst,
  input   logic [31:0]    float_x,
  input   logic           sin_en,     
  input   logic           cos_en,     
  input   logic           atan_en,     
  input   logic           stall_en,     
  output  logic [31:0]    float_y,
  output  logic           lvf_flag

);
  logic           sign  ;
  logic [7:0]     expo  ;
  logic [7:0]     expo_ex1  ;
  logic [7:0]     expo_ex2  ;
  logic [7:0]     expo_ex3  ;
  logic [23:0]    frac  ;
  logic [23:0]    frac_ex1  ;
  logic [23:0]    frac_ex2  ;
  logic [23:0]    frac_ex3  ;
  logic [7:0]     expo_nbias;
  logic [7:0]     y_expo;
  logic [7:0]     float_expo;
  logic [22:0]    y_frac;
  logic [22:0]    float_frac;

  logic [7:0]     ep    ;
  logic [7:0]     ep_ex1    ;
  logic [7:0]     ep_ex2    ;
  logic [7:0]     ep_ex3    ;
  logic [23:0]    op_1  ;
  logic [23:0]    op_2  ;
  logic [23:0]    op_2_ex1  ;
  logic [23:0]    op_2_ex2  ;
  logic [23:0]    op_addr  ;
  logic [26:0]    op_p3  ;
  logic [26:0]    op_3  ;
  logic [27:0]    op_4  ;
  logic [27:0]    op_4_ex2  ;
  logic [31:0]    op_p5  ;
  logic [31:0]    op_5  ;

  logic [6:0]     coef_addr;
  logic [6:0]     coef_addr_ex1;
  logic [6:0]     coef_addr_ex2;
  logic [6:0]     coef_addr_ex3;
  logic [20:0]    sin_coef_a;
  logic [20:0]    sin_coef_a_ex1;
  logic [25:0]    sin_coef_b;
  logic [25:0]    sin_coef_b_ex1;
  logic [25:0]    sin_coef_b_ex2;
  logic [24:0]    sin_coef_c;
  logic [24:0]    sin_coef_c_ex1;
  logic [24:0]    sin_coef_c_ex2;
  logic [24:0]    sin_coef_c_ex3;
  logic [20:0]    cos_coef_a;
  logic [20:0]    cos_coef_a_ex1;
  logic [25:0]    cos_coef_b;
  logic [25:0]    cos_coef_b_ex1;
  logic [25:0]    cos_coef_b_ex2;
  logic [27:0]    cos_coef_c;
  logic [27:0]    cos_coef_c_ex1;
  logic [27:0]    cos_coef_c_ex2;
  logic [27:0]    cos_coef_c_ex3;
  logic [21:0]    atan_coef_a;
  logic [21:0]    atan_coef_a_ex1;
  logic [25:0]    atan_coef_b;
  logic [25:0]    atan_coef_b_ex1;
  logic [25:0]    atan_coef_b_ex2;
  logic [22:0]    atan_coef_c;
  logic [22:0]    atan_coef_c_ex1;
  logic [22:0]    atan_coef_c_ex2;
  logic [22:0]    atan_coef_c_ex3;

  logic [31:0]    mul_m_1;
  logic [31:0]    mul_m_2;
  logic [31:0]    mul_n_1;
  logic [31:0]    mul_n_2;
  logic [63:0]    mul_res_1;
  logic [63:0]    mul_res_2;

  logic [31:0]    int_y;  //  
  logic [1:0]     phase ;
  logic           sign_o;
  logic           sign_o_ex1;
  logic           sign_o_ex2;
  logic           sign_o_ex3;
  logic [1:0]     flag_ulti;
  logic [1:0]     flag_ulti_ex1;
  logic [1:0]     flag_ulti_ex2;
  logic [1:0]     flag_ulti_ex3;
  logic           sin_en_ex1  ;
  logic           sin_en_ex2  ;
  logic           sin_en_ex3  ;
  logic           cos_en_ex1  ;
  logic           cos_en_ex2  ;
  logic           cos_en_ex3  ;
  logic           atan_en_ex1  ;
  logic           atan_en_ex2  ;
  logic           atan_en_ex3  ;

  
  logic [31:0]    float_y_0;


  // --------------------------------------------
  // ---------------- EX 1 ----------------------
  assign sign = float_x[31];
  assign expo = float_x[30:23];
  assign frac = {1'b1, float_x[22:0]};
  assign expo_nbias = (expo > 8'd126) ? (expo - 8'd126) : (8'd126 - expo);
  
  // Define input range phase
  always @ (*) begin
    if (sin_en || cos_en) begin  
      if ((expo > 8'd126) && (expo < 8'd149)) begin 
        if (!frac[22-expo_nbias+1] && !frac[22-expo_nbias]) begin 
          // (0, 0.25)
          phase = 2'b00;
        end else if (!frac[22-expo_nbias+1] &&  frac[22-expo_nbias]) begin 
          // (0.25, 0.5)
          phase = 2'b01;
        end else if ( frac[22-expo_nbias+1] && !frac[22-expo_nbias]) begin 
          // (0.5, 0.75)
          phase = 2'b10;
        end else if ( frac[22-expo_nbias+1] &&  frac[22-expo_nbias]) begin 
          // (0.75, 1)
          phase = 2'b11;
        end else begin 
          phase = 'b0;  // never readched 
        end
      end else if (expo == 8'd126) begin 
        // frac[23] is hidden, which is 1'b1.
        if (frac[22]) begin 
          // (0.75, 1)
          phase = 2'b11;
        end else begin
          // (0.5, 0.75) 
          phase = 2'b10;
        end
      end else if (expo == 8'd125) begin 
        // (0.25, 0.5)
        phase = 2'b01;
      end else if ((expo < 8'd125) && (expo > 8'd102)) begin 
        // (0, 0.25)
        phase = 2'b00;
      end else begin 
        // invalid input: too big or too small 
        phase = 2'b0;
      end
    end else begin 
      phase = 2'b00;
    end
  end

  // Define output sign
  always @ (*) begin
    if (sin_en) begin 
      case (phase) 
      2'b00 : sign_o = sign;
      2'b01 : sign_o = sign;
      2'b10 : sign_o = !sign;
      2'b11 : sign_o = !sign;
      default : sign_o = 1'b0;
      endcase  
    end else if (cos_en) begin 
      case (phase) 
      2'b00 : sign_o = 1'b0;
      2'b01 : sign_o = 1'b1;
      2'b10 : sign_o = 1'b1;
      2'b11 : sign_o = 1'b0;
      default : sign_o = 1'b0;
      endcase  
    end else if (atan_en) begin 
      sign_o = sign;
    end else begin 
      sign_o = 1'b0;
    end 
  end
            
  // Mapping input float to desire range
  always @ (*) begin 
    if (sin_en || cos_en) begin 
      // ----- sin func & cos func -----
      if ((expo > 8'd126) && (expo < 8'd149)) begin 
        if (phase == 2'b00) begin 
          // (0, 0.25)
          op_1 = frac << (expo_nbias);
        end else if (phase == 2'b01) begin 
          // (0.25, 0.5)
          op_1 = ~(frac << (expo_nbias)) + 1'b1;
        end else if (phase == 2'b10) begin 
          // (0.5, 0.75)
          op_1 = frac << (expo_nbias);
        end else if (phase == 2'b11) begin 
          // (0.75, 1)
          op_1 = ~(frac << (expo_nbias)) + 1'b1;
        end else begin 
          op_1 = 'b0; 
        end
      end else if (expo == 8'd126) begin 
        // frac[23] is hidden, which is 1'b1.
        if (frac[22]) begin 
          // (0.75, 1)
          op_1[21:0] = ~frac[21:0] + 1'b1;
          op_1[23:22] = 2'b0; 
        end else begin
          // (0.5, 0.75) 
          op_1[21:0] = frac[21:0];
          op_1[23:22] = 2'b0;
        end
      end else if (expo == 8'd125) begin 
        // (0.25, 0.5)
        op_1 = (~frac) + 1'b1;
      end else if ((expo < 8'd125) && (expo > 8'd102)) begin 
        // (0, 0.25)
        op_1 = frac;
      end else begin 
        // invalid input: too big or too small 
        op_1 = 'b0;
      end
      // --------------------
    end else if (atan_en) begin 
      // ----- atan func -----
      if ((8'd102 < expo) && (expo <= 8'd126)) begin 
        op_1 = frac;
      end else begin 
        // invalid input: too big or too small 
        op_1 = 'b0;
      end
      // --------------------
    end else begin 
      op_1 = 'b0;
    end
  end
 always @ (*) begin 
    if (sin_en || cos_en) begin 
      // ----- sin func & cos func -----
      if ((expo > 8'd126) && (expo < 8'd149)) begin 
        op_2[21:0] = op_1[21:0];
        op_2[23:22] = 2'b0;
      end else begin 
        op_2 = op_1;
      end 
    end else if (atan_en) begin
      op_2 = op_1;
    end else begin 
      op_2 = 'b0;
    end
  end 

  // When input is exactly 0, 0.25, 0.75 or 1, they all present as op_2 = 'b0 which 
  // is unable to seperate. And due to calculate error, sometimes 0 that should be output 
  // is a approximation of 0 instead of '32'h0'. The 'flag_ulti' make sure output in these 
  // specific situation is a solid '32'h0' or '32'h3f800000'.
  // 00/11: NA    01: 0    10: 1
  always @ (*) begin
    //if (expo >= 8'd149) begin
    //  // too big input  
    //  if (sin_en) begin 
    //    flag_ulti = 2'b01;
    //  end else if (cos_en) begin 
    //    flag_ulti = 2'b10;
    //  end else begin 
    //    flag_ulti = 'b0;
    //  end 
    //end else 
    if ((expo > 8'd126) && (expo < 8'd149)) begin 
      if (sin_en) begin 
        if ((phase == 2'b00) && (op_2[21:0] == 'b0)) begin 
          flag_ulti = 2'b01;
        end else if ((phase == 2'b01) && (op_2[21:0] == 'b0)) begin
          flag_ulti = 2'b10;
        end else if ((phase == 2'b10) && (op_2[21:0] == 'b0)) begin
          flag_ulti = 2'b01;
        end else if ((phase == 2'b11) && (op_2[21:0] == 'b0)) begin
          flag_ulti = 2'b10;
        end else begin  
          flag_ulti = 'b0;
        end 
      end else if (cos_en) begin 
        if ((phase == 2'b00) && (op_2[21:0] == 'b0)) begin 
          flag_ulti = 2'b10;
        end else if ((phase == 2'b01) && (op_2[21:0] == 'b0)) begin
          flag_ulti = 2'b01;
        end else if ((phase == 2'b10) && (op_2[21:0] == 'b0)) begin
          flag_ulti = 2'b10;
        end else if ((phase == 2'b11) && (op_2[21:0] == 'b0)) begin
          flag_ulti = 2'b01;
        end else begin  
          flag_ulti = 'b0;
        end 
      end else begin 
        flag_ulti = 'b0;
      end
    end else if (expo == 8'd126) begin 
      if (sin_en) begin 
        if (float_x[22:0] == 23'b0) begin   // 0.5
          flag_ulti = 2'b01;    
        end else if (float_x[22] && (float_x[21:0] == 22'b0)) begin   // 0.75
          flag_ulti = 2'b10;
        end else begin 
          flag_ulti = 'b0;
        end 
      end else if (cos_en) begin 
        if (float_x[22:0] == 23'b0) begin   // 0.5
          flag_ulti = 2'b10;    
        end else if (float_x[22] && (float_x[21:0] == 22'b0)) begin   // 0.75
          flag_ulti = 2'b01;
        end else begin 
          flag_ulti = 'b0;
        end 
      end else begin 
        flag_ulti = 'b0;
      end 
    end else if (expo == 8'd125) begin 
      if (sin_en) begin 
        if (float_x[22:0] == 23'b0) begin // 0.25 
          flag_ulti = 2'b10;
        end else begin 
          flag_ulti = 'b0;
        end 
      end else if (cos_en) begin 
        if (float_x[22:0] == 23'b0) begin // 0.25
          flag_ulti = 2'b01;
        end else begin 
          flag_ulti = 'b0;
        end 
      end else begin 
        flag_ulti = 'b0;
      end 
    end else begin 
      flag_ulti = 'b0;
    end
  end 

  // When float is bigger than 0.25, the 'op_1' which is derived from 'frac',
  // have already been limited in (0,0.25). When float is smaller than 0.25, the
  // 'frac' is bigger than 0.25. To ensure the acurracy, the 'expo' power of int 
  // does a shift 'ep' if expo is around 125, if float is smaller, then restore
  // the expo val, in following calc consider adding power and minus power.
  always @ (*) begin
    if (sin_en || cos_en) begin 
      if (expo >= 8'd125) begin 
        ep = 8'd0;
      end else begin 
        ep = 8'd125 - expo;
      end  
    end else if (atan_en) begin 
      ep = 8'd126 - expo; 
    end else begin 
      ep = 'b0; 
    end 
  end
  always @ (*) begin
    if (sin_en || cos_en) begin 
      if (expo >= 8'd126) begin 
        op_addr = op_2 << 1'b1;
      end else begin 
        op_addr = op_2 >> ep;
      end 
    end else if (atan_en) begin 
      op_addr = op_2 >> (ep + 1'b1);
    end else begin 
      op_addr = 'b0;
    end  
  end
  assign coef_addr = op_addr[22:16]; 
  sin_table u_sin_table(
    .coef_addr  ( coef_addr     ),  
    .coef_a     ( sin_coef_a    ),  // 21 bit
    .coef_b     ( sin_coef_b    ),  // 26 bit 
    .coef_c     ( sin_coef_c    )   // 25 bit 
  );
  cos_table u_cos_table(
    .coef_addr  ( coef_addr     ),  
    .coef_a     ( cos_coef_a    ),  // 21 bit
    .coef_b     ( cos_coef_b    ),  // 26 bit 
    .coef_c     ( cos_coef_c    )   // 28 bit 
  );
  atan_table u_atan_table(
    .coef_addr  ( coef_addr      ),  
    .coef_a     ( atan_coef_a    ),  // 22 bit
    .coef_b     ( atan_coef_b    ),  // 26 bit 
    .coef_c     ( atan_coef_c    )   // 23 bit 
  );

  // -------------------
  assign mul_m_1 = op_2;
  always @ (*) begin
    if (sin_en) begin 
      mul_n_1 = sin_coef_a; 
    end else if (cos_en) begin 
      mul_n_1 = cos_coef_a;
    end else if (atan_en) begin 
      mul_n_1 = atan_coef_a;
    end else begin 
      mul_n_1 = 'b0;
    end  
  end
  // mul u1
  mul32_32_top_improve_sep u1_poly_mul(
    .i_clk           ( sys_clk      ),
    .i_reset_n       ( sys_rst      ),
    .i_bus_stall_en      ( stall_en     ),
    .i_x             ( mul_m_1      ),   // 24 bit
    .i_y             ( mul_n_1      ),   // 
    .o_sum_final_out ( mul_res_1    )    // 
  );
  always @ (posedge sys_clk, negedge sys_rst) begin 
    if (!sys_rst) begin 
      op_2_ex1 <= 'b0;
      sin_en_ex1 <= 'b0;
      cos_en_ex1 <= 'b0;
      atan_en_ex1 <= 'b0;
      expo_ex1 <= 'b0;
      ep_ex1 <= 'b0;
      coef_addr_ex1 <= 'b0;
      sin_coef_b_ex1 <= 'b0;
      cos_coef_b_ex1 <= 'b0;
      atan_coef_b_ex1 <= 'b0;
      sin_coef_c_ex1 <= 'b0;
      cos_coef_c_ex1 <= 'b0;
      atan_coef_c_ex1 <= 'b0;
      flag_ulti_ex1 <= 'b0;
      sign_o_ex1 <= 'b0;
      frac_ex1 <= 'b0;
    end else if (stall_en) begin 
      op_2_ex1 <= op_2_ex1;
      sin_en_ex1 <= sin_en_ex1;
      cos_en_ex1 <= cos_en_ex1;
      atan_en_ex1 <= atan_en_ex1;
      expo_ex1 <= expo_ex1;
      ep_ex1 <= ep_ex1;      
      coef_addr_ex1 <= coef_addr_ex1;
      sin_coef_b_ex1 <= sin_coef_b_ex1;
      cos_coef_b_ex1 <= cos_coef_b_ex1;
      atan_coef_b_ex1 <= atan_coef_b_ex1;
      sin_coef_c_ex1 <= sin_coef_c_ex1;
      cos_coef_c_ex1 <= cos_coef_c_ex1;
      atan_coef_c_ex1 <= atan_coef_c_ex1;
      flag_ulti_ex1 <= flag_ulti_ex1;
      sign_o_ex1 <= sign_o_ex1;
      frac_ex1 <= frac_ex1;
    end else begin 
      op_2_ex1 <= op_2;
      sin_en_ex1 <= sin_en;
      cos_en_ex1 <= cos_en;
      atan_en_ex1 <= atan_en;
      expo_ex1 <= expo;
      ep_ex1 <= ep;
      coef_addr_ex1 <= coef_addr;
      sin_coef_b_ex1 <= sin_coef_b;
      cos_coef_b_ex1 <= cos_coef_b;
      atan_coef_b_ex1 <= atan_coef_b;
      sin_coef_c_ex1 <= sin_coef_c;
      cos_coef_c_ex1 <= cos_coef_c;
      atan_coef_c_ex1 <= atan_coef_c;
      flag_ulti_ex1 <= flag_ulti;
      sign_o_ex1 <= sign_o;
      frac_ex1 <= frac;
    end 
  end


  // --------------------------------------------
  // ---------------- EX 2 ----------------------
  always @ (*) begin
    if (sin_en_ex1 || cos_en_ex1) begin 
      if (mul_res_1[17]) begin 
        op_p3 = mul_res_1[44:18] + 1'b1;     // 27 bit
      end else begin 
        op_p3 = mul_res_1[44:18];
      end 
    end else if (atan_en_ex1) begin 
      op_p3 = mul_res_1[45:22];   // 24 bit 
      // if (mul_res_1[21]) begin 
      //   op_p3 = mul_res_1[40:22] + 1'b1;     //
      // end else begin 
      //   op_p3 = mul_res_1[40:22];
      // end 
    end else begin 
      op_p3 = 'b0;
    end  
  end
  always @ (*) begin
    if (sin_en_ex1 || cos_en_ex1) begin 
      if (expo_ex1 > 8'd126) begin 
        op_3 = op_p3;
      end else if (expo_ex1 == 8'd126) begin 
        op_3 = op_p3;
      end else begin
        if (op_p3[ep_ex1]) begin 
          op_3 = (op_p3 >> (ep_ex1 + 1'b1)) + 1'b1;
        end else begin 
          op_3 = op_p3 >> (ep_ex1 + 1'b1);
        end 
      end  
    end else if (atan_en_ex1) begin 
      if (ep_ex1 > 'b0) begin 
        op_3 = op_p3 >> ep_ex1;
        // if (op_p3[ep_ex1 - 1'b1]) begin 
        //   op_3 = (op_p3 >> ep_ex1) + 1'b1;
        // end else begin 
        //   op_3 = op_p3 >> ep_ex1;
        // end 
      end else begin 
        op_3 = op_p3;
      end 
    end else begin 
      op_3 = 'b0;
    end 
  end
  always @ (*) begin
    if (sin_en_ex1) begin 
      op_4 = ({1'b0, sin_coef_b_ex1} > op_3) ? ({1'b0, sin_coef_b_ex1} - op_3) : 'b0; 
    end else if (cos_en_ex1) begin 
      op_4 = cos_coef_b_ex1 + op_3;
    end else if (atan_en_ex1) begin 
      op_4 = ({1'b0, atan_coef_b_ex1} > op_3) ? ({1'b0, atan_coef_b_ex1} - op_3) : 'b0;
    end else begin  
      op_4 = 'b0;
    end  
  end
  always @ (posedge sys_clk, negedge sys_rst) begin 
    if (!sys_rst) begin 
      op_2_ex2 <= 'b0;
      op_4_ex2 <= 'b0;
      sin_en_ex2 <= 'b0;
      cos_en_ex2 <= 'b0;
      atan_en_ex2 <= 'b0;
      expo_ex2 <= 'b0;
      ep_ex2 <= 'b0;
      coef_addr_ex2 <= 'b0;
      sin_coef_c_ex2 <= 'b0;
      cos_coef_c_ex2 <= 'b0;
      atan_coef_c_ex2 <= 'b0;
      flag_ulti_ex2 <= 'b0;
      sign_o_ex2 <= 'b0;
      frac_ex2 <= 'b0;
    end else if (stall_en) begin 
      op_2_ex2 <= op_2_ex2;
      op_4_ex2 <= op_4_ex2;
      sin_en_ex2 <= sin_en_ex2;
      cos_en_ex2 <= cos_en_ex2;
      atan_en_ex2 <= atan_en_ex2;
      expo_ex2 <= expo_ex2;
      ep_ex2 <= ep_ex2;
      coef_addr_ex2 <= coef_addr_ex2;
      sin_coef_c_ex2 <= sin_coef_c_ex2;
      cos_coef_c_ex2 <= cos_coef_c_ex2;
      atan_coef_c_ex2 <= atan_coef_c_ex2;
      flag_ulti_ex2 <= flag_ulti_ex2;
      sign_o_ex2 <= sign_o_ex2;
      frac_ex2 <= frac_ex2;
    end else begin 
      op_2_ex2 <= op_2_ex1;
      op_4_ex2 <= op_4;     //
      sin_en_ex2 <= sin_en_ex1;
      cos_en_ex2 <= cos_en_ex1;
      atan_en_ex2 <= atan_en_ex1;
      expo_ex2 <= expo_ex1;
      ep_ex2 <= ep_ex1;
      coef_addr_ex2 <= coef_addr_ex1;
      sin_coef_c_ex2 <= sin_coef_c_ex1;
      cos_coef_c_ex2 <= cos_coef_c_ex1;
      atan_coef_c_ex2 <= atan_coef_c_ex1;
      flag_ulti_ex2 <= flag_ulti_ex1;
      sign_o_ex2 <= sign_o_ex1;
      frac_ex2 <= frac_ex1;
    end 
  end



  // --------------------------------------------
  // ---------------- EX 3 ----------------------
  assign mul_m_2 = op_2_ex2;  // 24 bit
  assign mul_n_2 = op_4_ex2;  // sin/cos: 27 bit; atan: 24 bit;
  // mul u2
  mul32_32_top_improve_sep u2_poly_mul(
    .i_clk             ( sys_clk      ),
    .i_reset_n         ( sys_rst      ),
    .i_bus_stall_en        ( stall_en     ),
    .i_x               ( mul_m_2      ),   // 24 bit x 
    .i_y               ( mul_n_2      ),   // (ax-b)  
    .o_sum_final_out   ( mul_res_2    )    // (ax-b)x
  );
  always @ (posedge sys_clk, negedge sys_rst) begin 
    if (!sys_rst) begin 
      sin_en_ex3 <= 'b0;
      cos_en_ex3 <= 'b0;
      atan_en_ex3 <= 'b0;
      expo_ex3 <= 'b0;
      ep_ex3 <= 'b0;
      coef_addr_ex3 <= 'b0;
      sin_coef_c_ex3 <= 'b0;
      cos_coef_c_ex3 <= 'b0;
      atan_coef_c_ex3 <= 'b0;
      flag_ulti_ex3 <= 'b0;
      sign_o_ex3 <= 'b0;
      frac_ex3 <= 'b0;
    end else if (stall_en) begin 
      sin_en_ex3 <= sin_en_ex3;
      cos_en_ex3 <= cos_en_ex3;
      atan_en_ex3 <= atan_en_ex3;
      expo_ex3 <= expo_ex3;
      ep_ex3 <= ep_ex3;
      coef_addr_ex3 <= coef_addr_ex3;
      sin_coef_c_ex3 <= sin_coef_c_ex3;
      cos_coef_c_ex3 <= cos_coef_c_ex3;
      atan_coef_c_ex3 <= atan_coef_c_ex3;
      flag_ulti_ex3 <= flag_ulti_ex3;
      sign_o_ex3 <= sign_o_ex3;
      frac_ex3 <= frac_ex3;
    end else begin 
      sin_en_ex3 <= sin_en_ex2;
      cos_en_ex3 <= cos_en_ex2;
      atan_en_ex3 <= atan_en_ex2;
      expo_ex3 <= expo_ex2;
      ep_ex3 <= ep_ex2;
      coef_addr_ex3 <= coef_addr_ex2;
      sin_coef_c_ex3 <= sin_coef_c_ex2;
      cos_coef_c_ex3 <= cos_coef_c_ex2;
      atan_coef_c_ex3 <= atan_coef_c_ex2;
      flag_ulti_ex3 <= flag_ulti_ex2;
      sign_o_ex3 <= sign_o_ex2;
      frac_ex3 <= frac_ex2;
    end 
  end

  // --------------------------------------------
  // ---------------- EX 4 ----------------------
  always @ (*) begin
    if (sin_en_ex3 || cos_en_ex3) begin 
      if (mul_res_2[19]) begin 
        op_p5 = mul_res_2[51:20] + 1'b1;   // 32 bit 
      end else begin 
        op_p5 = mul_res_2[51:20];   // 32 bit 
      end 
    end else if (atan_en_ex3) begin 
      op_p5 = mul_res_2[49:21];    // 29 bit 
      // if (mul_res_2[18]) begin 
      //   op_p5 = mul_res_2[44:19] + 1'b1;   // 27 bit
      // end else begin 
      //   op_p5 = mul_res_2[44:19];   // 27 bit
      // end 
    end else begin
      op_p5 = 'b0;
    end  
  end
  always @ (*) begin
    if (sin_en_ex3 || cos_en_ex3) begin 
      if (expo_ex3 >= 8'd126) begin 
        op_5 = op_p5;
      end else begin 
        if (op_p5[ep_ex3]) begin 
          op_5 = (op_p5 >> (ep_ex3 + 1'b1)) + 1'b1;
        end else begin 
          op_5 = op_p5 >> (ep_ex3 + 1'b1);
        end 
      end  
    end else if (atan_en_ex3) begin 
      if (ep_ex3 > 'b0) begin 
        op_5 = op_p5 >> ep_ex3;
        // if (op_p5[ep_ex3 - 1'b1]) begin 
        //   op_5 = (op_p5 >> ep_ex3) + 1'b1;
        // end else begin 
        //   op_5 = op_p5 >> ep_ex3;
        // end 
      end else begin 
        op_5 = op_p5;
      end 
    end else begin 
      op_5 = 'b0;
    end 
  end
  always @ (*) begin
    if (sin_en_ex3) begin 
      int_y = (op_5 > {7'b0, sin_coef_c_ex3}) ? (op_5 - sin_coef_c_ex3) : 'b0; 
    end else if (cos_en_ex3) begin 
      int_y = ({4'b0, cos_coef_c_ex3} > op_5) ? ({4'b0, cos_coef_c_ex3} - op_5) : 'b0;
    end else if (atan_en_ex3)begin 
      if (coef_addr_ex3 < 8'd106) begin 
        int_y = (op_5 > {9'b0, atan_coef_c_ex3}) ? (op_5 - {9'b0, atan_coef_c_ex3}) : 'b0;
      end else begin 
        int_y = op_5 + atan_coef_c_ex3;
      end 
    end else begin 
      int_y = 'b0;
    end  
  end
  always @ (*) begin 
    if (int_y[28]) begin 
      y_expo = 8'd28 + 8'd127;
      y_frac = int_y[27:5];
    end else if (int_y[27]) begin 
      y_expo = 8'd27 + 8'd127;
      y_frac = int_y[26:4];
    end else if (int_y[26]) begin 
      y_expo = 8'd26 + 8'd127;
      y_frac = int_y[25:3];
    end else if (int_y[25]) begin 
      y_expo = 8'd25 + 8'd127;
      y_frac = int_y[24:2];
    end else if (int_y[24]) begin 
      y_expo = 8'd24 + 8'd127;
      y_frac = int_y[23:1];
    end else if (int_y[23]) begin 
      y_expo = 8'd23 + 8'd127;
      y_frac = int_y[22:0];
    end else if (int_y[22]) begin 
      y_expo = 8'd22 + 8'd127;
      y_frac[22:1] = int_y[21:0];
      y_frac[0] = 'd0;
    end else if (int_y[21]) begin 
      y_expo = 8'd21 + 8'd127;
      y_frac[22:2] = int_y[20:0];
      y_frac[1:0] = 'd0;
    end else if (int_y[20]) begin 
      y_expo = 8'd20 + 8'd127;
      y_frac[22:3] = int_y[19:0];
      y_frac[2:0] = 'd0;
    end else if (int_y[19]) begin 
      y_expo = 8'd19 + 8'd127;
      y_frac[22:4] = int_y[18:0];
      y_frac[3:0] = 'd0;
    end else if (int_y[18]) begin 
      y_expo = 8'd18 + 8'd127;
      y_frac[22:5] = int_y[17:0];
      y_frac[4:0] = 'd0;
    end else if (int_y[17]) begin 
      y_expo = 8'd17 + 8'd127;
      y_frac[22:6] = int_y[16:0];
      y_frac[5:0] = 'd0;
    end else if (int_y[16]) begin 
      y_expo = 8'd16 + 8'd127;
      y_frac[22:7] = int_y[15:0];
      y_frac[6:0] = 'd0;
    end else if (int_y[15]) begin 
      y_expo = 8'd15 + 8'd127;
      y_frac[22:8] = int_y[14:0];
      y_frac[7:0] = 'd0;
    end else if (int_y[14]) begin 
      y_expo = 8'd14 + 8'd127;
      y_frac[22:9] = int_y[13:0];
      y_frac[8:0] = 'd0;
    end else if (int_y[13]) begin 
      y_expo = 8'd13 + 8'd127;
      y_frac[22:10] = int_y[12:0];
      y_frac[9:0] = 'd0;   
    end else if (int_y[12]) begin 
      y_expo = 8'd12 + 8'd127;
      y_frac[22:11] = int_y[11:0];
      y_frac[10:0] = 'd0;    
    end else if (int_y[11]) begin 
      y_expo = 8'd11 + 8'd127;
      y_frac[22:12] = int_y[10:0];
      y_frac[11:0] = 'd0;    
    end else if (int_y[10]) begin 
      y_expo = 8'd10 + 8'd127;
      y_frac[22:13] = int_y[9:0];
      y_frac[12:0] = 'd0;    
    end else if (int_y[9]) begin 
      y_expo = 8'd9 + 8'd127;
      y_frac[22:14] = int_y[8:0];
      y_frac[13:0] = 'd0;    
    end else if (int_y[8]) begin 
      y_expo = 8'd8 + 8'd127;
      y_frac[22:15] = int_y[7:0];
      y_frac[14:0] = 'd0;
    end else if (int_y[7]) begin 
      y_expo = 8'd7 + 8'd127;
      y_frac[22:16] = int_y[6:0];
      y_frac[15:0] = 'd0;
    end else if (int_y[6]) begin 
      y_expo = 8'd6 + 8'd127;
      y_frac[22:17] = int_y[5:0];
      y_frac[16:0] = 'd0;   
    end else if (int_y[5]) begin 
      y_expo = 8'd5 + 8'd127;
      y_frac[22:18] = int_y[4:0];
      y_frac[17:0] = 'd0;   
    end else if (int_y[4]) begin 
      y_expo = 8'd4 + 8'd127;
      y_frac[22:19] = int_y[3:0];
      y_frac[18:0] = 'd0;  
    end else if (int_y[3]) begin 
      y_expo = 8'd3 + 8'd127;
      y_frac[22:20] = int_y[2:0];
      y_frac[19:0] = 'd0;    
    end else if (int_y[2]) begin 
      y_expo = 8'd2 + 8'd127;
      y_frac[22:21] = int_y[1:0];
      y_frac[20:0] = 'd0;    
    end else if (int_y[1]) begin 
      y_expo = 8'd1 + 8'd127;
      y_frac[22] = int_y[0];
      y_frac[21:0] = 'd0;    
    end else if (int_y[0]) begin 
      y_expo = 8'd0 + 8'd127;
      y_frac = 'd0;  
    end else begin  
      y_expo = 'd0;
      y_frac = 'd0;
    end 
  end
  
  always @ (*) begin
    if (sin_en_ex3) begin
      if (flag_ulti_ex3 == 2'b01) begin  
        float_expo = 8'd0;
        float_frac = 23'd0;
      end else if (flag_ulti_ex3 == 2'b10) begin 
        float_expo = 8'd127;
        float_frac = 23'd0;
      end else begin 
        float_expo = (y_expo > 8'd26) ? (y_expo - 8'd26) : 'b0;  
        float_frac = y_frac; 
      end 
    end else if (cos_en_ex3) begin 
      if (flag_ulti_ex3 == 2'b01) begin 
        float_expo = 8'd0;
        float_frac = 23'd0;
      end else if (flag_ulti_ex3 == 2'b10) begin 
        float_expo = 8'd127;
        float_frac = 23'd0;
      end else begin 
        float_expo = (y_expo > 8'd26) ? (y_expo - 8'd26) : 'b0;  
        float_frac = y_frac; 
      end 
    end else if (atan_en_ex3) begin 
      float_expo = (y_expo > 8'd30) ? (y_expo - 8'd30) : 'b0;  
      float_frac = y_frac;
    end else begin 
      float_expo = 'b0;
      float_frac = 'b0;
    end  
  end
 // In special situation, output is fixed.
  always @ (*) begin
    if (sin_en_ex3) begin
      if (expo_ex3 == 8'd102) begin 
        float_y_0 = {sign_o_ex3, 31'h343a0000};
      end else if (expo_ex3 == 8'd101) begin
        float_y_0 = {sign_o_ex3, 31'h33ac0000}; 
      end else if (expo_ex3 == 8'd100) begin 
        float_y_0 = {sign_o_ex3, 31'h330c0000};
      end else if (expo_ex3 == 8'd99) begin
        float_y_0 = {sign_o_ex3, 31'h32200000};
      end else if (expo_ex3 == 8'd98) begin
        if (frac_ex3[22:21] == 'b0) begin  
          float_y_0 = 'b0;
        end else begin 
          float_y_0 = {sign_o_ex3, 31'h31400000};
        end 
      end else if (expo_ex3 <= 8'd97) begin 
        float_y_0 = 32'h0;
      end else begin
        if ({float_expo, float_frac} == 'b0) begin 
          float_y_0 = 'b0;
        end else begin   
          float_y_0 = {sign_o_ex3, float_expo, float_frac};
        end 
      end
    end else if (cos_en_ex3) begin 
      if ((expo_ex3 == 8'd149) && frac_ex3[0]) begin 
        float_y_0 = 32'hbf800000;
      end else if ((expo_ex3 == 8'd149) && !frac_ex3[0]) begin 
        float_y_0 = 32'h3f800000;
      end else if (expo_ex3 == 8'd114) begin 
        float_y_0 = 32'h3f7ffffb;
      end else if (expo_ex3 == 8'd113) begin 
        float_y_0 = 32'h3f7fffff;
      end else if (expo_ex3 <= 8'd112) begin 
        float_y_0 = 32'h3f800000;
      end else begin 
        if ({float_expo, float_frac} == 'b0) begin 
          float_y_0 = 'b0;
        end else begin 
          float_y_0 = {sign_o_ex3, float_expo, float_frac};
        end 
      end
    end else if (atan_en_ex3) begin 
      if (expo_ex3 >= 8'd127) begin 
        float_y_0 = {sign_o_ex3, 31'h3e000000}; // outside range 
      end else if (expo_ex3 == 8'd105) begin 
        float_y_0 = {sign_o_ex3, 31'h33240000};
      end else if (expo_ex3 == 8'd104) begin
        float_y_0 = {sign_o_ex3, 31'h32a00000};
      end else if (expo_ex3 == 8'd103) begin 
        float_y_0 = {sign_o_ex3, 31'h32200000};
      end else if (expo_ex3 == 8'd102) begin
        float_y_0 = {sign_o_ex3, 31'h31a00000};
      end else if (expo_ex3 == 8'd101) begin
        float_y_0 = {sign_o_ex3, 31'h31400000};
      end else if (expo_ex3 == 8'd100) begin
        float_y_0 = {sign_o_ex3, 31'h30800000};
      end else if (expo_ex3 == 8'd99) begin
        float_y_0 = {sign_o_ex3, 31'h30800000};
      end else if (expo_ex3 <= 8'd98) begin
        float_y_0 = 'b0;
      end else begin 
        if ({float_expo, float_frac} == 'b0) begin 
          float_y_0 = 'b0;
        end else begin 
          float_y_0 = {sign_o_ex3, float_expo, float_frac};
        end 
      end 
    end else begin 
      float_y_0 = 'b0;
    end  
  end

  always @ (*) begin
    if (atan_en_ex3 && (expo_ex3 >= 8'd127)) begin 
      lvf_flag = 1'b1;
    end else begin 
      lvf_flag = 1'b0;
    end  
  end 

  assign float_y = float_y_0; 

endmodule 