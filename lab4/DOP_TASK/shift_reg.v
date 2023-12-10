module shift_reg #(parameter WIDTH = 8) (
    input clk,
    input rst_n,
    input data_in,
    input shift_en,
    output reg [3:0] seg_out,
    output reg [WIDTH-1:0] data_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            data_out <= {WIDTH{1'b0}};
        else if (shift_en)
            data_out <= {data_in,data_out[WIDTH-1:1]};
    end
    
    always @(posedge clk) begin
        if (shift_en)
            seg_out <= data_out[WIDTH-1:WIDTH-4];
    end

endmodule // shift_reg
