//+FHDR------------------------------------------------------------
//------------------------------------------------------------
//  File Name: cla4bit.sv
//  Creating Date: Tue 02 Jan 2024 02:40:08 PM CST
//  Creating Author: sunhzh
//  Description:
//  Last Commit: Tue 02 Jan 2024 02:40:33 PM CST
//  Related Document Path:
//------------------------------------------------------------
//-FHDR------------------------------------------------------------

module cla4bit(
                  input [3:0]a,b,
                  input cin,
                  output [3:0]sum,
                  output cout
);

logic [3:0]p,g,c;

assign p=a^b;
assign g=a&b;

//carry=gi+Pi*ci

assign c[0]=cin;
assign c[1]=g[0] | (p[0]&c[0]);
assign c[2]=g[1] | (p[1]&g[0]) | (p[1]&p[0]&c[0]);
assign c[3]=g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&c[0]);
assign cout=g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
assign sum=p^c;

endmodule