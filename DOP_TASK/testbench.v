module shift_reg_with_display_tb;

reg CLOCK_50;
reg [1:0] KEY;
reg [0:0] SW;
wire [9:0] LEDR;
wire [7:0] HEX1;
wire [7:0] HEX0;

// подключение модуля shift_reg_with_display
shift_reg_with_display dut (
    .CLOCK_50(CLOCK_50),
    .KEY(KEY),
    .SW(SW),
    .LEDR(LEDR),
    .HEX1(HEX1),
    .HEX0(HEX0)
);

// генерация тактового сигнала
always begin
    #5 CLOCK_50 = ~CLOCK_50;
end

// генерация входных сигналов
initial begin
    KEY = 2'b00; // установка начальных значений ключей
    SW = 1'b0; // установка начального значения переключателя
    #10 KEY = 2'b01; // изменение значения ключей после некоторого времени
    #100 $finish; // завершение симуляции после некоторого времени
end

endmodule
