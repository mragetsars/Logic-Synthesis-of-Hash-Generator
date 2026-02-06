module HG_pipeline_reg #(
    parameter WIDTH = 8,
    parameter [WIDTH-1:0] INIT = {WIDTH{1'b0}}
) (
    input  wire [WIDTH-1:0] d_in,
    input  wire             load_enable,
    input  wire             rst,
    input  wire             clk,
    output wire [WIDTH-1:0] q_out
);
    // initial q_out = INIT;

    // always @(posedge clk or posedge rst) begin
    //     if (rst)
    //         q_out <= INIT;
    //     else if (load_enable)
    //         q_out <= d_in;
    // end

    CA3_reg b0 (.clk(clk), .rst(1'b0), .seed(INIT[0]), .in(d_in[0]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[0]));
    CA3_reg b1 (.clk(clk), .rst(1'b0), .seed(INIT[1]), .in(d_in[1]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[1]));
    CA3_reg b2 (.clk(clk), .rst(1'b0), .seed(INIT[2]), .in(d_in[2]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[2]));
    CA3_reg b3 (.clk(clk), .rst(1'b0), .seed(INIT[3]), .in(d_in[3]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[3]));
    CA3_reg b4 (.clk(clk), .rst(1'b0), .seed(INIT[4]), .in(d_in[4]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[4]));
    CA3_reg b5 (.clk(clk), .rst(1'b0), .seed(INIT[5]), .in(d_in[5]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[5]));
    CA3_reg b6 (.clk(clk), .rst(1'b0), .seed(INIT[6]), .in(d_in[6]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[6]));
    CA3_reg b7 (.clk(clk), .rst(1'b0), .seed(INIT[7]), .in(d_in[7]), .init(rst), .en_1(load_enable), .en_2(1'b1), .out(q_out[7]));

endmodule