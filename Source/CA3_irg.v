module CA3_irg (
    input  wire clk,
    input  wire rst,
    input  wire n_init,
    input  wire inc_1,
    input  wire inc_2,
    output wire out
);

    s2 irg_inst (
        .D00(1'b0), .D01(n_init), .D10(n_init), .D11(1'b0), 
        .A1(out), .B1(1'b0), 
        .A0(inc_1), .B0(inc_2), 
        .clr(rst), .clk(clk), .out(out)
    );

endmodule