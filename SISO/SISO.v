`timescale 1ns / 1ps
module SISO (
input wire clk,
input wire b,
output reg q
);

always @(posedge clk) begin
q <= b;
end

endmodule