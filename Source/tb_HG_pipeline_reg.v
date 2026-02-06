`timescale 1ns / 1ps

module tb_HG_pipeline_reg;

    parameter WIDTH = 8;
    parameter [WIDTH-1:0] INIT = 8'h00;

    reg [WIDTH-1:0] d_in;
    reg load_enable;
    reg rst;
    reg clk;

    wire [WIDTH-1:0] q_out;

    HG_pipeline_reg #(
        .WIDTH(WIDTH),
        .INIT(INIT)
    ) uut (
        .d_in(d_in),
        .load_enable(load_enable),
        .rst(rst),
        .clk(clk),
        .q_out(q_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        load_enable = 0;
        d_in = 0;
        #20;

        rst = 0;
        #20;

        d_in = 8'hAA; 
        load_enable = 1;
        #10;

        d_in = 8'hBB; 
        load_enable = 0;
        #10;
        #10;

        load_enable = 1;
        #10;

        d_in = 8'h78; 
        load_enable = 1;
        #10;

        rst = 1;
        #10;

        rst = 0;
        load_enable = 1;
        d_in = $random;
        #10;

        d_in = $random;
        #10;

        $stop;
    end

endmodule