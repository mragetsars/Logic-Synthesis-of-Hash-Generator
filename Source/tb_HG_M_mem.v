`timescale 1ns / 1ps

module tb_HG_M_mem;

    parameter WIDTH = 128;

    reg clk;
    reg load_msg;
    reg [WIDTH-1:0] msg_in;

    wire [WIDTH/4-1:0] M_out_1;
    wire [WIDTH/4-1:0] M_out_2;
    wire [WIDTH/4-1:0] M_out_3;
    wire [WIDTH/4-1:0] M_out_4;

    HG_M_mem #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .load_msg(load_msg),
        .msg_in(msg_in),
        .M_out_1(M_out_1),
        .M_out_2(M_out_2),
        .M_out_3(M_out_3),
        .M_out_4(M_out_4)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        load_msg = 0;
        msg_in = 0;
        #20;

        load_msg = 1;
        msg_in = {WIDTH{1'b1}};
        #10;

        load_msg = 0;
        msg_in = 0;
        #20;

        load_msg = 1;
        msg_in = 128'h11111111222222223333333344444444;
        #10;

        load_msg = 0;
        msg_in = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        #20;

        load_msg = 1;
        msg_in = 128'hDEADBEEFCAFEBABE0123456789ABCDEF;
        #10;

        load_msg = 1;
        msg_in = $random;
        #10;
        
        msg_in = {$random, $random, $random, $random};
        #10;

        $stop;
    end

endmodule