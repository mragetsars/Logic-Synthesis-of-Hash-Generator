module RND_shift_register #(
    parameter           WIDTH = 8,
    parameter [WIDTH-1:0] INIT  = {WIDTH{1'b0}}
) (
    input  wire             clk,
    input  wire             rst,
    input  wire [WIDTH-1:0] seed,
    input  wire             fb,
    input  wire             init,
    input  wire             en,
    output wire [WIDTH-1:0] out
);
    // reg [WIDTH-1:0] data;

    // initial data = {WIDTH{1'b0}};

    // always @(posedge clk or posedge rst) begin
    //     if (rst)
    //         data <= {WIDTH{1'b0}};
    //     else if (init)
    //         data <= seed;
    //     else if (en)
    //         data <= {data[WIDTH-2:0], fb};
    // end

    // assign out = data;

    CA3_reg b0 (.clk(clk), .rst(rst), .seed(seed[0]), .in(  fb  ), .init(init), .en_1(en), .en_2(1'b1), .out(out[0]));
    CA3_reg b1 (.clk(clk), .rst(rst), .seed(seed[1]), .in(out[0]), .init(init), .en_1(en), .en_2(1'b1), .out(out[1]));
    CA3_reg b2 (.clk(clk), .rst(rst), .seed(seed[2]), .in(out[1]), .init(init), .en_1(en), .en_2(1'b1), .out(out[2]));
    CA3_reg b3 (.clk(clk), .rst(rst), .seed(seed[3]), .in(out[2]), .init(init), .en_1(en), .en_2(1'b1), .out(out[3]));
    CA3_reg b4 (.clk(clk), .rst(rst), .seed(seed[4]), .in(out[3]), .init(init), .en_1(en), .en_2(1'b1), .out(out[4]));
    CA3_reg b5 (.clk(clk), .rst(rst), .seed(seed[5]), .in(out[4]), .init(init), .en_1(en), .en_2(1'b1), .out(out[5]));
    CA3_reg b6 (.clk(clk), .rst(rst), .seed(seed[6]), .in(out[5]), .init(init), .en_1(en), .en_2(1'b1), .out(out[6]));
    CA3_reg b7 (.clk(clk), .rst(rst), .seed(seed[7]), .in(out[6]), .init(init), .en_1(en), .en_2(1'b1), .out(out[7]));

endmodule