`timescale 1ns/1ps

module RND_tb_top_module;

    parameter REG_WIDTH = 6;
    parameter CNT_WIDTH = 3;

    reg clk;
    reg rst;
    reg start_rnd;
    reg [REG_WIDTH-1:0] seed;
    wire done_rnd;
    wire [1:0] x_out;

    RND_top_module #(
        .REG_WIDTH(REG_WIDTH),
        .CNT_WIDTH(CNT_WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .start_rnd(start_rnd),
        .seed(seed),
        .done_rnd(done_rnd),
        .x_out(x_out)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;
        start_rnd = 0;
        seed = 6'b000111;

        #25 rst = 0;

        #10 start_rnd = 1;
        #10 start_rnd = 0;

        #100;
        $stop;
    end

endmodule
