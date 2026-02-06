`timescale 1ns/1ps

module tb_HG_top_module;

    parameter integer WIDTH = 32; //!
    localparam integer WORD  = WIDTH / 4; // 32 / 4 = 8 //!
    localparam MEM_PATH = "k.mem"; //!
    parameter A_reg_INIT = 8'h01; //!
    parameter B_reg_INIT = 8'h89; //!
    parameter C_reg_INIT = 8'hfe; //!
    parameter D_reg_INIT = 8'h76; //!
    reg clk;
    reg rst;
    reg start;
    reg [WIDTH-1:0] in_put;

    wire done;
    wire [WIDTH-1:0] out_put;

    integer wait_cycles;

    HG_top_module #(.WIDTH(WIDTH),
                .MEM_PATH(MEM_PATH),
                .A_reg_INIT(A_reg_INIT),
                .B_reg_INIT(B_reg_INIT),
                .C_reg_INIT(C_reg_INIT),
                .D_reg_INIT(D_reg_INIT)
                ) DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .in_put(in_put),
        .done(done),
        .out_put(out_put)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        rst   = 1'b1;
        start = 1'b0;

        in_put = 32'hdf01f0b7;

        #25;
        rst = 1'b0;

        #20;
        start = 1'b1;
        #20
        start = 1'b0;

        wait_cycles = 0;
        while (!done && wait_cycles < 10000) begin
            @(posedge clk);
            wait_cycles = wait_cycles + 1;
        end

        if (done) begin
            $display("Simulation finished: done asserted after %0d cycles.", wait_cycles);
            $display("out_put = %0h", out_put);
        end else begin
            $display("Timeout: 'done' not asserted after %0d cycles. Increase timeout or check controller.", wait_cycles);
        end

        #10;
        $stop;
    end

endmodule
