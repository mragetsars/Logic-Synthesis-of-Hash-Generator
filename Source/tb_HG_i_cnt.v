`timescale 1ns / 1ps

module tb_HG_i_cnt;

    parameter WIDTH = 6;

    reg clk;
    reg rst;
    reg inc;

    wire [WIDTH-1:0] i_out;
    wire i_is_all_one;

    HG_i_cnt #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .inc(inc),
        .i_out(i_out),
        .i_is_all_one(i_is_all_one)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        inc = 0;
        #20;

        rst = 0;
        #20;

        inc = 1;
        #700; 

        inc = 0;
        #40;

        inc = 1;
        #40;

        rst = 1;
        #20;

        rst = 0;
        #20;

        $stop;
    end

endmodule