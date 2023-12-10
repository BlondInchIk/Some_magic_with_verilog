    module tb_br;  
       parameter MSB = 16;        // [Optional] Declare a parameter to represent number of bits in shift register  
    
    reg data;                  // Declare a variable to drive d-input of design  
    reg clk;                   // Declare a variable to drive clock to the design  
    reg en;                    // Declare a variable to drive enable to the design  
    reg dir;                   // Declare a variable to drive direction of shift register  
    reg rstn;                  // Declare a variable to drive reset to the design  
    wire [MSB-1:0] out;        // Declare a wire to capture output from the design  
    
    // Instantiate design (16-bit shift register) by passing MSB and connect with TB signals  
    shift_reg  #(MSB) sr0  (  .d (data),  
                                .clk (clk),  
                                .en (en),  
                                .dir (dir),  
                                .rstn (rstn),  
                                .out (out));  
    
    // Generate clock time period = 20ns, freq => 50MHz  
    always #10 clk = ~clk;  
    
    initial begin  
        clk <= 0;  
        en <= 0;  
        dir <= 0;  
        rstn <= 0;  
        data <= 'h1;  
    end  
    
    initial begin   
        $monitor ("rstn=%0b data=%b, en=%0b, dir=%0b, out=%b", rstn, data, en, dir, out);
        rstn <= 0;  
        #20 rstn <= 1;  
            en <= 1;  
    
        repeat (7) @ (posedge clk)  
            data <= ~data;  
    
        #10 dir <= 1;  
        repeat (7) @ (posedge clk)  
            data <= ~data;  
    
        repeat (7) @ (posedge clk);  
    
        $finish; 
         
    end  
    
      initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
    end
endmodule  