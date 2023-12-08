module shift_register(
    input clk,
    input rst,
    output reg [3:0] out
);

reg [3:0] reg_out;
reg [3:0] next_val;

always @(posedge clk) begin
    if (rst) begin
        reg_out <= 4'b0000;
    end else begin
        reg_out <= next_val;
    end
end

always @(posedge clk) begin
    next_val <= reg_out + 1;
end

assign out = reg_out;

endmodule