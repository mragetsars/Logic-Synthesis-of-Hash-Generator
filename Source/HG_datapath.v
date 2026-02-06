module HG_datapath #(
    parameter integer WIDTH = 32,
    parameter integer WORD  = WIDTH / 4,
    parameter MEM_PATH = "./constant.mem",
    parameter A_reg_INIT = 8'h01,
    parameter B_reg_INIT = 8'h89,
    parameter C_reg_INIT = 8'hfe,
    parameter D_reg_INIT = 8'h76
)(
    input  wire             clk,
    input  wire             rst_in,
    
    input  wire             load_msg,
    input  wire             inc,
    input  wire             load_enable,
    
    input  wire [WIDTH-1:0] in_put,
    input  wire [1:0]       rnd_sel,
    
    output wire [WIDTH-1:0] out_put,
    output wire [5:0]       i_out, 
    output wire             i_is_all_one
);

    wire [WORD-1:0] M1, M2, M3, M4;
    wire [WORD-1:0] mux_out;
    wire [WORD-1:0] const_word;
    wire [WORD-1:0] F_logic, F_sum, rotF, B_plus_rotF;
    wire [WORD-1:0] A_reg, B_reg, C_reg, D_reg;


    HG_M_mem #(.WIDTH(WIDTH)) u_mmem (
        .clk(clk),
        .load_msg(load_msg),
        .msg_in(in_put),
        .M_out_1(M1),
        .M_out_2(M2),
        .M_out_3(M3),
        .M_out_4(M4)
    );


    HG_const_mem #(.ADDR_WIDTH(6), .PATH(MEM_PATH)) u_const (
        .i_addr(i_out),
        .data(const_word)
    );


    HG_mux #(.WIDTH(WORD)) u_mux (
        .in1(M1),
        .in2(M2),
        .in3(M3),
        .in4(M4),
        .sel(rnd_sel),
        .out(mux_out)
    );

    HG_F_logic_ALU #(.WIDTH(WORD)) u_flogic (
        .B(B_reg),
        .C(C_reg),
        .D(D_reg),
        .func_sel(i_out[5:4]),
        .F_logic(F_logic)
    );

    HG_F_adder #(.WIDTH(WORD)) u_fadder (
        .F_logic(F_logic),
        .A(A_reg),
        .const_word(const_word),
        .m_word(mux_out),
        .F_sum(F_sum)
    );

    HG_split_multiplier #(.WIDTH(WORD)) u_split_mul (
        .F(F_sum),
        .result(rotF)
    );

    HG_B_adder #(.WIDTH(WORD)) u_badder (
        .B_old(B_reg),
        .rotF(rotF),
        .B_plus_rotF(B_plus_rotF)
    );


    HG_pipeline_reg #(.WIDTH(WORD), .INIT(A_reg_INIT)) u_regA (
        .d_in(D_reg),
        .load_enable(load_enable),
        .rst(rst_in),
        .clk(clk),
        .q_out(A_reg)
    );

    HG_pipeline_reg #(.WIDTH(WORD), .INIT(B_reg_INIT)) u_regB (
        .d_in(B_plus_rotF),
        .load_enable(load_enable),
        .rst(rst_in),
        .clk(clk),
        .q_out(B_reg)
    );

    HG_pipeline_reg #(.WIDTH(WORD), .INIT(C_reg_INIT)) u_regC (
        .d_in(B_reg),
        .load_enable(load_enable),
        .rst(rst_in),
        .clk(clk),
        .q_out(C_reg)
    );

    HG_pipeline_reg #(.WIDTH(WORD), .INIT(D_reg_INIT)) u_regD (
        .d_in(C_reg),
        .load_enable(load_enable),
        .rst(rst_in),
        .clk(clk),
        .q_out(D_reg)
    );


    HG_i_cnt #(.WIDTH(6)) u_cnt (
        .clk(clk),
        .rst(rst_in),
        .inc(inc),
        .i_out(i_out),
        .i_is_all_one(i_is_all_one)
    );

    assign out_put = {A_reg, B_reg, C_reg, D_reg};

endmodule