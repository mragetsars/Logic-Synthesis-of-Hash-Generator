module RND_top_module #(
    parameter REG_WIDTH = 6,
    parameter CNT_WIDTH = 3
)(
    input  wire clk,
    input  wire rst,
    input  wire start_rnd,
    input  wire [REG_WIDTH-1:0] seed,
    output wire done_rnd,
    output wire [1:0] x_out
);

    wire x_en, x_init, co_en, co_init, co_co;

    RND_controller u_ctrl (
        .clk(clk),
        .rst(rst),
        .start_rnd(start_rnd),
        .co_co(co_co),
        .x_en(x_en),
	.x_init(x_init),
	.co_en(co_en),
        .co_init(co_init),
        .done_rnd(done_rnd)
    );

    RND_datapath #(
        .REG_WIDTH(REG_WIDTH),
        .CNT_WIDTH(CNT_WIDTH)
    ) u_dp (
        .clk(clk),
        .rst(rst),
        .x_en(x_en),
	.x_init(x_init),
	.co_en(co_en),
        .co_init(co_init),
        .seed(seed),
        .co_co(co_co),
        .x_out(x_out)
    );

endmodule

