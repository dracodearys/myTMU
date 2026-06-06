//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: est_sqrt_and_enivf_table.sv
//  Creating Date: Thu 14 Dec 2023 08:48:23 AM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Mon 19 Feb 2024 03:20:48 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module est_sqrt_and_einvf_table #(                                                                                                                           
                            parameter DEPTH=128,WIDTH=40                                                                                                             
)                                                                                                                                                                                                                                                                                  
(                                                                                                                                          
                     input logic table_en,
                     input logic exp_low,                                                                                         
                     input logic[7:0] man_check,                                                                                            
                     //                                                                                                                    
                     output logic[7:0]  man_est_eisqrt,
                     output logic[15:0] man_est_einvf,
                     output logic[7:0]  man_est_eisqrt_s,
                     output logic[15:0] man_est_einvf_s                                                                                       
);




logic [WIDTH-1:0]eisqrtf_table0[0:DEPTH-1];
logic [WIDTH-1:0]eisqrtf_table1[0:DEPTH-1];

//table0
assign eisqrtf_table0 [0]    =  {8'b10110101,16'h7FF9,16'h8164}; 
assign eisqrtf_table0 [1]    =  {8'b10110100,16'h7E90,16'h7FF9}; 
assign eisqrtf_table0 [2]    =  {8'b10110100,16'h7E90,16'h7FF9}; 
assign eisqrtf_table0 [3]    =  {8'b10110011,16'h7D29,16'h7E90}; 
assign eisqrtf_table0 [4]    =  {8'b10110010,16'h7BC4,16'h7D29}; 
assign eisqrtf_table0 [5]    =  {8'b10110010,16'h7BC4,16'h7D29}; 
assign eisqrtf_table0 [6]    =  {8'b10110001,16'h7A61,16'h7BC4}; 
assign eisqrtf_table0 [7]    =  {8'b10110000,16'h7900,16'h7A61}; 
assign eisqrtf_table0 [8]    =  {8'b10110000,16'h7900,16'h7A61}; 
assign eisqrtf_table0 [9]    =  {8'b10101111,16'h77A1,16'h7900}; 
assign eisqrtf_table0 [10]   =  {8'b10101110,16'h7644,16'h77A1}; 
assign eisqrtf_table0 [11]   =  {8'b10101110,16'h7644,16'h77A1}; 
assign eisqrtf_table0 [12]   =  {8'b10101101,16'h74E9,16'h7644}; 
assign eisqrtf_table0 [13]   =  {8'b10101100,16'h7390,16'h74E9}; 
assign eisqrtf_table0 [14]   =  {8'b10101100,16'h7390,16'h74E9}; 
assign eisqrtf_table0 [15]   =  {8'b10101011,16'h7239,16'h7390}; 
assign eisqrtf_table0 [16]   =  {8'b10101011,16'h7239,16'h7390}; 
assign eisqrtf_table0 [17]   =  {8'b10101010,16'h70E4,16'h7239}; 
assign eisqrtf_table0 [18]   =  {8'b10101001,16'h6F91,16'h70E4}; 
assign eisqrtf_table0 [19]   =  {8'b10101001,16'h6F91,16'h70E4}; 
assign eisqrtf_table0 [20]   =  {8'b10101000,16'h6E40,16'h6F91}; 
assign eisqrtf_table0 [21]   =  {8'b10101000,16'h6E40,16'h6F91}; 
assign eisqrtf_table0 [22]   =  {8'b10100111,16'h6CF1,16'h6E40}; 
assign eisqrtf_table0 [23]   =  {8'b10100111,16'h6CF1,16'h6E40}; 
assign eisqrtf_table0 [24]   =  {8'b10100110,16'h6BA4,16'h6CF1}; 
assign eisqrtf_table0 [25]   =  {8'b10100110,16'h6BA4,16'h6CF1}; 
assign eisqrtf_table0 [26]   =  {8'b10100101,16'h6A59,16'h6BA4}; 
assign eisqrtf_table0 [27]   =  {8'b10100100,16'h6910,16'h6A59}; 
assign eisqrtf_table0 [28]   =  {8'b10100100,16'h6910,16'h6A59}; 
assign eisqrtf_table0 [29]   =  {8'b10100011,16'h67C9,16'h6910}; 
assign eisqrtf_table0 [30]   =  {8'b10100011,16'h67C9,16'h6910}; 
assign eisqrtf_table0 [31]   =  {8'b10100010,16'h6684,16'h67C9}; 
assign eisqrtf_table0 [32]   =  {8'b10100010,16'h6684,16'h67C9}; 
assign eisqrtf_table0 [33]   =  {8'b10100001,16'h6541,16'h6684}; 
assign eisqrtf_table0 [34]   =  {8'b10100001,16'h6541,16'h6684}; 
assign eisqrtf_table0 [35]   =  {8'b10100000,16'h6400,16'h6541}; 
assign eisqrtf_table0 [36]   =  {8'b10100000,16'h6400,16'h6541}; 
assign eisqrtf_table0 [37]   =  {8'b10011111,16'h62C1,16'h6400}; 
assign eisqrtf_table0 [38]   =  {8'b10011111,16'h62C1,16'h6400}; 
assign eisqrtf_table0 [39]   =  {8'b10011110,16'h6184,16'h62C1}; 
assign eisqrtf_table0 [40]   =  {8'b10011110,16'h6184,16'h62C1}; 
assign eisqrtf_table0 [41]   =  {8'b10011110,16'h6184,16'h62C1}; 
assign eisqrtf_table0 [42]   =  {8'b10011101,16'h6049,16'h6184}; 
assign eisqrtf_table0 [43]   =  {8'b10011101,16'h6049,16'h6184}; 
assign eisqrtf_table0 [44]   =  {8'b10011100,16'h5F10,16'h6049}; 
assign eisqrtf_table0 [45]   =  {8'b10011100,16'h5F10,16'h6049}; 
assign eisqrtf_table0 [46]   =  {8'b10011011,16'h5DD9,16'h5F10}; 
assign eisqrtf_table0 [47]   =  {8'b10011011,16'h5DD9,16'h5F10}; 
assign eisqrtf_table0 [48]   =  {8'b10011010,16'h5CA4,16'h5DD9}; 
assign eisqrtf_table0 [49]   =  {8'b10011010,16'h5CA4,16'h5DD9}; 
assign eisqrtf_table0 [50]   =  {8'b10011010,16'h5CA4,16'h5DD9}; 
assign eisqrtf_table0 [51]   =  {8'b10011001,16'h5B71,16'h5CA4}; 
assign eisqrtf_table0 [52]   =  {8'b10011001,16'h5B71,16'h5CA4}; 
assign eisqrtf_table0 [53]   =  {8'b10011000,16'h5A40,16'h5B71}; 
assign eisqrtf_table0 [54]   =  {8'b10011000,16'h5A40,16'h5B71}; 
assign eisqrtf_table0 [55]   =  {8'b10010111,16'h5911,16'h5A40}; 
assign eisqrtf_table0 [56]   =  {8'b10010111,16'h5911,16'h5A40}; 
assign eisqrtf_table0 [57]   =  {8'b10010111,16'h5911,16'h5A40}; 
assign eisqrtf_table0 [58]   =  {8'b10010110,16'h57E4,16'h5911}; 
assign eisqrtf_table0 [59]   =  {8'b10010110,16'h57E4,16'h5911}; 
assign eisqrtf_table0 [60]   =  {8'b10010101,16'h56B9,16'h57E4}; 
assign eisqrtf_table0 [61]   =  {8'b10010101,16'h56B9,16'h57E4}; 
assign eisqrtf_table0 [62]   =  {8'b10010101,16'h56B9,16'h57E4}; 
assign eisqrtf_table0 [63]   =  {8'b10010100,16'h5590,16'h56B9}; 
assign eisqrtf_table0 [64]   =  {8'b10010100,16'h5590,16'h56B9}; 
assign eisqrtf_table0 [65]   =  {8'b10010011,16'h5469,16'h5590}; 
assign eisqrtf_table0 [66]   =  {8'b10010011,16'h5469,16'h5590}; 
assign eisqrtf_table0 [67]   =  {8'b10010011,16'h5469,16'h5590}; 
assign eisqrtf_table0 [68]   =  {8'b10010010,16'h5344,16'h5469}; 
assign eisqrtf_table0 [69]   =  {8'b10010010,16'h5344,16'h5469}; 
assign eisqrtf_table0 [70]   =  {8'b10010010,16'h5344,16'h5469}; 
assign eisqrtf_table0 [71]   =  {8'b10010001,16'h5221,16'h5344}; 
assign eisqrtf_table0 [72]   =  {8'b10010001,16'h5221,16'h5344}; 
assign eisqrtf_table0 [73]   =  {8'b10010000,16'h5100,16'h5221}; 
assign eisqrtf_table0 [74]   =  {8'b10010000,16'h5100,16'h5221}; 
assign eisqrtf_table0 [75]   =  {8'b10010000,16'h5100,16'h5221}; 
assign eisqrtf_table0 [76]   =  {8'b10001111,16'h4FE1,16'h5100}; 
assign eisqrtf_table0 [77]   =  {8'b10001111,16'h4FE1,16'h5100}; 
assign eisqrtf_table0 [78]   =  {8'b10001111,16'h4FE1,16'h5100}; 
assign eisqrtf_table0 [79]   =  {8'b10001110,16'h4EC4,16'h4FE1}; 
assign eisqrtf_table0 [80]   =  {8'b10001110,16'h4EC4,16'h4FE1}; 
assign eisqrtf_table0 [81]   =  {8'b10001110,16'h4EC4,16'h4FE1}; 
assign eisqrtf_table0 [82]   =  {8'b10001101,16'h4DA9,16'h4EC4}; 
assign eisqrtf_table0 [83]   =  {8'b10001101,16'h4DA9,16'h4EC4}; 
assign eisqrtf_table0 [84]   =  {8'b10001101,16'h4DA9,16'h4EC4}; 
assign eisqrtf_table0 [85]   =  {8'b10001100,16'h4C90,16'h4DA9}; 
assign eisqrtf_table0 [86]   =  {8'b10001100,16'h4C90,16'h4DA9}; 
assign eisqrtf_table0 [87]   =  {8'b10001100,16'h4C90,16'h4DA9}; 
assign eisqrtf_table0 [88]   =  {8'b10001011,16'h4B79,16'h4C90}; 
assign eisqrtf_table0 [89]   =  {8'b10001011,16'h4B79,16'h4C90}; 
assign eisqrtf_table0 [90]   =  {8'b10001011,16'h4B79,16'h4C90}; 
assign eisqrtf_table0 [91]   =  {8'b10001010,16'h4A64,16'h4B79}; 
assign eisqrtf_table0 [92]   =  {8'b10001010,16'h4A64,16'h4B79}; 
assign eisqrtf_table0 [93]   =  {8'b10001010,16'h4A64,16'h4B79}; 
assign eisqrtf_table0 [94]   =  {8'b10001001,16'h4951,16'h4A64}; 
assign eisqrtf_table0 [95]   =  {8'b10001001,16'h4951,16'h4A64}; 
assign eisqrtf_table0 [96]   =  {8'b10001001,16'h4951,16'h4A64}; 
assign eisqrtf_table0 [97]   =  {8'b10001001,16'h4951,16'h4A64}; 
assign eisqrtf_table0 [98]   =  {8'b10001000,16'h4840,16'h4951}; 
assign eisqrtf_table0 [99]   =  {8'b10001000,16'h4840,16'h4951}; 
assign eisqrtf_table0 [100]  =  {8'b10001000,16'h4840,16'h4951}; 
assign eisqrtf_table0 [101]  =  {8'b10000111,16'h4731,16'h4840}; 
assign eisqrtf_table0 [102]  =  {8'b10000111,16'h4731,16'h4840}; 
assign eisqrtf_table0 [103]  =  {8'b10000111,16'h4731,16'h4840}; 
assign eisqrtf_table0 [104]  =  {8'b10000110,16'h4624,16'h4731}; 
assign eisqrtf_table0 [105]  =  {8'b10000110,16'h4624,16'h4731}; 
assign eisqrtf_table0 [106]  =  {8'b10000110,16'h4624,16'h4731}; 
assign eisqrtf_table0 [107]  =  {8'b10000110,16'h4624,16'h4731}; 
assign eisqrtf_table0 [108]  =  {8'b10000101,16'h4519,16'h4624}; 
assign eisqrtf_table0 [109]  =  {8'b10000101,16'h4519,16'h4624}; 
assign eisqrtf_table0 [110]  =  {8'b10000101,16'h4519,16'h4624}; 
assign eisqrtf_table0 [111]  =  {8'b10000100,16'h4410,16'h4519}; 
assign eisqrtf_table0 [112]  =  {8'b10000100,16'h4410,16'h4519}; 
assign eisqrtf_table0 [113]  =  {8'b10000100,16'h4410,16'h4519}; 
assign eisqrtf_table0 [114]  =  {8'b10000100,16'h4410,16'h4519}; 
assign eisqrtf_table0 [115]  =  {8'b10000011,16'h4309,16'h4410}; 
assign eisqrtf_table0 [116]  =  {8'b10000011,16'h4309,16'h4410}; 
assign eisqrtf_table0 [117]  =  {8'b10000011,16'h4309,16'h4410}; 
assign eisqrtf_table0 [118]  =  {8'b10000011,16'h4309,16'h4410}; 
assign eisqrtf_table0 [119]  =  {8'b10000010,16'h4204,16'h4309}; 
assign eisqrtf_table0 [120]  =  {8'b10000010,16'h4204,16'h4309}; 
assign eisqrtf_table0 [121]  =  {8'b10000010,16'h4204,16'h4309}; 
assign eisqrtf_table0 [122]  =  {8'b10000010,16'h4204,16'h4309}; 
assign eisqrtf_table0 [123]  =  {8'b10000001,16'h4101,16'h4204}; 
assign eisqrtf_table0 [124]  =  {8'b10000001,16'h4101,16'h4204}; 
assign eisqrtf_table0 [125]  =  {8'b10000001,16'h4101,16'h4204}; 
assign eisqrtf_table0 [126]  =  {8'b10000001,16'h4101,16'h4204}; 
assign eisqrtf_table0 [127]  =  {8'b10000000,16'h4000,16'h4101};

//table1
assign eisqrtf_table1 [0]    =  {8'b10000000,16'h4000,16'h4101}; 
assign eisqrtf_table1 [1]    =  {8'b11111111,16'hFE01,16'h4000}; 
assign eisqrtf_table1 [2]    =  {8'b11111110,16'hFC04,16'hFE01}; 
assign eisqrtf_table1 [3]    =  {8'b11111101,16'hFA09,16'hFC04}; 
assign eisqrtf_table1 [4]    =  {8'b11111100,16'hF810,16'hFA09}; 
assign eisqrtf_table1 [5]    =  {8'b11111011,16'hF619,16'hF810}; 
assign eisqrtf_table1 [6]    =  {8'b11111010,16'hF424,16'hF619}; 
assign eisqrtf_table1 [7]    =  {8'b11111001,16'hF231,16'hF424}; 
assign eisqrtf_table1 [8]    =  {8'b11111000,16'hF040,16'hF231}; 
assign eisqrtf_table1 [9]    =  {8'b11110111,16'hEE51,16'hF040}; 
assign eisqrtf_table1 [10]   =  {8'b11110111,16'hEE51,16'hF040}; 
assign eisqrtf_table1 [11]   =  {8'b11110110,16'hEC64,16'hEE51}; 
assign eisqrtf_table1 [12]   =  {8'b11110101,16'hEA79,16'hEC64}; 
assign eisqrtf_table1 [13]   =  {8'b11110100,16'hE890,16'hEA79}; 
assign eisqrtf_table1 [14]   =  {8'b11110011,16'hE6A9,16'hE890}; 
assign eisqrtf_table1 [15]   =  {8'b11110010,16'hE4C4,16'hE6A9}; 
assign eisqrtf_table1 [16]   =  {8'b11110001,16'hE2E1,16'hE4C4}; 
assign eisqrtf_table1 [17]   =  {8'b11110001,16'hE2E1,16'hE4C4}; 
assign eisqrtf_table1 [18]   =  {8'b11110000,16'hE100,16'hE2E1}; 
assign eisqrtf_table1 [19]   =  {8'b11101111,16'hDF21,16'hE100}; 
assign eisqrtf_table1 [20]   =  {8'b11101110,16'hDD44,16'hDF21}; 
assign eisqrtf_table1 [21]   =  {8'b11101101,16'hDB69,16'hDD44}; 
assign eisqrtf_table1 [22]   =  {8'b11101100,16'hD990,16'hDB69}; 
assign eisqrtf_table1 [23]   =  {8'b11101100,16'hD990,16'hDB69}; 
assign eisqrtf_table1 [24]   =  {8'b11101011,16'hD7B9,16'hD990}; 
assign eisqrtf_table1 [25]   =  {8'b11101010,16'hD5E4,16'hD7B9}; 
assign eisqrtf_table1 [26]   =  {8'b11101001,16'hD411,16'hD5E4}; 
assign eisqrtf_table1 [27]   =  {8'b11101001,16'hD411,16'hD5E4}; 
assign eisqrtf_table1 [28]   =  {8'b11101000,16'hD240,16'hD411}; 
assign eisqrtf_table1 [29]   =  {8'b11100111,16'hD071,16'hD240}; 
assign eisqrtf_table1 [30]   =  {8'b11100110,16'hCEA4,16'hD071}; 
assign eisqrtf_table1 [31]   =  {8'b11100110,16'hCEA4,16'hD071}; 
assign eisqrtf_table1 [32]   =  {8'b11100101,16'hCCD9,16'hCEA4}; 
assign eisqrtf_table1 [33]   =  {8'b11100100,16'hCB10,16'hCCD9}; 
assign eisqrtf_table1 [34]   =  {8'b11100100,16'hCB10,16'hCCD9}; 
assign eisqrtf_table1 [35]   =  {8'b11100011,16'hC949,16'hCB10}; 
assign eisqrtf_table1 [36]   =  {8'b11100010,16'hC784,16'hC949}; 
assign eisqrtf_table1 [37]   =  {8'b11100001,16'hC5C1,16'hC784}; 
assign eisqrtf_table1 [38]   =  {8'b11100001,16'hC5C1,16'hC784}; 
assign eisqrtf_table1 [39]   =  {8'b11100000,16'hC400,16'hC5C1}; 
assign eisqrtf_table1 [40]   =  {8'b11011111,16'hC241,16'hC400}; 
assign eisqrtf_table1 [41]   =  {8'b11011111,16'hC241,16'hC400}; 
assign eisqrtf_table1 [42]   =  {8'b11011110,16'hC084,16'hC241}; 
assign eisqrtf_table1 [43]   =  {8'b11011101,16'hBEC9,16'hC084}; 
assign eisqrtf_table1 [44]   =  {8'b11011101,16'hBEC9,16'hC084}; 
assign eisqrtf_table1 [45]   =  {8'b11011100,16'hBD10,16'hBEC9}; 
assign eisqrtf_table1 [46]   =  {8'b11011100,16'hBD10,16'hBEC9}; 
assign eisqrtf_table1 [47]   =  {8'b11011011,16'hBB59,16'hBD10}; 
assign eisqrtf_table1 [48]   =  {8'b11011010,16'hB9A4,16'hBB59}; 
assign eisqrtf_table1 [49]   =  {8'b11011010,16'hB9A4,16'hBB59}; 
assign eisqrtf_table1 [50]   =  {8'b11011001,16'hB7F1,16'hB9A4}; 
assign eisqrtf_table1 [51]   =  {8'b11011000,16'hB640,16'hB7F1}; 
assign eisqrtf_table1 [52]   =  {8'b11011000,16'hB640,16'hB7F1}; 
assign eisqrtf_table1 [53]   =  {8'b11010111,16'hB491,16'hB640}; 
assign eisqrtf_table1 [54]   =  {8'b11010111,16'hB491,16'hB640}; 
assign eisqrtf_table1 [55]   =  {8'b11010110,16'hB2E4,16'hB491}; 
assign eisqrtf_table1 [56]   =  {8'b11010110,16'hB2E4,16'hB491}; 
assign eisqrtf_table1 [57]   =  {8'b11010101,16'hB139,16'hB2E4}; 
assign eisqrtf_table1 [58]   =  {8'b11010100,16'hAF90,16'hB139}; 
assign eisqrtf_table1 [59]   =  {8'b11010100,16'hAF90,16'hB139}; 
assign eisqrtf_table1 [60]   =  {8'b11010011,16'hADE9,16'hAF90}; 
assign eisqrtf_table1 [61]   =  {8'b11010011,16'hADE9,16'hAF90}; 
assign eisqrtf_table1 [62]   =  {8'b11010010,16'hAC44,16'hADE9}; 
assign eisqrtf_table1 [63]   =  {8'b11010010,16'hAC44,16'hADE9}; 
assign eisqrtf_table1 [64]   =  {8'b11010001,16'hAAA1,16'hAC44}; 
assign eisqrtf_table1 [65]   =  {8'b11010000,16'hA900,16'hAAA1}; 
assign eisqrtf_table1 [66]   =  {8'b11010000,16'hA900,16'hAAA1}; 
assign eisqrtf_table1 [67]   =  {8'b11001111,16'hA761,16'hA900}; 
assign eisqrtf_table1 [68]   =  {8'b11001111,16'hA761,16'hA900}; 
assign eisqrtf_table1 [69]   =  {8'b11001110,16'hA5C4,16'hA761}; 
assign eisqrtf_table1 [70]   =  {8'b11001110,16'hA5C4,16'hA761}; 
assign eisqrtf_table1 [71]   =  {8'b11001101,16'hA429,16'hA5C4}; 
assign eisqrtf_table1 [72]   =  {8'b11001101,16'hA429,16'hA5C4}; 
assign eisqrtf_table1 [73]   =  {8'b11001100,16'hA290,16'hA429}; 
assign eisqrtf_table1 [74]   =  {8'b11001100,16'hA290,16'hA429}; 
assign eisqrtf_table1 [75]   =  {8'b11001011,16'hA0F9,16'hA290}; 
assign eisqrtf_table1 [76]   =  {8'b11001011,16'hA0F9,16'hA290}; 
assign eisqrtf_table1 [77]   =  {8'b11001010,16'h9F64,16'hA0F9}; 
assign eisqrtf_table1 [78]   =  {8'b11001010,16'h9F64,16'hA0F9}; 
assign eisqrtf_table1 [79]   =  {8'b11001001,16'h9DD1,16'h9F64}; 
assign eisqrtf_table1 [80]   =  {8'b11001001,16'h9DD1,16'h9F64}; 
assign eisqrtf_table1 [81]   =  {8'b11001000,16'h9C40,16'h9DD1}; 
assign eisqrtf_table1 [82]   =  {8'b11001000,16'h9C40,16'h9DD1}; 
assign eisqrtf_table1 [83]   =  {8'b11000111,16'h9AB1,16'h9C40}; 
assign eisqrtf_table1 [84]   =  {8'b11000111,16'h9AB1,16'h9C40}; 
assign eisqrtf_table1 [85]   =  {8'b11000110,16'h9924,16'h9AB1}; 
assign eisqrtf_table1 [86]   =  {8'b11000110,16'h9924,16'h9AB1}; 
assign eisqrtf_table1 [87]   =  {8'b11000110,16'h9924,16'h9AB1}; 
assign eisqrtf_table1 [88]   =  {8'b11000101,16'h9799,16'h9924}; 
assign eisqrtf_table1 [89]   =  {8'b11000101,16'h9799,16'h9924}; 
assign eisqrtf_table1 [90]   =  {8'b11000100,16'h9610,16'h9799}; 
assign eisqrtf_table1 [91]   =  {8'b11000100,16'h9610,16'h9799}; 
assign eisqrtf_table1 [92]   =  {8'b11000011,16'h9489,16'h9610}; 
assign eisqrtf_table1 [93]   =  {8'b11000011,16'h9489,16'h9610}; 
assign eisqrtf_table1 [94]   =  {8'b11000010,16'h9304,16'h9489}; 
assign eisqrtf_table1 [95]   =  {8'b11000010,16'h9304,16'h9489}; 
assign eisqrtf_table1 [96]   =  {8'b11000010,16'h9304,16'h9489}; 
assign eisqrtf_table1 [97]   =  {8'b11000001,16'h9181,16'h9304}; 
assign eisqrtf_table1 [98]   =  {8'b11000001,16'h9181,16'h9304}; 
assign eisqrtf_table1 [99]   =  {8'b11000000,16'h9000,16'h9181}; 
assign eisqrtf_table1 [100]  =  {8'b11000000,16'h9000,16'h9181}; 
assign eisqrtf_table1 [101]  =  {8'b10111111,16'h8E81,16'h9000}; 
assign eisqrtf_table1 [102]  =  {8'b10111111,16'h8E81,16'h9000}; 
assign eisqrtf_table1 [103]  =  {8'b10111111,16'h8E81,16'h9000}; 
assign eisqrtf_table1 [104]  =  {8'b10111110,16'h8D04,16'h8E81}; 
assign eisqrtf_table1 [105]  =  {8'b10111110,16'h8D04,16'h8E81}; 
assign eisqrtf_table1 [106]  =  {8'b10111101,16'h8B89,16'h8D04}; 
assign eisqrtf_table1 [107]  =  {8'b10111101,16'h8B89,16'h8D04}; 
assign eisqrtf_table1 [108]  =  {8'b10111101,16'h8B89,16'h8D04}; 
assign eisqrtf_table1 [109]  =  {8'b10111100,16'h8A10,16'h8B89}; 
assign eisqrtf_table1 [110]  =  {8'b10111100,16'h8A10,16'h8B89}; 
assign eisqrtf_table1 [111]  =  {8'b10111011,16'h8899,16'h8A10}; 
assign eisqrtf_table1 [112]  =  {8'b10111011,16'h8899,16'h8A10}; 
assign eisqrtf_table1 [113]  =  {8'b10111011,16'h8899,16'h8A10}; 
assign eisqrtf_table1 [114]  =  {8'b10111010,16'h8724,16'h8899}; 
assign eisqrtf_table1 [115]  =  {8'b10111010,16'h8724,16'h8899}; 
assign eisqrtf_table1 [116]  =  {8'b10111001,16'h85B1,16'h8724}; 
assign eisqrtf_table1 [117]  =  {8'b10111001,16'h85B1,16'h8724}; 
assign eisqrtf_table1 [118]  =  {8'b10111001,16'h85B1,16'h8724}; 
assign eisqrtf_table1 [119]  =  {8'b10111000,16'h8440,16'h85B1}; 
assign eisqrtf_table1 [120]  =  {8'b10111000,16'h8440,16'h85B1}; 
assign eisqrtf_table1 [121]  =  {8'b10111000,16'h8440,16'h85B1}; 
assign eisqrtf_table1 [122]  =  {8'b10110111,16'h82D1,16'h8440}; 
assign eisqrtf_table1 [123]  =  {8'b10110111,16'h82D1,16'h8440}; 
assign eisqrtf_table1 [124]  =  {8'b10110110,16'h8164,16'h82D1}; 
assign eisqrtf_table1 [125]  =  {8'b10110110,16'h8164,16'h82D1}; 
assign eisqrtf_table1 [126]  =  {8'b10110110,16'h8164,16'h82D1}; 
assign eisqrtf_table1 [127]  =  {8'b10110101,16'h7FF9,16'h8164};

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> old version <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//always_comb begin
//  if(table_en)begin  
//    if(!exp_low)begin
//      man_est_eisqrt   = eisqrtf_table0[man_check][39:32];
//      man_est_einvf    = eisqrtf_table0[man_check][31:16];
//      man_est_eisqrt_s = eisqrtf_table0[man_check][39:32] + 1'b1;
//      man_est_einvf_s  = eisqrtf_table0[man_check][15:0]; 
//    end
//    else begin
//      man_est_eisqrt   = eisqrtf_table1[man_check-8'h80][39:32];
//      man_est_einvf    = eisqrtf_table1[man_check-8'h80][31:16];
//      man_est_eisqrt_s = eisqrtf_table1[man_check-8'h80][39:32] + 1'b1;
//      man_est_einvf_s  = eisqrtf_table1[man_check-8'h80][15:0];
//    end
//  end
//  else begin
//    man_est_eisqrt       =  8'h0;
//    man_est_einvf        =  16'h0;
//    man_est_eisqrt_s     =  8'h0; 
//    man_est_einvf_s      =  16'h0;
//  end
//end
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> old version <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

logic[7:0]  man_est_eisqrt_mid;
logic[15:0] man_est_einvf_mid;
logic[8:0]  man_est_eisqrt_s_mid;//for the ff+1 = 00 case
logic[15:0] man_est_einvf_s_mid;

always_comb begin                                                      
  if(table_en)begin                                                    
    if(!exp_low)begin                                                  
      man_est_eisqrt_mid   = eisqrtf_table0[man_check][39:32];             
      man_est_einvf_mid    = eisqrtf_table0[man_check][31:16];             
      man_est_eisqrt_s_mid = eisqrtf_table0[man_check][39:32] + 1'b1;      
      man_est_einvf_s_mid  = eisqrtf_table0[man_check][15:0];              
    end                                                                
    else begin                                                         
      man_est_eisqrt_mid   = eisqrtf_table1[man_check-8'h80][39:32];       
      man_est_einvf_mid    = eisqrtf_table1[man_check-8'h80][31:16];       
      man_est_eisqrt_s_mid = eisqrtf_table1[man_check-8'h80][39:32] + 1'b1;
      man_est_einvf_s_mid  = eisqrtf_table1[man_check-8'h80][15:0];        
    end                                                                
  end                                                                  
  else begin                                                           
    man_est_eisqrt_mid       =  8'h0;                                      
    man_est_einvf_mid        =  16'h0;                                     
    man_est_eisqrt_s_mid     =  9'h0;                                      
    man_est_einvf_s_mid      =  16'h0;                                     
  end                                                                  
end                                                                    

assign man_est_eisqrt    =  man_est_eisqrt_mid;
assign man_est_einvf     =  man_est_einvf_mid; 
assign man_est_eisqrt_s  =  man_est_eisqrt_s_mid[8]? 8'h80 :  man_est_eisqrt_s_mid[7:0];
assign man_est_einvf_s   =  man_est_einvf_s_mid;



endmodule