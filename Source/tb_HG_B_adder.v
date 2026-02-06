`timescale 1ns / 1ps

module tb_HG_B_adder;

    parameter WIDTH = 8;

    reg [WIDTH-1:0] B_old;
    reg [WIDTH-1:0] rotF;

    wire [WIDTH-1:0] B_plus_rotF;

    HG_B_adder #(
        .WIDTH(WIDTH)
    ) uut (
        .B_old(B_old), 
        .rotF(rotF), 
        .B_plus_rotF(B_plus_rotF)
    );

    initial begin
        B_old = 0;
        rotF = 0;
        #20;

        B_old = 8'd10;
        rotF = 8'd20;
        #20;

        B_old = 8'hFF;
        rotF = 8'd1;
        #20;

        B_old = 8'd100;
        rotF = 8'd50;
        #20;

        B_old = $random;
        rotF = $random;
        #20;

        B_old = $random;
        rotF = $random;
        #20;

        $stop;
    end

endmodule