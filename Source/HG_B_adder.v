module HG_B_adder #(
    parameter WIDTH = 8
)(
    input  [WIDTH-1:0] B_old,
    input  [WIDTH-1:0] rotF,
    output [WIDTH-1:0] B_plus_rotF
);
    // assign B_plus_rotF = B_old + rotF;

    wire [WIDTH-1:0] h;
    wire [WIDTH-2:0] c; 

    c1 bit0_sum (
        .A0(1'b0), .A1(1'b1), .SA(rotF[0]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[0]), 
        .S0(B_old[0]), .S1(1'b0), 
        .f(B_plus_rotF[0])
    );
    assign h[0] = B_plus_rotF[0];

    c1 bit0_cy (
        .A0(1'b0), .A1(1'b0), .SA(1'b0), 
        .B0(1'b0), .B1(1'b1), .SB(rotF[0]), 
        .S0(B_old[0]), .S1(1'b0), 
        .f(c[0])
    );

    c1 bit1_h (
        .A0(1'b0), .A1(1'b1), .SA(rotF[1]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[1]), 
        .S0(B_old[1]), .S1(1'b0), 
        .f(h[1])
    );
    c1 bit1_sum (
        .A0(1'b0), .A1(1'b1), .SA(c[0]), 
        .B0(1'b1), .B1(1'b0), .SB(c[0]), 
        .S0(h[1]), .S1(1'b0), 
        .f(B_plus_rotF[1])
    );
    c1 bit1_cy (
        .A0(B_old[1]), .A1(1'b0), .SA(1'b0), 
        .B0(c[0]), .B1(1'b0), .SB(1'b0), 
        .S0(h[1]), .S1(1'b0), 
        .f(c[1])
    );

    c1 bit2_h (
        .A0(1'b0), .A1(1'b1), .SA(rotF[2]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[2]), 
        .S0(B_old[2]), .S1(1'b0), 
        .f(h[2])
    );
    c1 bit2_sum (
        .A0(1'b0), .A1(1'b1), .SA(c[1]), 
        .B0(1'b1), .B1(1'b0), .SB(c[1]), 
        .S0(h[2]), .S1(1'b0), 
        .f(B_plus_rotF[2])
    );
    c1 bit2_cy (
        .A0(B_old[2]), .A1(1'b0), .SA(1'b0), 
        .B0(c[1]), .B1(1'b0), .SB(1'b0), 
        .S0(h[2]), .S1(1'b0), 
        .f(c[2])
    );

    c1 bit3_h (
        .A0(1'b0), .A1(1'b1), .SA(rotF[3]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[3]), 
        .S0(B_old[3]), .S1(1'b0), 
        .f(h[3])
    );
    c1 bit3_sum (
        .A0(1'b0), .A1(1'b1), .SA(c[2]), 
        .B0(1'b1), .B1(1'b0), .SB(c[2]), 
        .S0(h[3]), .S1(1'b0), 
        .f(B_plus_rotF[3])
    );
    c1 bit3_cy (
        .A0(B_old[3]), .A1(1'b0), .SA(1'b0), 
        .B0(c[2]), .B1(1'b0), .SB(1'b0), 
        .S0(h[3]), .S1(1'b0), 
        .f(c[3])
    );

    c1 bit4_h (
        .A0(1'b0), .A1(1'b1), .SA(rotF[4]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[4]), 
        .S0(B_old[4]), .S1(1'b0), 
        .f(h[4])
    );
    c1 bit4_sum (
        .A0(1'b0), .A1(1'b1), .SA(c[3]), 
        .B0(1'b1), .B1(1'b0), .SB(c[3]), 
        .S0(h[4]), .S1(1'b0), 
        .f(B_plus_rotF[4])
    );
    c1 bit4_cy (
        .A0(B_old[4]), .A1(1'b0), .SA(1'b0), 
        .B0(c[3]), .B1(1'b0), .SB(1'b0), 
        .S0(h[4]), .S1(1'b0), 
        .f(c[4])
    );

    c1 bit5_h (
        .A0(1'b0), .A1(1'b1), .SA(rotF[5]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[5]), 
        .S0(B_old[5]), .S1(1'b0), 
        .f(h[5])
    );
    c1 bit5_sum (
        .A0(1'b0), .A1(1'b1), .SA(c[4]), 
        .B0(1'b1), .B1(1'b0), .SB(c[4]), 
        .S0(h[5]), .S1(1'b0), 
        .f(B_plus_rotF[5])
    );
    c1 bit5_cy (
        .A0(B_old[5]), .A1(1'b0), .SA(1'b0), 
        .B0(c[4]), .B1(1'b0), .SB(1'b0), 
        .S0(h[5]), .S1(1'b0), 
        .f(c[5])
    );

    c1 bit6_h (
        .A0(1'b0), .A1(1'b1), .SA(rotF[6]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[6]), 
        .S0(B_old[6]), .S1(1'b0), 
        .f(h[6])
    );
    c1 bit6_sum (
        .A0(1'b0), .A1(1'b1), .SA(c[5]), 
        .B0(1'b1), .B1(1'b0), .SB(c[5]), 
        .S0(h[6]), .S1(1'b0), 
        .f(B_plus_rotF[6])
    );
    c1 bit6_cy (
        .A0(B_old[6]), .A1(1'b0), .SA(1'b0), 
        .B0(c[5]), .B1(1'b0), .SB(1'b0), 
        .S0(h[6]), .S1(1'b0), 
        .f(c[6])
    );

    c1 bit7_h (
        .A0(1'b0), .A1(1'b1), .SA(rotF[7]), 
        .B0(1'b1), .B1(1'b0), .SB(rotF[7]), 
        .S0(B_old[7]), .S1(1'b0), 
        .f(h[7])
    );
    c1 bit7_sum (
        .A0(1'b0), .A1(1'b1), .SA(c[6]), 
        .B0(1'b1), .B1(1'b0), .SB(c[6]), 
        .S0(h[7]), .S1(1'b0), 
        .f(B_plus_rotF[7])
    );

endmodule