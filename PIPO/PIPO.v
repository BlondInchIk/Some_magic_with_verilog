module pipo #(parameter DATA_WIDTH = 8) (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire set_all_ones,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 0;
    end else if (enable) begin
        if (set_all_ones) begin
            data_out <= {DATA_WIDTH{1'b1}};
        end else begin
            data_out <= data_in;
        end
    end
end

endmodule