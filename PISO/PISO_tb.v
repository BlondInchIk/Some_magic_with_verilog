module piso_4bit_tb;
  parameter WIDTH = 4;

  reg clk;
  reg reset;
  reg [WIDTH-1:0] data_in;
  reg enable;
  reg set_all_ones;
  wire data_out;

  piso_4bit #(WIDTH) dut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .enable(enable),
    .set_all_ones(set_all_ones),
    .data_out(data_out)
  );

  always #5 clk = ~clk;  // Генерация тактового сигнала

  initial begin
    clk = 1'b0;
    reset = 1'b1;
    data_in = 4'b0000;
    enable = 1'b0;
    set_all_ones = 1'b0;

    #10 reset = 1'b0;  // Сброс сигнала reset
    #10 enable = 1'b1;  // Разрешение загрузки данных

    // Тестовые векторы
    #10 data_in = 4'b1010;  // Загрузка данных

    #10 set_all_ones = 1'b1;  // Установка всех разрядов в 1
    #10 set_all_ones = 1'b0;

    #10 enable = 1'b0;  // Загрузка данных отключена

    #10 $finish;  // Окончание симуляции
  end

  initial begin
    $dumpfile("dump.vcd");  // Запись VCD-файла для отладки
    $dumpvars(0, piso_4bit_tb);  // Запись переменных в VCD-файл
    $monitor($time, "data_out = %b", data_out);  // Вывод значения data_out во время симуляции
  end

endmodule