module RND_controller (
    input  wire clk,
    input  wire rst,
    input  wire start_rnd,
    input  wire co_co,
    output wire x_en,
    output wire x_init,
    output wire co_en,
    output wire co_init,
    output wire done_rnd
);
    // localparam IDLE = 2'b00,
    //            INIT = 2'b01,
    //            RUN  = 2'b10;

    // reg [1:0] state, next_state;

    // always @(posedge clk or posedge rst) begin
    //     if (rst)
    //         state <= IDLE;
    //     else
    //         state <= next_state;
    // end

    // always @(*) begin
    //     next_state = state;
    //     case (state)
    //         IDLE: if (start_rnd) next_state = INIT;
    //         INIT:                next_state = RUN;
    //         RUN:  if (co_co)     next_state = IDLE;
    //     endcase
    // end

    // always @(*) begin
    //     x_en       = 0;
    //     x_init     = 0;
    //     co_en      = 0;
    //     co_init    = 0;
    //     done_rnd   = 0;
    //     case (state)
    //         IDLE: begin
    //             done_rnd   = 1;
    //         end

    //         INIT: begin
    //             x_init     = 1;
    //             co_init    = 1;
    //         end

    //         RUN: begin
    //             x_en       = 1;
    //             co_en      = 1;
    //         end
    //     endcase
    // end

    wire state_0, state_1;
    wire not_co;
    wire init_w, en_w;

    CA3_inv inv_co (
        .in(co_co),
        .out(not_co)
    );

    s2 fsm_bit0 (
        .D00(start_rnd), 
        .D01(1'b0), 
        .D10(1'b0), 
        .D11(1'b0), 
        .A1(state_1), .B1(1'b0), 
        .A0(state_0), .B0(1'b1), 
        .clr(rst), .clk(clk), 
        .out(state_0)
    );

    s2 fsm_bit1 (
        .D00(1'b0), 
        .D01(1'b1), 
        .D10(not_co), 
        .D11(1'b0), 
        .A1(state_1), .B1(1'b0), 
        .A0(state_0), .B0(1'b1), 
        .clr(rst), .clk(clk), 
        .out(state_1)
    );

    c2 decode_idle (
        .D00(1'b1), .D01(1'b0), .D10(1'b0), .D11(1'b0), 
        .A1(state_1), .B1(1'b0), 
        .A0(state_0), .B0(1'b1), 
        .out(done_rnd)
    );

    c2 decode_init (
        .D00(1'b0), .D01(1'b1), .D10(1'b0), .D11(1'b0), 
        .A1(state_1), .B1(1'b0), 
        .A0(state_0), .B0(1'b1), 
        .out(init_w)
    );

    c2 decode_run (
        .D00(1'b0), .D01(1'b0), .D10(1'b1), .D11(1'b0), 
        .A1(state_1), .B1(1'b0), 
        .A0(state_0), .B0(1'b1), 
        .out(en_w)
    );

    assign x_init  = init_w;
    assign co_init = init_w;
    assign x_en    = en_w;
    assign co_en   = en_w;

endmodule