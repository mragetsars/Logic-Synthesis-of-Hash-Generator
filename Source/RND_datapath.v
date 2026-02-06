module RND_datapath #(
    parameter REG_WIDTH = 6,
    parameter CNT_WIDTH = 3
)(
    input  wire clk,
    input  wire rst,
    input  wire x_en,
    input  wire x_init,
    input  wire co_en,
    input  wire co_init,
    input  wire [REG_WIDTH-1:0] seed,
    output wire co_co,
    output wire [1:0] x_out
);

    wire [REG_WIDTH-1:0] x_reg;
    wire                 fb;
    wire                 temp;

    CA3_xor xor_1 (
        .in_1(x_reg[REG_WIDTH-1]),
        .in_2(x_reg[REG_WIDTH-3]),
        .out(temp)
    );
    CA3_xor xor_2 (
        .in_1(temp),
        .in_2(x_reg[REG_WIDTH-5]),
        .out(fb)
    );

    RND_shift_register #(
        .WIDTH(REG_WIDTH)
    ) x_register (
        .clk(clk),
        .rst(rst),
        .seed(seed),
        .fb(fb),
        .init(x_init),
        .en(x_en),
        .out(x_reg)
    );

    RND_counter #(
        .WIDTH(CNT_WIDTH),
        .CARRYOUT(REG_WIDTH-1)
    ) counter (
        .clk(clk),
        .rst(rst),
        .init(co_init),
        .en(co_en),
        .co(co_co)
    );

    assign x_out = {x_reg[REG_WIDTH-1], x_reg[REG_WIDTH-2]};

endmodule

