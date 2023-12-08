module testbench;

reg clk;
reg rst;
wire [3:0] out;

shift_register dut(
    .clk(clk),
    .rst(rst),
    .out(out)
);

initial begin
    clk = 0;
    forever #5 clk =  clk;
end

initial begin
    rst = 1;
    #10 rst = 0;
end

initial begin
    #20 finish;
end

endmodule