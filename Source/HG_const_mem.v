module HG_const_mem #(
parameter ADDR_WIDTH = 6,
parameter PATH = "./constant.mem"
)(
input  [ADDR_WIDTH-1:0] i_addr,
output reg [7:0] data
);

localparam DEPTH = 1 << ADDR_WIDTH;
reg [7:0] mem [0:DEPTH-1];

initial begin
    $readmemh(PATH, mem);
end

always @(*) begin
    data = mem[i_addr];
end

endmodule
