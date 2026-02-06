module HG_i_cnt #(
    parameter WIDTH = 6
)(
    input  wire             clk,
    input  wire             rst,
    input  wire             inc,
    output wire [WIDTH-1:0] i_out,
    output wire             i_is_all_one
);
    // always @(posedge clk or posedge rst) begin
    //     if (rst) begin
    //         i_out <= {WIDTH{1'b0}};
    //     end else if (inc) begin
    //         i_out <= i_out + 1'b1;
    //     end
    // end

    // assign i_is_all_one = &i_out;


    wire en1, en2, en3, en4, en5;
    wire one_lo, one_hi;

    CA3_irg b0 (
        .clk(clk),
        .rst(rst),
        .n_init(1'b1),
        .inc_1(inc),
        .inc_2(1'b1),
        .out(i_out[0])
    );

    CA3_and_2 c_en1 (
        .in_1(i_out[0]),
        .in_2(inc),
        .out(en1)
    );

    CA3_irg b1 (
        .clk(clk),
        .rst(rst),
        .n_init(1'b1),
        .inc_1(en1),
        .inc_2(1'b1),
        .out(i_out[1])
    );

    CA3_and_2 c_en2 (
        .in_1(i_out[1]),
        .in_2(en1),
        .out(en2)
    );

    CA3_irg b2 (
        .clk(clk),
        .rst(rst),
        .n_init(1'b1),
        .inc_1(en2),
        .inc_2(1'b1),
        .out(i_out[2])
    );

    CA3_and_2 c_en3 (
        .in_1(i_out[2]),
        .in_2(en2),
        .out(en3)
    );

    CA3_irg b3 (
        .clk(clk),
        .rst(rst),
        .n_init(1'b1),
        .inc_1(en3),
        .inc_2(1'b1),
        .out(i_out[3])
    );

    CA3_and_2 c_en4 (
        .in_1(i_out[3]),
        .in_2(en3),
        .out(en4)
    );

    CA3_irg b4 (
        .clk(clk),
        .rst(rst),
        .n_init(1'b1),
        .inc_1(en4),
        .inc_2(1'b1),
        .out(i_out[4])
    );

    CA3_and_2 c_en5 (
        .in_1(i_out[4]),
        .in_2(en4),
        .out(en5)
    );

    CA3_irg b5 (
        .clk(clk),
        .rst(rst),
        .n_init(1'b1),
        .inc_1(en5),
        .inc_2(1'b1),
        .out(i_out[5])
    );

    CA3_and_3 and_lo (
        .in_1(i_out[0]),
        .in_2(i_out[1]),
        .in_3(i_out[2]),
        .out(one_lo)
    );

    CA3_and_3 and_hi (
        .in_1(i_out[3]),
        .in_2(i_out[4]),
        .in_3(i_out[5]),
        .out(one_hi)
    );

    CA3_and_2 and_final (
        .in_1(one_hi),
        .in_2(one_lo),
        .out(i_is_all_one)
    );

endmodule