//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: einvf_table.sv
//  Creating Date: Thu 26 Oct 2023 10:13:23 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Thu 26 Oct 2023 10:13:49 AM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module einvf_table#(
       parameter DEPTH=128,WIDTH=8
)
(
        input logic [7:0] partial_man,
        output logic [WIDTH-1:0] result_out

);

// label number
/*{
 8'h80,8'hfe,8'h82,8'h83,8'h84,8'h85,8'h86,8'h87,8'h88,8'h89,8'h8A,8'h8B,8'h8C,8'h8D,8'h8E,8'h8F
,8'h90,8'h91,8'h92,8'h93,8'h94,8'h95,8'h96,8'h97,8'h98,8'h99,8'h9A,8'h9B,8'h9C,8'h9D,8'h9E,8'h9F
,8'hA0,8'hA1,8'hA2,8'hA3,8'hA4,8'hA5,8'hA6,8'hA7,8'hA8,8'hA9,8'hAA,8'hAB,8'hAC,8'hAD,8'hAE,8'hAF
,8'hB0,8'hB1,8'hB2,8'hB3,8'hB4,8'hB5,8'hB6,8'hB7,8'hB8,8'hB9,8'hBA,8'hBB,8'hBC,8'hBD,8'hBE,8'hBF
,8'hC0,8'hC1,8'hC2,8'hC3,8'hC4,8'hC5,8'hC6,8'hC7,8'hC8,8'hC9,8'hCA,8'hCB,8'hCC,8'hCD,8'hCE,8'hCF
,8'hD0,8'hD1,8'hD2,8'hD3,8'hD4,8'hD5,8'hD6,8'hD7,8'hD8,8'hD9,8'hDA,8'hDB,8'hDC,8'hDD,8'hDE,8'hDF
,8'hE0,8'hE1,8'hE2,8'hE3,8'hE4,8'hE5,8'hE6,8'hE7,8'hE8,8'hE9,8'hEA,8'hEB,8'hEC,8'hED,8'hEE,8'hEF
,8'hF0,8'hF1,8'hF2,8'hF3,8'hF4,8'hF5,8'hF6,8'hF7,8'hF8,8'hF9,8'hFA,8'hFB,8'hFC,8'hFD,8'hFE,8'hFF

};*/
//reg [WIDTH-1:0]einvf_table[0:DEPTH-1]={
//
// 8'h80,8'hfe,8'hfc,8'hfa,8'hf8,8'hf6,8'hf5,8'hf3,8'hf1,8'hef,8'hed,8'hec,8'hea,8'he8,8'he7,8'he5
//,8'he4,8'he2,8'he0,8'hdf,8'hdd,8'hdc,8'hda,8'hd9,8'hd8,8'hd6,8'hd5,8'hd3,8'hd2,8'hd1,8'hcf,8'hce
//,8'hcd,8'hcc,8'hca,8'hc9,8'hc8,8'hc7,8'hc5,8'hc4,8'hc3,8'hc2,8'hc1,8'hc0,8'hbf,8'hbd,8'hbc,8'hbb
//,8'hba,8'hb9,8'hb8,8'hb7,8'hb6,8'hb5,8'hb4,8'hb3,8'hb2,8'hb1,8'hb0,8'haf,8'hae,8'had,8'hac,8'hac
//,8'hab,8'haa,8'ha9,8'ha8,8'ha7,8'ha6,8'ha5,8'ha5,8'ha4,8'ha3,8'ha2,8'ha1,8'ha1,8'ha0,8'h9f,8'h9e
//,8'h9e,8'h9d,8'h9c,8'h9b,8'h9b,8'h9a,8'h99,8'h98,8'h98,8'h97,8'h96,8'h96,8'h95,8'h94,8'h94,8'h93
//,8'h92,8'h92,8'h91,8'h90,8'h90,8'h8f,8'h8e,8'h8e,8'h8d,8'h8d,8'h8c,8'h8b,8'h8b,8'h8a,8'h8a,8'h89
//,8'h89,8'h88,8'h87,8'h87,8'h86,8'h86,8'h85,8'h85,8'h84,8'h84,8'h83,8'h83,8'h82,8'h82,8'h81,8'h81
//
//};
logic [WIDTH-1:0]einvf_table[0:DEPTH-1];

assign einvf_table[0]   = 8'h80;
assign einvf_table[1]   = 8'hfe;
assign einvf_table[2]   = 8'hfc;
assign einvf_table[3]   = 8'hfa;
assign einvf_table[4]   = 8'hf8;
assign einvf_table[5]   = 8'hf6;
assign einvf_table[6]   = 8'hf5;
assign einvf_table[7]   = 8'hf3;
assign einvf_table[8]   = 8'hf1;
assign einvf_table[9]   = 8'hef;
assign einvf_table[10]  = 8'hed;
assign einvf_table[11]  = 8'hec;
assign einvf_table[12]  = 8'hea;
assign einvf_table[13]  = 8'he8;
assign einvf_table[14]  = 8'he7;
assign einvf_table[15]  = 8'he5;
assign einvf_table[16]  = 8'he4;
assign einvf_table[17]  = 8'he2;
assign einvf_table[18]  = 8'he0;
assign einvf_table[19]  = 8'hdf;
assign einvf_table[20]  = 8'hdd;
assign einvf_table[21]  = 8'hdc;
assign einvf_table[22]  = 8'hda;
assign einvf_table[23]  = 8'hd9;
assign einvf_table[24]  = 8'hd8;
assign einvf_table[25]  = 8'hd6;
assign einvf_table[26]  = 8'hd5;
assign einvf_table[27]  = 8'hd3;
assign einvf_table[28]  = 8'hd2;
assign einvf_table[29]  = 8'hd1;
assign einvf_table[30]  = 8'hcf;
assign einvf_table[31]  = 8'hce;
assign einvf_table[32]  = 8'hcd;
assign einvf_table[33]  = 8'hcc;
assign einvf_table[34]  = 8'hca;
assign einvf_table[35]  = 8'hc9;
assign einvf_table[36]  = 8'hc8;
assign einvf_table[37]  = 8'hc7;
assign einvf_table[38]  = 8'hc5;
assign einvf_table[39]  = 8'hc4;
assign einvf_table[40]  = 8'hc3;
assign einvf_table[41]  = 8'hc2;
assign einvf_table[42]  = 8'hc1;
assign einvf_table[43]  = 8'hc0;
assign einvf_table[44]  = 8'hbf;
assign einvf_table[45]  = 8'hbd;
assign einvf_table[46]  = 8'hbc;
assign einvf_table[47]  = 8'hbb;
assign einvf_table[48]  = 8'hba;
assign einvf_table[49]  = 8'hb9;
assign einvf_table[50]  = 8'hb8;
assign einvf_table[51]  = 8'hb7;
assign einvf_table[52]  = 8'hb6;
assign einvf_table[53]  = 8'hb5;
assign einvf_table[54]  = 8'hb4;
assign einvf_table[55]  = 8'hb3;
assign einvf_table[56]  = 8'hb2;
assign einvf_table[57]  = 8'hb1;
assign einvf_table[58]  = 8'hb0;
assign einvf_table[59]  = 8'haf;
assign einvf_table[60]  = 8'hae;
assign einvf_table[61]  = 8'had;
assign einvf_table[62]  = 8'hac;
assign einvf_table[63]  = 8'hac;
assign einvf_table[64]  = 8'hab;
assign einvf_table[65]  = 8'haa;
assign einvf_table[66]  = 8'ha9;
assign einvf_table[67]  = 8'ha8;
assign einvf_table[68]  = 8'ha7;
assign einvf_table[69]  = 8'ha6;
assign einvf_table[70]  = 8'ha5;
assign einvf_table[71]  = 8'ha5;
assign einvf_table[72]  = 8'ha4;
assign einvf_table[73]  = 8'ha3;
assign einvf_table[74]  = 8'ha2;
assign einvf_table[75]  = 8'ha1;
assign einvf_table[76]  = 8'ha1;
assign einvf_table[77]  = 8'ha0;
assign einvf_table[78]  = 8'h9f;
assign einvf_table[79]  = 8'h9e;
assign einvf_table[80]  = 8'h9e;
assign einvf_table[81]  = 8'h9d;
assign einvf_table[82]  = 8'h9c;
assign einvf_table[83]  = 8'h9b;
assign einvf_table[84]  = 8'h9b;
assign einvf_table[85]  = 8'h9a;
assign einvf_table[86]  = 8'h99;
assign einvf_table[87]  = 8'h98;
assign einvf_table[88]  = 8'h98;
assign einvf_table[89]  = 8'h97;
assign einvf_table[90]  = 8'h96;
assign einvf_table[91]  = 8'h96;
assign einvf_table[92]  = 8'h95;
assign einvf_table[93]  = 8'h94;
assign einvf_table[94]  = 8'h94;
assign einvf_table[95]  = 8'h93;
assign einvf_table[96]  = 8'h92;
assign einvf_table[97]  = 8'h92;
assign einvf_table[98]  = 8'h91;
assign einvf_table[99]  = 8'h90;
assign einvf_table[100] = 8'h90;
assign einvf_table[101] = 8'h8f;
assign einvf_table[102] = 8'h8e;
assign einvf_table[103] = 8'h8e;
assign einvf_table[104] = 8'h8d;
assign einvf_table[105] = 8'h8d;
assign einvf_table[106] = 8'h8c;
assign einvf_table[107] = 8'h8b;
assign einvf_table[108] = 8'h8b;
assign einvf_table[109] = 8'h8a;
assign einvf_table[110] = 8'h8a;
assign einvf_table[111] = 8'h89;
assign einvf_table[112] = 8'h89;
assign einvf_table[113] = 8'h88;
assign einvf_table[114] = 8'h87;
assign einvf_table[115] = 8'h87;
assign einvf_table[116] = 8'h86;
assign einvf_table[117] = 8'h86;
assign einvf_table[118] = 8'h85;
assign einvf_table[119] = 8'h85;
assign einvf_table[120] = 8'h84;
assign einvf_table[121] = 8'h84;
assign einvf_table[122] = 8'h83;
assign einvf_table[123] = 8'h83;
assign einvf_table[124] = 8'h82;
assign einvf_table[125] = 8'h82;
assign einvf_table[126] = 8'h81;
assign einvf_table[127] = 8'h81;


always_comb begin
  if(partial_man<8'h80)begin
    result_out=8'h00;
  end
  else begin
    result_out=einvf_table[partial_man-8'h80];
  end
end

endmodule