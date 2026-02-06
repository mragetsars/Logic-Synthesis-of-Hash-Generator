module HG_controller #(
    parameter STATE_WIDTH = 6
)(
    input  wire clk,
    input  wire rst_in,
    input  wire start,
    input  wire done_rnd,
    input  wire i_is_all_one,

    output wire rst_out,
    output wire load_msg,
    output wire start_rnd,
    output wire inc,
    output wire load_enable,
    output wire done
);

//     localparam IDLE      = 6'b000001;
//     localparam LOAD_MEM  = 6'b000010;
//     localparam F_LOGIC   = 6'b000100;
//     localparam WAIT_RND  = 6'b001000;
//     localparam UPDATE    = 6'b010000;
//     localparam DONE_ST   = 6'b100000;

//     reg [5:0] state, next_state;

//     always @(posedge clk) begin
//         if (rst_in)
//             state <= IDLE;
//         else
//             state <= next_state;
//     end

//     always @(*) begin
//         next_state = state;
//         case (state)
//             IDLE:      next_state = start        ? LOAD_MEM : IDLE;
//             LOAD_MEM:  next_state = ~start       ? F_LOGIC  : LOAD_MEM;
//             F_LOGIC:   next_state = WAIT_RND;
//             WAIT_RND:  next_state = done_rnd     ? UPDATE   : WAIT_RND;
//             UPDATE:    next_state = i_is_all_one ? DONE_ST  : F_LOGIC;
//             DONE_ST:   next_state = DONE_ST;
//             default:   next_state = IDLE;
//         endcase
//     end

//     always @(*) begin
//         rst_out     = 1'b0;
//         load_msg    = 1'b0;
//         start_rnd   = 1'b0;
//         inc         = 1'b0;
//         load_enable = 1'b0;
//         done        = 1'b0;

//         case (state)
//             IDLE: begin
//                 rst_out = 1'b1;
//             end
//             LOAD_MEM: begin
//                 load_msg = 1'b1;
//             end
//             F_LOGIC: begin
//                 start_rnd = 1'b1;
//             end
//             UPDATE: begin
//                 inc         = 1'b1;
//                 load_enable = 1'b1;
//             end
//             DONE_ST: begin
//                 done = 1'b1;
//             end
//         endcase
//     end

    wire q0, q1, q2, q3, q4, q5;

    wire q0_or_q1;
    wire q1_next_logic, q2_term1, q2_term2, q2_next;
    wire q2_or_q3;
    wire q4_next;
    wire q4_and_all_one, q5_next;

    s2 state0_inst (
        .D00(q0), 
        .D01(1'b0), 
        .D10(1'b1), 
        .D11(1'b1), 
        .A1(rst_in), .B1(1'b0), 
        .A0(start),  .B0(1'b1), 
        .clr(1'b0), 
        .clk(clk),
        .out(q0)
    );

    c1 or_gate_q0q1 (
        .A0(q1), .A1(1'b1), .SA(q0), 
        .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0), 
        .f(q0_or_q1)
    );

    s2 state1_inst (
        .D00(1'b0), 
        .D01(q0_or_q1), 
        .D10(1'b0), .D11(1'b0), 
        .A1(1'b0), .B1(1'b0), 
        .A0(start), .B0(1'b1), 
        .clr(rst_in), 
        .clk(clk),
        .out(q1)
    );

    c1 term1_logic (
        .A0(q1), .A1(1'b0), .SA(start), 
        .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0),
        .f(q2_term1)
    );

    c1 term2_logic (
        .A0(q4), .A1(1'b0), .SA(i_is_all_one),
        .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0),
        .f(q2_term2)
    );

    c1 or_terms_q2 (
        .A0(q2_term2), .A1(1'b1), .SA(q2_term1),
        .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0),
        .f(q2_next)
    );

    s2 state2_inst (
        .D00(q2_next), .D01(1'b0), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0), // s1=0, s0=0 -> Pass D00
        .clr(rst_in),
        .clk(clk),
        .out(q2)
    );

    c1 or_q2q3 (
        .A0(q3), .A1(1'b1), .SA(q2),
        .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0),
        .f(q2_or_q3)
    );

    s2 state3_inst (
        .D00(q2_or_q3),   // If done_rnd=0: Hold q3 or Enter from q2
        .D01(q2),         // If done_rnd=1: Leave q3 (q3 term is gone), Enter from q2 allowed
        .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0),
        .A0(done_rnd), .B0(1'b1), 
        .clr(rst_in),
        .clk(clk),
        .out(q3)
    );

    c2 and_q3_done (
        .D00(1'b0), .D01(1'b1), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), 
        .A0(q3), .B0(done_rnd), 
        .out(q4_next)
    );

    s2 state4_inst (
        .D00(q4_next), .D01(1'b0), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0),
        .clr(rst_in),
        .clk(clk),
        .out(q4)
    );

    c2 and_q4_allone (
        .D00(1'b0), .D01(1'b1), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0),
        .A0(q4), .B0(i_is_all_one),
        .out(q4_and_all_one)
    );

    c1 or_final_done (
        .A0(q5), .A1(1'b1), .SA(q4_and_all_one),
        .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0),
        .f(q5_next)
    );

    s2 state5_inst (
        .D00(q5_next), .D01(1'b0), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0),
        .clr(rst_in),
        .clk(clk),
        .out(q5)
    );

    assign rst_out     = q0;
    assign load_msg    = q1;
    assign start_rnd   = q2;
    assign inc         = q4;
    assign load_enable = q4;
    assign done        = q5;

endmodule