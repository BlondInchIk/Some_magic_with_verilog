module piso_4bit #(parameter WIDTH=4) (input wire clk, input wire reset, input wire [WIDTH-1:0] data_in, input wire enable,
                                      input wire set_all_ones, output reg data_out);

  always @(posedge clk or posedge reset) begin
    if (reset)
      data_out <= 1'b0;  // Сброс данных при сигнале reset
    else if (enable) begin
      if (set_all_ones)
        data_out <= &data_in;  // Установка всех разрядов в 1
      else
        data_out <= data_in[0];  // Загрузка первого разряда
    end
  end

endmodule