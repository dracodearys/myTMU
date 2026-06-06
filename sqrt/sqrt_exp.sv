//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: sqrt_exp.sv
//  Creating Date: Thu 14 Dec 2023 10:25:17 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 14 Dec 2023 03:21:39 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module sqrt_exp (
                    input logic[7:0] i_exp,
                    //
                    output logic[7:0] o_final_exp,
                    output logic[7:0] o_exp_real,          //using for rouding
                    output logic      o_exp_real_pos_en   //using for rounding
);



logic exp_sign_judge;
logic[7:0] exp_real_pos;
logic[7:0] exp_real_neg;

assign {exp_sign_judge,exp_real_pos} = i_exp - 8'd127; 
assign exp_real_neg = 8'd127 - i_exp;

always_comb begin
    if(~exp_sign_judge)begin   //pos
        o_exp_real_pos_en = 1'b1;
        if(exp_real_pos[0])begin
            o_exp_real = ((exp_real_pos + 1'b1) >> 1'b1) - 1'b1;
            o_final_exp = 8'd127 + ((exp_real_pos + 1'b1) >> 1'b1) - 1'b1;
        end
        else begin
            o_exp_real = (exp_real_pos >> 1'b1);
            o_final_exp = 8'd127 + (exp_real_pos >> 1'b1);
        end
    end
    else begin               //neg
        o_exp_real_pos_en = 1'b0;
        if(exp_real_neg[0])begin 
            o_exp_real  = ((exp_real_neg - 1'b1) >> 1'b1) - 1'b1;
            o_final_exp = 8'd127 - ((exp_real_neg - 1'b1) >> 1'b1) - 1'b1;
        end
        else begin
            o_exp_real  = (exp_real_neg >> 1'b1);
            o_final_exp = 8'd127 - (exp_real_neg >> 1'b1);
        end
    end
end



    
endmodule