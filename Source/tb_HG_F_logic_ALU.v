`timescale 1ns / 1ps

module tb_HG_F_logic_ALU;

    parameter WIDTH = 32;

    reg [WIDTH-1:0] B;
    reg [WIDTH-1:0] C;
    reg [WIDTH-1:0] D;
    reg [1:0] func_sel;

    wire [WIDTH-1:0] F_logic;

    HG_F_logic_ALU #(
        .WIDTH(WIDTH)
    ) uut (
        .B(B),
        .C(C),
        .D(D),
        .func_sel(func_sel),
        .F_logic(F_logic)
    );

    initial begin
        B = 0;
        C = 0;
        D = 0;
        func_sel = 0;
        #20;

        B = 32'hFFFFFFFF;
        C = 32'hAAAAAAAA;
        D = 32'h55555555;
        
        func_sel = 2'b00;
        #20;

        func_sel = 2'b01;
        #20;

        func_sel = 2'b10;
        #20;

        func_sel = 2'b11;
        #20;

        B = 32'hF0F0F0F0;
        C = 32'h0F0F0F0F;
        D = 32'hFFFF0000;

        func_sel = 2'b00;
        #20;

        func_sel = 2'b01;
        #20;

        func_sel = 2'b10;
        #20;

        func_sel = 2'b11;
        #20;

        B = $random;
        C = $random;
        D = $random;
        func_sel = $random;
        #20;

        B = $random;
        C = $random;
        D = $random;
        func_sel = $random;
        #20;

        $stop;
    end

endmodule