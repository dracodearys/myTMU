//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: pp32and17_wallacetree_sep0.sv
//  Creating Date: Mon 15 Jan 2024 10:42:00 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Mon 15 Jan 2024 03:05:07 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module pp32and17_wallacetree_sep0 (
                            output logic[65:0]o_sum,
                            output logic[65:0]o_carry,
                            //
                            input logic i_clk,
                            input logic i_reset_n,
                            input logic i_bus_stall_en,
                            input logic[35:0] i_a0,
                            input logic[36:0] i_b0,
                            input logic[36:0] i_a1,
                            input logic[36:0] i_b1,
                            input logic[36:0] i_a2,
                            input logic[36:0] i_b2,
                            input logic[36:0] i_a3,
                            input logic[36:0] i_b3,
                            input logic[36:0] i_a4,
                            input logic[36:0] i_b4,
                            input logic[36:0] i_a5,
                            input logic[36:0] i_b5,
                            input logic[36:0] i_a6,
                            input logic[36:0] i_b6,
                            input logic[36:0] i_a7,
                            input logic[36:0] i_b7,
                            input logic[34:0] i_a8
);

//first level
logic  [38:0] w_sum00;
logic  [37:0] w_carry00; 

logic  [40:0] w_sum01;
logic  [37:0] w_carry01; 

logic  [40:0] w_sum02;
logic  [37:0] w_carry02; 

logic  [40:0] w_sum03;
logic  [37:0] w_carry03;

logic  [40:0] w_sum04;
logic  [37:0] w_carry04;

mul32and17_wallace_csa_tree00 mul32and17_wallace_csa_tree00(//output
                                                            .o_sum(w_sum00),
                                                            .o_carry(w_carry00),
                                                            //input
                                                            .i_a(i_a0),
                                                            .i_b(i_b0),
                                                            .i_c(i_a1)
);
mul32and17_wallace_csa_tree01 mul32and17_wallace_csa_tree01(//output
                                                            .o_sum(w_sum01),
                                                            .o_carry(w_carry01),
                                                            //input
                                                            .i_a(i_b1),
                                                            .i_b(i_a2),
                                                            .i_c(i_b2)
);
mul32and17_wallace_csa_tree01 mul32and17_wallace_csa_tree02(//output
                                                            .o_sum(w_sum02),
                                                            .o_carry(w_carry02),
                                                            //input
                                                            .i_a(i_a3),
                                                            .i_b(i_b3),
                                                            .i_c(i_a4)
);
mul32and17_wallace_csa_tree01 mul32and17_wallace_csa_tree03(//output
                                                            .o_sum(w_sum03),
                                                            .o_carry(w_carry03),
                                                            //input
                                                            .i_a(i_b4),
                                                            .i_b(i_a5),
                                                            .i_c(i_b5)
);
mul32and17_wallace_csa_tree01 mul32and17_wallace_csa_tree04(//output
                                                            .o_sum(w_sum04),
                                                            .o_carry(w_carry04),
                                                            //input
                                                            .i_a(i_a6),
                                                            .i_b(i_b6),
                                                            .i_c(i_a7)
);

logic[38:0] w_sum00_ex1;  
logic[37:0] w_carry00_ex1;
logic[40:0] w_sum01_ex1;  
logic[37:0] w_carry01_ex1;
logic[40:0] w_sum02_ex1;  
logic[37:0] w_carry02_ex1;
logic[40:0] w_sum03_ex1;  
logic[37:0] w_carry03_ex1;
logic[40:0] w_sum04_ex1;  
logic[37:0] w_carry04_ex1;
logic[36:0] i_b7_ex1;
logic[34:0] i_a8_ex1;



always@(posedge i_clk or negedge i_reset_n)begin
  if(!i_reset_n)begin
    w_sum00_ex1   <= 38'h0;
    w_carry00_ex1 <= 37'h0;
    w_sum01_ex1   <= 40'h0;
    w_carry01_ex1 <= 37'h0;
    w_sum02_ex1   <= 40'h0;
    w_carry02_ex1 <= 37'h0;
    w_sum03_ex1   <= 40'h0;
    w_carry03_ex1 <= 37'h0;
    w_sum04_ex1   <= 40'h0;
    w_carry04_ex1 <= 37'h0;
    i_b7_ex1      <= 36'h0;
    i_a8_ex1      <= 34'h0;
  end
  else if(!i_bus_stall_en)begin
    w_sum00_ex1   <= w_sum00;
    w_carry00_ex1 <= w_carry00;
    w_sum01_ex1   <= w_sum01;
    w_carry01_ex1 <= w_carry01;
    w_sum02_ex1   <= w_sum02;
    w_carry02_ex1 <= w_carry02;
    w_sum03_ex1   <= w_sum03;
    w_carry03_ex1 <= w_carry03;
    w_sum04_ex1   <= w_sum04;
    w_carry04_ex1 <= w_carry04;
    i_b7_ex1      <= i_b7; 
    i_a8_ex1      <= i_a8; 
  end
end

//second level
logic [44:0] w_sum10;
logic [39:0] w_carry10;

logic [44:0] w_sum11;
logic [40:0] w_carry11;

logic [46:0] w_sum12;
logic [39:0] w_carry12;

logic [40:0] w_sum13;
logic [36:0] w_carry13;//specail due to i_c max bit 

mul32and17_wallace_csa_tree10 mul32and17_wallace_csa_tree10(//output
                                                          .o_sum(w_sum10),
                                                          .o_carry(w_carry10),
                                                          //input
                                                          .i_a(w_sum00_ex1),
                                                          .i_b(w_carry00_ex1),
                                                          .i_c(w_sum01_ex1)
);

mul32and17_wallace_csa_tree11 mul32and17_wallace_csa_tree11(//output
                                                          .o_sum(w_sum11),
                                                          .o_carry(w_carry11),
                                                          //input
                                                          .i_a(w_carry01_ex1),
                                                          .i_b(w_sum02_ex1),
                                                          .i_c(w_carry02_ex1)
);

mul32and17_wallace_csa_tree12 mul32and17_wallace_csa_tree12(//output
                                                          .o_sum(w_sum12),
                                                          .o_carry(w_carry12),
                                                          //input
                                                          .i_a(w_sum03_ex1),
                                                          .i_b(w_carry03_ex1),
                                                          .i_c(w_sum04_ex1)
);

mul32and17_wallace_csa_tree13 mul32and17_wallace_csa_tree13(//output
                                                          .o_sum(w_sum13),
                                                          .o_carry(w_carry13),
                                                          //input
                                                          .i_a(w_carry04_ex1),
                                                          .i_b(i_b7_ex1),
                                                          .i_c(i_a8_ex1)
);


//third level
logic[50:0] w_sum20; 
logic[45:0] w_carry20;

logic[52:0] w_sum21;
logic[42:0] w_carry21;

mul32and17_wallace_csa_tree20 mul32and17_wallace_csa_tree20(//output
                                                          .o_sum(w_sum20),
                                                          .o_carry(w_carry20),
                                                          //input
                                                          .i_a(w_sum10),
                                                          .i_b(w_carry10),
                                                          .i_c(w_sum11)
);

mul32and17_wallace_csa_tree21 mul32and17_wallace_csa_tree21(//output
                                                          .o_sum(w_sum21),
                                                          .o_carry(w_carry21),
                                                          //input
                                                          .i_a(w_carry11),
                                                          .i_b(w_sum12),
                                                          .i_c(w_carry12)
);


//fourth level
logic[62:0] w_sum30;
logic[51:0] w_carry30;

logic[48:0] w_sum31;
logic[41:0] w_carry31;

mul32and17_wallace_csa_tree30 mul32and17_wallace_csa_tree30(//output
                                                             .o_sum(w_sum30),
                                                             .o_carry(w_carry30),
                                                             //input
                                                             .i_a(w_sum20),
                                                             .i_b(w_carry20),
                                                             .i_c(w_sum21)
);

mul32and17_wallace_csa_tree31 mul32and17_wallace_csa_tree31(//output
                                                             .o_sum(w_sum31),
                                                             .o_carry(w_carry31),
                                                             //input
                                                             .i_a(w_carry21),
                                                             .i_b(w_sum13),
                                                             .i_c(w_carry13)
);

//fifth level
logic[64:0] w_sum40;
logic[63:0] w_carry40;

mul32and17_wallace_csa_tree40 mul32and17_wallace_csa_tree40(//output
                                                             .o_sum(w_sum40),
                                                             .o_carry(w_carry40),
                                                             //input
                                                             .i_a(w_sum30),
                                                             .i_b(w_carry30),
                                                             .i_c(w_sum31)
);

//sixth level
mul32and17_wallace_csa_tree50 mul32and17_wallace_csa_tree50(//output
                                                             .o_sum(o_sum),
                                                             .o_carry(o_carry),
                                                             //input
                                                             .i_a(w_sum40),
                                                             .i_b(w_carry40),
                                                             .i_c(w_carry31)
);


endmodule