module CA3_reg (
    input  wire clk,
    input  wire rst,
    input  wire seed,
    input  wire in,
    input  wire init,
    input  wire en_1,
    input  wire en_2,
    output wire out
);

    s2 reg_inst (
        .D00(out), .D01(in), .D10(seed), .D11(seed),
        .A1(init), .B1(1'b0),
        .A0(en_1), .B0(en_2),
        .clr(rst), .clk(clk), .out(out)
    );

endmodule