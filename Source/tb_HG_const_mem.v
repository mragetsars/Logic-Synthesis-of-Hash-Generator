`timescale 1ns / 1ps

module tb_HG_const_mem;

    parameter ADDR_WIDTH = 6;
    
    reg [ADDR_WIDTH-1:0] i_addr;
    wire [31:0] data;
    integer k;

    HG_const_mem #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .i_addr(i_addr),
        .data(data)
    );

    initial begin
        i_addr = 0;
        #20;

        for (k = 0; k < 16; k = k + 1) begin
            i_addr = k;
            #10;
        end

        i_addr = 32;
        #20;

        i_addr = 63;
        #20;

        i_addr = 10;
        #20;

        $stop;
    end

endmodule