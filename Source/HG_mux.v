module HG_mux #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire [WIDTH-1:0] in3,
    input  wire [WIDTH-1:0] in4,
    input  wire [1:0]       sel,
    output wire [WIDTH-1:0] out
);
    // always @(*) begin
    //     case (sel)
    //         2'b00: out = in1;
    //         2'b01: out = in2;
    //         2'b10: out = in3;
    //         2'b11: out = in4;
    //         default: out = {WIDTH{1'b0}};
    //     endcase
    // end

    c1 m0 (
        .A0(in1[0]), 
        .A1(in2[0]), 
        .SA(sel[0]), 
        .B0(in3[0]), 
        .B1(in4[0]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[0])
    );

    c1 m1 (
        .A0(in1[1]), 
        .A1(in2[1]), 
        .SA(sel[0]), 
        .B0(in3[1]), 
        .B1(in4[1]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[1])
    );

    c1 m2 (
        .A0(in1[2]), 
        .A1(in2[2]), 
        .SA(sel[0]), 
        .B0(in3[2]), 
        .B1(in4[2]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[2])
    );

    c1 m3 (
        .A0(in1[3]), 
        .A1(in2[3]), 
        .SA(sel[0]), 
        .B0(in3[3]), 
        .B1(in4[3]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[3])
    );

    c1 m4 (
        .A0(in1[4]), 
        .A1(in2[4]), 
        .SA(sel[0]), 
        .B0(in3[4]), 
        .B1(in4[4]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[4])
    );

    c1 m5 (
        .A0(in1[5]), 
        .A1(in2[5]), 
        .SA(sel[0]), 
        .B0(in3[5]), 
        .B1(in4[5]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[5])
    );

    c1 m6 (
        .A0(in1[6]), 
        .A1(in2[6]), 
        .SA(sel[0]), 
        .B0(in3[6]), 
        .B1(in4[6]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[6])
    );

    c1 m7 (
        .A0(in1[7]), 
        .A1(in2[7]), 
        .SA(sel[0]), 
        .B0(in3[7]), 
        .B1(in4[7]), 
        .SB(sel[0]), 
        .S0(sel[1]), 
        .S1(1'b0), 
        .f(out[7])
    );

endmodule