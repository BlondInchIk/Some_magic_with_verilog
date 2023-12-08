`timescale 1ns / 1ps
module SISO (
input wire clk,
input wire b,
input wire reset,
output reg q
);

always @(posedge clk) begin
if (reset)
q <= 1'b0;
else
q <= b;
end

endmodule