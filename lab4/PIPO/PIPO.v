module pipo #(parameter WIDTH=8)
(
  input wire [WIDTH-1:0] data_in,
  input wire enable,
  input wire load_all_ones,
  output reg [WIDTH-1:0] data_out
);

  always @ (posedge enable)
  begin
    if (load_all_ones)
      data_out <= {WIDTH{1'b1}};
    else
      data_out <= data_in;
  end

endmodule