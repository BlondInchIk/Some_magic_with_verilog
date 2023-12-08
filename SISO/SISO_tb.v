// testbench
module SISO_tb();

reg clk,b,reset;
wire q;

SISO uut(.clk(clk),.b(b),.q(q),.reset(reset));

initial
begin
clk=1'b0;
forever #5clk=~clk;
end

initial
begin
$monitor("clk=%d,b=%d,q=%d,reset=%d",clk,b,q,reset);
end

initial
begin
b=1;
#10;
b=1;
reset=1;
#10
b=1;
reset=0;
#10;
b=0;

#50;
$finish;

end
endmodule