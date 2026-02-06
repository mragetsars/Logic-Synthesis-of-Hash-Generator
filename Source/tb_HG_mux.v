`timescale 1ns / 1ps

module tb_HG_mux;

    parameter WIDTH = 32;

    reg [WIDTH-1:0] in1;
    reg [WIDTH-1:0] in2;
    reg [WIDTH-1:0] in3;
    reg [WIDTH-1:0] in4;
    reg [1:0] sel;

    wire [WIDTH-1:0] out;

    HG_mux #(
        .WIDTH(WIDTH)
    ) uut (
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .sel(sel),
        .out(out)
    );

    initial begin
        in1 = 0;
        in2 = 0;
        in3 = 0;
        in4 = 0;
        sel = 0;
        #20;

        in1 = 32'hAAAAAAAA;
        in2 = 32'hBBBBBBBB;
        in3 = 32'hCCCCCCCC;
        in4 = 32'hDDDDDDDD;

        sel = 2'b00;
        #20;

        sel = 2'b01;
        #20;

        sel = 2'b10;
        #20;

        sel = 2'b11;
        #20;

        in1 = 32'd100;
        in2 = 32'd200;
        in3 = 32'd300;
        in4 = 32'd400;

        sel = 2'b00;
        #10;
        sel = 2'b01;
        #10;
        sel = 2'b10;
        #10;
        sel = 2'b11;
        #10;

        in1 = $random;
        in2 = $random;
        in3 = $random;
        in4 = $random;
        sel = $random;
        #20;

        $stop;
    end

endmodule