module HG_F_logic_ALU #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] B,
    input  wire [WIDTH-1:0] C,
    input  wire [WIDTH-1:0] D,
    input  wire [1:0]       func_sel,
    output wire [WIDTH-1:0] F_logic
);
    // always @(*) begin
    //     case (func_sel)
    //         2'b00: F_logic = (B & C) | ((~B) & D);
    //         2'b01: F_logic = (D & B) | ((~D) & C);
    //         2'b10: F_logic = B ^ C ^ D;
    //         2'b11: F_logic = C ^ (B | (~D));
    //         default: F_logic = {WIDTH{1'b0}};
    //     endcase
    // end


    wire [WIDTH-1:0] flow;
    wire [WIDTH-1:0] nd;
    wire [WIDTH-1:0] k;
    wire [WIDTH-1:0] nk;

    c1 b0_low (
        .A0(D[0]), .A1(C[0]), .SA(B[0]), 
        .B0(C[0]), .B1(B[0]), .SB(D[0]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[0])
    );
    CA3_inv b0_id (
        .in(D[0]),
        .out(nd[0])
    );
    c1 b0_k (
        .A0(D[0]), .A1(nd[0]), .SA(B[0]), 
        .B0(nd[0]), .B1(1'b1), .SB(B[0]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[0])
    );
    CA3_inv b0_ik (
        .in(k[0]),
        .out(nk[0])
    );
    c1 b0_out (
        .A0(flow[0]), .A1(flow[0]), .SA(1'b0), 
        .B0(k[0]), .B1(nk[0]), .SB(C[0]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[0])
    );


    c1 b1_low (
        .A0(D[1]), .A1(C[1]), .SA(B[1]), 
        .B0(C[1]), .B1(B[1]), .SB(D[1]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[1])
    );
    CA3_inv b1_id (
        .in(D[1]),
        .out(nd[1])
    );
    c1 b1_k (
        .A0(D[1]), .A1(nd[1]), .SA(B[1]), 
        .B0(nd[1]), .B1(1'b1), .SB(B[1]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[1])
    );
    CA3_inv b1_ik (
        .in(k[1]),
        .out(nk[1])
    );
    c1 b1_out (
        .A0(flow[1]), .A1(flow[1]), .SA(1'b0), 
        .B0(k[1]), .B1(nk[1]), .SB(C[1]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[1])
    );


    c1 b2_low (
        .A0(D[2]), .A1(C[2]), .SA(B[2]), 
        .B0(C[2]), .B1(B[2]), .SB(D[2]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[2])
    );
    CA3_inv b2_id (
        .in(D[2]),
        .out(nd[2])
    );
    c1 b2_k (
        .A0(D[2]), .A1(nd[2]), .SA(B[2]), 
        .B0(nd[2]), .B1(1'b1), .SB(B[2]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[2])
    );
    CA3_inv b2_ik (
        .in(k[2]),
        .out(nk[2])
    );
    c1 b2_out (
        .A0(flow[2]), .A1(flow[2]), .SA(1'b0), 
        .B0(k[2]), .B1(nk[2]), .SB(C[2]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[2])
    );


    c1 b3_low (
        .A0(D[3]), .A1(C[3]), .SA(B[3]), 
        .B0(C[3]), .B1(B[3]), .SB(D[3]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[3])
    );
    CA3_inv b3_id (
        .in(D[3]),
        .out(nd[3])
    );
    c1 b3_k (
        .A0(D[3]), .A1(nd[3]), .SA(B[3]), 
        .B0(nd[3]), .B1(1'b1), .SB(B[3]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[3])
    );
    CA3_inv b3_ik (
        .in(k[3]),
        .out(nk[3])
    );
    c1 b3_out (
        .A0(flow[3]), .A1(flow[3]), .SA(1'b0), 
        .B0(k[3]), .B1(nk[3]), .SB(C[3]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[3])
    );


    c1 b4_low (
        .A0(D[4]), .A1(C[4]), .SA(B[4]), 
        .B0(C[4]), .B1(B[4]), .SB(D[4]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[4])
    );
    CA3_inv b4_id (
        .in(D[4]),
        .out(nd[4])
    );
    c1 b4_k (
        .A0(D[4]), .A1(nd[4]), .SA(B[4]), 
        .B0(nd[4]), .B1(1'b1), .SB(B[4]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[4])
    );
    CA3_inv b4_ik (
        .in(k[4]),
        .out(nk[4])
    );
    c1 b4_out (
        .A0(flow[4]), .A1(flow[4]), .SA(1'b0), 
        .B0(k[4]), .B1(nk[4]), .SB(C[4]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[4])
    );


    c1 b5_low (
        .A0(D[5]), .A1(C[5]), .SA(B[5]), 
        .B0(C[5]), .B1(B[5]), .SB(D[5]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[5])
    );
    CA3_inv b5_id (
        .in(D[5]),
        .out(nd[5])
    );
    c1 b5_k (
        .A0(D[5]), .A1(nd[5]), .SA(B[5]), 
        .B0(nd[5]), .B1(1'b1), .SB(B[5]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[5])
    );
    CA3_inv b5_ik (
        .in(k[5]),
        .out(nk[5])
    );
    c1 b5_out (
        .A0(flow[5]), .A1(flow[5]), .SA(1'b0), 
        .B0(k[5]), .B1(nk[5]), .SB(C[5]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[5])
    );


    c1 b6_low (
        .A0(D[6]), .A1(C[6]), .SA(B[6]), 
        .B0(C[6]), .B1(B[6]), .SB(D[6]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[6])
    );
    CA3_inv b6_id (
        .in(D[6]),
        .out(nd[6])
    );
    c1 b6_k (
        .A0(D[6]), .A1(nd[6]), .SA(B[6]), 
        .B0(nd[6]), .B1(1'b1), .SB(B[6]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[6])
    );
    CA3_inv b6_ik (
        .in(k[6]),
        .out(nk[6])
    );
    c1 b6_out (
        .A0(flow[6]), .A1(flow[6]), .SA(1'b0), 
        .B0(k[6]), .B1(nk[6]), .SB(C[6]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[6])
    );


    c1 b7_low (
        .A0(D[7]), .A1(C[7]), .SA(B[7]), 
        .B0(C[7]), .B1(B[7]), .SB(D[7]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(flow[7])
    );
    CA3_inv b7_id (
        .in(D[7]),
        .out(nd[7])
    );
    c1 b7_k (
        .A0(D[7]), .A1(nd[7]), .SA(B[7]), 
        .B0(nd[7]), .B1(1'b1), .SB(B[7]), 
        .S0(func_sel[0]), .S1(1'b0), 
        .f(k[7])
    );
    CA3_inv b7_ik (
        .in(k[7]),
        .out(nk[7])
    );
    c1 b7_out (
        .A0(flow[7]), .A1(flow[7]), .SA(1'b0), 
        .B0(k[7]), .B1(nk[7]), .SB(C[7]), 
        .S0(func_sel[1]), .S1(1'b0), 
        .f(F_logic[7])
    );

endmodule