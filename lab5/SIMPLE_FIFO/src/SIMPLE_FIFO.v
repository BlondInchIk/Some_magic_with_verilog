module fifo_mem(
// Вход управляющих сигналов
input wr,                           // Write Data
input rd,                           // Read Data
input clk,                          // Тактирование
input rst_n,                        // Сброс модуля FIFO памяти

// Входы и выходы данных
input[7:0] data_in,                 // Данные на вход
output[7:0] data_out,               // Данные на выход

// Выходные статусы модуля памяти
output fifo_full,                   // Буфер полон
output fifo_empty,                  // буфер пуст
output fifo_threshold, 
output fifo_overflow,               // Некуда записывать данные
output fifo_underflow               // Неоткуда считывать данные
);  

  wire[4:0] wptr, rptr;              // Указатели на запись (wptr) и на чтение (rptr)
  wire fifo_we, fifo_rd;             // Сигналы для разрешения записи (FIFO write enable) и чтения (FIFO read) 
  write_pointer top1(wptr,fifo_we,wr,fifo_full,clk,rst_n);              // Указатель на запись данных
  read_pointer top2(rptr,fifo_rd,rd,fifo_empty,clk,rst_n);              // Указатель на чтение данных
  memory_array top3(data_out, data_in, clk,fifo_we, wptr,rptr);         // Примитив памяти
  // Модуль генерации управляющих сигналов для управления FIFO
  status_signal top4(fifo_full, fifo_empty, fifo_threshold, fifo_overflow, fifo_underflow, wr, rd, fifo_we, fifo_rd, wptr,rptr,clk,rst_n);  
endmodule 
 

// Примитив объявления памяти в Verilog
 module memory_array(
    output wire[7:0] data_out,      // Выходные данные  
    input[7:0] data_in,             // Данные на вход
    input clk,                      // Тактирование и разрешение записи
    input fifo_we,                  
    input[4:0] wptr,                // Указатель на запись и указатель на чтение
    input[4:0] rptr                 
);  
  reg[7:0] data_out2[15:0];  

  always @(posedge clk)             // Работаем по положительному фрону тактирования
  begin  
   if(fifo_we)   
      data_out2[wptr[3:0]] <=data_in ;  
  end  
  assign data_out = data_out2[rptr[3:0]];  
endmodule  


// Модуль указателя чтения
module read_pointer(

output reg[4:0] rptr,               // Регистр для указателя на считывание
output fifo_rd,                     // Сигнал чтения

// Управляющие сигналы
input rd,                           // rd - чтение
input fifo_empty,                   // буфер FIFO пуст
input clk,                          // Тактирование
input rst_n                         // сброс модуля
);  
  
  assign fifo_rd = (~fifo_empty) & rd;  
  always @(posedge clk or negedge rst_n)  
  begin  
    if(~rst_n) rptr <= 5'b000000;  
   else if(fifo_rd)  
    rptr <= rptr + 5'b000001;  
   else  
    rptr <= rptr;  
  end  
 endmodule   


// Модуль указателя записи
module write_pointer(
    output reg [4:0] wptr,          // Регистр для хранения указателя для записи
    output fifo_we,                 // Сигнал записи

    input wr,                       // wr - запись
    input fifo_full,                // буфер FIFO полон
    input clk,                      // Тактирование
    input rst_n                     // сброс модуля
    );
      
  assign fifo_we = (~fifo_full)&wr;  
  always @(posedge clk or negedge rst_n)  
  begin  
   if(~rst_n) wptr <= 5'b000000;  
   else if(fifo_we)  
    wptr <= wptr + 5'b000001;  
   else  
    wptr <= wptr;  
  end  
 endmodule


module status_signal(
    
    output reg fifo_full,           // Буфер полон (некуда писать данные)
    output reg fifo_empty,          // Буфер пуст (нечего считывать)
    output reg fifo_threshold,  
    output reg fifo_overflow,       // Переполнение буфера. Возникает при попытке
                                    // записать данные в полный буфер
    output reg fifo_underflow,      // Аналог "fifo_overflow", возникает при
                                    // попытке считать данные из пустого буфера

    input wr,                       // Управляющий сигнал записи
    input rd,                       // Управляющий сигнал чтения
    input fifo_we,                  // 
    input fifo_rd, 
    input wire [4:0] wptr, 
	  input wire [4:0] rptr,  
    input clk,                      // Тактирование
    input rst_n                     // Сброс
); 

  wire fbit_comp, overflow_set, underflow_set;  
  wire pointer_equal;  
  wire[4:0] pointer_result;  
  
  assign fbit_comp = wptr[4] ^ rptr[4];  
  assign pointer_equal = (wptr[3:0] - rptr[3:0]) ? 0:1;  
  assign pointer_result = wptr[4:0] - rptr[4:0];  
  assign overflow_set = fifo_full & wr;  
  assign underflow_set = fifo_empty & rd;  
  
  // Блок комбинационной логики
  always @(*)                   
  begin  
   fifo_full =  fbit_comp & pointer_equal;  
   fifo_empty = (~fbit_comp) & pointer_equal;  
   fifo_threshold = (pointer_result[4]||pointer_result[3]) ? 1:0;  
  end  

// Блок генерации сигнала "переполнение буфера"
always @(posedge clk or negedge rst_n)  
begin  
  if(~rst_n) fifo_overflow <=0;  
  else if((overflow_set==1)&&(fifo_rd==0))  
   fifo_overflow <=1;  
   else if(fifo_rd)  
    fifo_overflow <=0;  
    else  
     fifo_overflow <= fifo_overflow;  
end  
  
// Блок генерации сигнала "недолив"
always @(posedge clk or negedge rst_n)  
begin  
  if(~rst_n) fifo_underflow <=0;  
  else if((underflow_set==1)&&(fifo_we==0))  
   fifo_underflow <=1;  
   else if(fifo_we)  
    fifo_underflow <=0;  
    else  
     fifo_underflow <= fifo_underflow;  
end  
endmodule  

