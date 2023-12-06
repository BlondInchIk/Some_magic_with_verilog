// test bench
module piso_tb();
    reg [3:0]b;
    reg clk,sl;
    wire q;
piso_design dut(clk,load,parallel_In,serial_Out);
initial begin
    clk=1'b0;
    forever #5 clk=~clk;
end
initial begin
    load    =   0;  parallel_In=4'b0101;
    #20 load    =   1;
    #20 load    =   1;
    #10 load    =   0;
    #10 load    =   0;//b=4'b0110;
    #100 $finish;
end
endmodule