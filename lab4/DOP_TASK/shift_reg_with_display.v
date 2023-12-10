module shift_reg_with_display#(
  parameter WIDTH=8
)(
    input CLOCK_50,
    input [1:0] KEY,
    input [0:0] SW,
    output [9:0] LEDR,
    output [7:0] HEX1,
    output [7:0] HEX0
);

localparam CNT_W = 8, MAX_LED = 10;

wire clk_slow;
wire clk_global;
wire [CNT_W - 1:0] cnt_to_seg7;

assign LEDR[CNT_W - 1:0] = cnt_to_seg7;
assign LEDR[MAX_LED - 2: CNT_W] = {MAX_LED-CNT_W-1{1'b0}};

// Добавляем модуль делителя частоты для уменьшения частоты тактирования
clk_divider #(.WIDTH(25)) clk_div (
    .clk_in ( CLOCK_50 ),
    .rst_n ( KEY[0] ),
    .clk_out ( clk_slow )
);


// Используем модуль сдвигового регистра для создания последовательности цифр
shift_reg #(.WIDTH(CNT_W)) shift_inst (
    .clk ( clk_global ),
    .rst_n ( KEY[0] ),
    .data_in ( KEY[1] ),
    .shift_en ( SW ),
    .data_out ( cnt_to_seg7 ),
    .serial_out( LEDR[9] )
);

// Используем модуль семисегментного дисплея для отображения цифр
led7 #(.COUNT(2)) led7_4 (
    .data(cnt_to_seg7),
    .leds({HEX1,HEX0})
);

endmodule
