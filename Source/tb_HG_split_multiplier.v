module tb_HG_split_multiplier;

    parameter WIDTH = 8;
    reg  [WIDTH-1:0] F;
    wire [WIDTH-1:0] result;

    HG_split_multiplier #(.WIDTH(WIDTH)) uut (
        .F(F),
        .result(result)
    );

    initial begin

        F = 8'h23;
        #10;
        $display("F = %h, Upper = %h, Lower = %h, Result = %h", F, F[7:4], F[3:0], result);


        F = 8'hF1;
        #10;
        $display("F = %h, Upper = %h, Lower = %h, Result = %h", F, F[7:4], F[3:0], result);
        
        $finish;
    end

endmodule