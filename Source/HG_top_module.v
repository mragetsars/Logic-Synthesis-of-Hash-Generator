module HG_top_module #(
    parameter integer WIDTH = 32,
    parameter integer WORD  = WIDTH / 4,
    parameter MEM_PATH = "./constant.mem",
    parameter A_reg_INIT = 8'h01,
    parameter B_reg_INIT = 8'h89,
    parameter C_reg_INIT = 8'hfe,
    parameter D_reg_INIT = 8'h76
)(
    input  wire             clk,
    input  wire             rst,
    input  wire             start,
    input  wire [WIDTH-1:0] in_put,
    output wire             done,
    output wire [WIDTH-1:0] out_put
);

    initial begin
        if (WIDTH % 4 != 0) begin
            $display("ERROR: Parameter WIDTH (%0d) must be a multiple of 4.", WIDTH);
            $finish;
        end
    end


    wire rst_ctrl;
    wire load_msg;
    wire inc;
    wire load_enable;
    wire start_rnd;
    wire done_rnd;
    
    wire i_is_all_one;
    wire [5:0] i_out; 

    wire [1:0] rnd_sel;


    HG_controller #(.STATE_WIDTH(6)) u_ctrl (
        .clk(clk),
        .rst_in(rst),
        .start(start),
        .done_rnd(done_rnd),
        .i_is_all_one(i_is_all_one),

        .rst_out(rst_ctrl),
        .load_msg(load_msg),
        .start_rnd(start_rnd),
        .inc(inc),
        .load_enable(load_enable),
        .done(done)
    );


    RND_top_module #(.REG_WIDTH(6), .CNT_WIDTH(3)) u_rnd (
        .clk(clk),
        .rst(rst_ctrl),
        .start_rnd(start_rnd),
        .seed(i_out),     
        .done_rnd(done_rnd),
        .x_out(rnd_sel)   
    );

    HG_datapath #(
        .WIDTH(WIDTH),
        .WORD(WORD),
        .MEM_PATH(MEM_PATH),
        .A_reg_INIT(A_reg_INIT),
        .B_reg_INIT(B_reg_INIT),
        .C_reg_INIT(C_reg_INIT),
        .D_reg_INIT(D_reg_INIT)
    ) u_datapath (
        .clk(clk),
        .rst_in(rst_ctrl),
        
        .load_msg(load_msg),
        .inc(inc),
        .load_enable(load_enable),
        
        .in_put(in_put),
        .rnd_sel(rnd_sel),
        
        .out_put(out_put),
        .i_out(i_out), 
        .i_is_all_one(i_is_all_one)
    );

endmodule