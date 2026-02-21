module RND_counter #(
    parameter           WIDTH = 3,
    parameter           CARRYOUT = 5,
    parameter [WIDTH-1:0] INIT  = {WIDTH{1'b0}}
)  (
    input  wire                     clk,
    input  wire                     rst,
    input  wire                     init,
    input  wire                     en,
    output wire                     co
);

    // reg [WIDTH-1:0] data;

    // initial data = {WIDTH{1'b0}};

    // always @(posedge clk or posedge rst) begin
    //     if (rst)
    //         data <= {WIDTH{1'b0}};
    //     else if (init)
    //         data <= {WIDTH{1'b0}};
    //     else if (en)
    //         data <= data + 1;
    // end

    // assign co = (data == CARRYOUT);


    wire [2:0] data;
    wire n_d0, n_d1, n_d2;
    wire q0q1;
    wire n_init;

    CA3_inv inv_init (
        .in(init),
        .out(n_init)
    );

    CA3_irg b0 (
        .clk(clk),
        .rst(rst),
        .n_init(n_init),
        .inc_1(en),
        .inc_2(1'b1),
        .out(data[0])
    );

    CA3_irg b1 (
        .clk(clk),
        .rst(rst),
        .n_init(n_init),
        .inc_1(en),
        .inc_2(data[0]),
        .out(data[1])
    );

    CA3_and_2 and_01 (
        .in_1(data[0]),
        .in_2(data[1]),
        .out(q0q1)
    );

    CA3_irg b2 (
        .clk(clk),
        .rst(rst),
        .n_init(n_init),
        .inc_1(en),
        .inc_2(q0q1),
        .out(data[2])
    );

    c2 co_logic (
        .D00(1'b0), .D01(1'b1), .D10(1'b0), .D11(1'b0), 
        .A1(data[1]), .B1(1'b0),
        .A0(data[2]), .B0(data[0]),
        .out(co)
    );

endmodule
