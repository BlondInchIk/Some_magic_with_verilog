module testbench;

localparam WIDTH = 8;

reg clk;
reg rst_n;
reg shift_en;
reg data_in;
wire [3:0] seg_out;
wire [WIDTH-1:0] data_out;
  
shift_reg #(WIDTH) shft (
    .clk (clk),
    .rst_n (rst_n),
    .data_in (data_in),
    .shift_en (shift_en),
    .seg_out (seg_out),
    .data_out (data_out)
);

// Генерация тактового сигнала
initial begin
    clk = 0;
    forever #4 clk = ~clk;
end

// Функция для генерации последовательности значений
task push;
begin
    $display("########## Shift enable active ##########");
    shift_en = 1'b1;
    repeat(9) begin
        @(negedge clk)
        data_in = $urandom % 2;
    end
    shift_en = 1'b0;
    $display("########## Shift enable disable ##########\n");
end
endtask

// Функция для сброса
task async_rst;
begin
    $display("########## RESET start! ##########");
    #10 rst_n = 1'b0;
    #10 rst_n = 1'b1;
    $display("########## RESET finish!\n ##########");
end
endtask

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
    
    $display("#################### Starting simulation ####################");
    
    shift_en = 1'b0;
    rst_n = 1'b1;
    data_in = 1'b0;
    
    // Сброс
    async_rst();
    
    // Генерация последовательности
    repeat(10) begin
        #50 push;
    end
    
    #200 $finish;
end

// Отслеживание выходных значений
always @(posedge clk) begin
    $display("@time=%0t\tseg_out=%d\tdata_out=0x%h\t", $time, seg_out, data_out);
end


  initial begin
    $dumpfile("dump.vcd");  // Запись VCD-файла для отладки
    $dumpvars(0, testbench);  // Запись переменных в VCD-файл
    $monitor($time, "data_out = %b", data_out);  // Вывод значения data_out во время симуляции
  end

endmodule // testbench
