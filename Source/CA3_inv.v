module CA3_inv (
    input  wire in,
    output wire out
);

    c1 inv_inst (
        .A0(1'b1), .A1(1'b0), .SA(1'b0), 
        .B0(1'b0), .B1(1'b0), .SB(1'b0), 
        .S0(in), .S1(1'b0), 
        .f(out)
    );

endmodule