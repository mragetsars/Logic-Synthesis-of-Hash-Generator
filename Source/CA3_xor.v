module CA3_xor (
    input  wire in_1,
    input  wire in_2,
    output wire out
);

    c1 xor_inst (
        .A0(1'b0), .A1(1'b1), .SA(in_2), 
        .B0(1'b1), .B1(1'b0), .SB(in_2), 
        .S0(in_1), .S1(1'b0), 
        .f(out)
    );

endmodule