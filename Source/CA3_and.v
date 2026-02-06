module CA3_and_2 (
    input  wire in_1,
    input  wire in_2,
    output wire out
);

    c1 and_inst (
        .A0(1'b0), .A1(1'b0), .SA(1'b0), 
        .B0(in_2), .B1(1'b0), .SB(1'b0), 
        .S0(in_1), .S1(1'b0), 
        .f(out)
    );

endmodule

module CA3_and_3 (
    input  wire in_1,
    input  wire in_2,
    input  wire in_3,
    output wire out
);

    c1 and_inst (
        .A0(1'b0), .A1(1'b0), .SA(1'b0),
        .B0(1'b0), .B1(in_3), .SB(in_2),
        .S0(1'b0), .S1(in_1),
        .f(out)
    );

endmodule