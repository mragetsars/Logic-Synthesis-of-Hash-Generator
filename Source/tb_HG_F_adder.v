`timescale 1ns / 1ps

module tb_HG_F_adder;

    parameter WIDTH = 32;

    reg [WIDTH-1:0] F_logic;
    reg [WIDTH-1:0] A;
    reg [WIDTH-1:0] const_word;
    reg [WIDTH-1:0] m_word;

    wire [WIDTH-1:0] F_sum;

    HG_F_adder #(
        .WIDTH(WIDTH)
    ) uut (
        .F_logic(F_logic),
        .A(A),
        .const_word(const_word),
        .m_word(m_word),
        .F_sum(F_sum)
    );

    initial begin
        F_logic = 0;
        A = 0;
        const_word = 0;
        m_word = 0;
        #20;

        F_logic = 1;
        A = 1;
        const_word = 1;
        m_word = 1;
        #20;

        F_logic = 10;
        A = 20;
        const_word = 30;
        m_word = 40;
        #20;

        F_logic = 32'h1000;
        A = 32'h2000;
        const_word = 32'h0001;
        m_word = 32'h0002;
        #20;

        F_logic = 32'hFFFFFFFF;
        A = 1;
        const_word = 1;
        m_word = 0;
        #20;

        F_logic = $random;
        A = $random;
        const_word = $random;
        m_word = $random;
        #20;

        F_logic = $random;
        A = $random;
        const_word = $random;
        m_word = $random;
        #20;

        $stop;
    end

endmodule