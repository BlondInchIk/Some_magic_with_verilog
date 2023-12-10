module testbench;

  reg [WIDTH-1:0] data_in;
  reg enable;
  reg load_all_ones;
  wire [WIDTH-1:0] data_out;

  parameter WIDTH = 8;

  pipo #(.WIDTH(WIDTH)) dut (
    .data_in(data_in),
    .enable(enable),
    .load_all_ones(load_all_ones),
    .data_out(data_out)
  );

  initial begin

    enable = 0;
    load_all_ones = 0;
    data_in = 8'b10101010;

    #10;

    enable = 1;
    load_all_ones = 0;
    data_in = 8'b11001100;

    #10;

    enable = 1;
    load_all_ones = 1;
    data_in = 8'b11110000;

    #10;

    #10 $finish;
  end
  initial begin
    $dumpfile("dump.vcd");  // Запись VCD-файла для отладки
    $dumpvars(0, testbench);  // Запись переменных в VCD-файл
    $monitor($time, "data_out = %b", data_out);  // Вывод значения data_out во время симуляции
  end
endmodule
