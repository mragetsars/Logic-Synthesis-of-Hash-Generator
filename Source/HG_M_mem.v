module HG_M_mem #(
    parameter WIDTH = 32
)(
    input  wire             clk,
    input  wire             load_msg,
    input  wire [WIDTH-1:0] msg_in,
    output wire [7:0]       M_out_1,
    output wire [7:0]       M_out_2,
    output wire [7:0]       M_out_3,
    output wire [7:0]       M_out_4
);

    // always @(posedge clk) begin
    //     if (load_msg) begin
    //         M_out_1 <= msg_in[(WIDTH/4)*4 - 1 : (WIDTH/4)*3]; //! this is MSBs
    //         M_out_2 <= msg_in[(WIDTH/4)*3 - 1 : (WIDTH/4)*2];
    //         M_out_3 <= msg_in[(WIDTH/4)*2 - 1 : (WIDTH/4)*1];
    //         M_out_4 <= msg_in[(WIDTH/4)*1 - 1 : (WIDTH/4)*0];
    //     end
    // end
    
    CA3_reg b00 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 0]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[0]));
    CA3_reg b01 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 1]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[1]));
    CA3_reg b02 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 2]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[2]));
    CA3_reg b03 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 3]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[3]));
    CA3_reg b04 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 4]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[4]));
    CA3_reg b05 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 5]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[5]));
    CA3_reg b06 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 6]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[6]));
    CA3_reg b07 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 7]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_4[7]));

    CA3_reg b08 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 8]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[0]));
    CA3_reg b09 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[ 9]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[1]));
    CA3_reg b10 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[10]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[2]));
    CA3_reg b11 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[11]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[3]));
    CA3_reg b12 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[12]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[4]));
    CA3_reg b13 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[13]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[5]));
    CA3_reg b14 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[14]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[6]));
    CA3_reg b15 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[15]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_3[7]));

    CA3_reg b16 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[16]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[0]));
    CA3_reg b17 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[17]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[1]));
    CA3_reg b18 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[18]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[2]));
    CA3_reg b19 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[19]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[3]));
    CA3_reg b20 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[20]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[4]));
    CA3_reg b21 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[21]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[5]));
    CA3_reg b22 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[22]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[6]));
    CA3_reg b23 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[23]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_2[7]));

    CA3_reg b24 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[24]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[0]));
    CA3_reg b25 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[25]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[1]));
    CA3_reg b26 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[26]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[2]));
    CA3_reg b27 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[27]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[3]));
    CA3_reg b28 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[28]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[4]));
    CA3_reg b29 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[29]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[5]));
    CA3_reg b30 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[30]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[6]));
    CA3_reg b31 (.clk(clk), .rst(1'b0), .seed(1'b0), .in(msg_in[31]), .init(1'b0), .en_1(load_msg), .en_2(1'b1), .out(M_out_1[7]));

endmodule