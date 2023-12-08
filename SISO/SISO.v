module siso_4bit #(parameter WIDTH=4) (input wire clk, input wire reset, input wire data_in, input wire enable,
                                      input wire set_all_ones, output reg [WIDTH-1:0] data_out);

  always @(posedge clk or posedge reset) begin
    if (reset)
      data_out <= {WIDTH{1'b0}};  // Сброс данных при сигнале reset
    else if (enable) begin
      if (set_all_ones)
        data_out <= {WIDTH{1'b1}};  // Установка всех разрядов в 1
      else
        data_out <= {data_out[WIDTH-2:0], data_in};  // Загрузка данных в последний разряд
    end
  end

endmodule