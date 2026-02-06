`timescale 1ns / 1ps

module tb_HG_result;

    parameter integer WIDTH = 32;
    parameter integer WORD = WIDTH / 4;

    reg [WORD-1:0] A;
    reg [WORD-1:0] B;
    reg [WORD-1:0] C;
    reg [WORD-1:0] D;

    wire [WIDTH-1:0] out;

    HG_result #(
        .WIDTH(WIDTH),
        .WORD(WORD)
    ) uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .out(out)
    );

    initial begin
        A = 0;
        B = 0;
        C = 0;
        D = 0;
        #20;

        A = {WORD{1'b1}};
        B = {WORD{1'b0}};
        C = {WORD{1'b1}};
        D = {WORD{1'b0}};
        #20;

        A = 8'h11;
        B = 8'h22;
        C = 8'h33;
        D = 8'h44;
        #20;

        A = 8'hAA;
        B = 8'hBB;
        C = 8'hCC;
        D = 8'hDD;
        #20;

        A = 8'hDE;
        B = 8'hAD;
        C = 8'hBE;
        D = 8'hEF;
        #20;

        A = $random;
        B = $random;
        C = $random;
        D = $random;
        #20;

        $stop;
    end

endmodule