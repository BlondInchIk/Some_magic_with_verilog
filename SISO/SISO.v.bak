module siso #(parameter DATA_WIDTH = 8) (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire set_all_ones,
    input wire data_in,
    output reg data_out
);

reg [DATA_WIDTH-1:0] shift_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        shift_reg <= 0;
    end else if (enable) begin
        if (set_all_ones) begin
            shift_reg <= {DATA_WIDTH{1'b1}};
        end else begin
            shift_reg <= {shift_reg[DATA_WIDTH-2:0], data_in};
        end
    end
end

assign data_out = shift_reg[DATA_WIDTH-1];

endmodule