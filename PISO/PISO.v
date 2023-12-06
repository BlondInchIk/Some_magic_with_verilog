`timescale 1ns / 1ps
module piso_design (
  clk, 
  parallel_In,
  load, 
  serial_Out
);

  input clk,load;
  input [3:0]parallel_In;
  output reg serial_Out;
  reg [3:0]tmp;

always @(posedge clk) begin
  if(load)
    tmp<=parallel_In;
  else
  begin
    serial_Out<=tmp[3];
    tmp<={tmp[2:0],1'b0};
  end
end
endmodule