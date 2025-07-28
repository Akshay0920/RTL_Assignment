// Testbench 
module tb_NibbleSwapper;

    // Testbench signals
    reg  [7:0] data_in;
    reg        swap_en;
    wire [7:0] data_out;

    // Instantiate the Design Under Test (DUT)
    NibbleSwapper dut (
        .data_in(data_in),
        .swap_en(swap_en),
        .data_out(data_out)
    );

    // Test stimulus sequence
    initial begin
        // Swap disabled
        data_in = 8'hA5;
        swap_en = 1'b0;
        #10;

        // Swap enabled
        swap_en = 1'b1;
        #10;

        // Change input while swap is enabled
        data_in = 8'h12;
        #10;

        // Disable swap again
        swap_en = 1'b0;
        #10;

        $finish;
    end

    // Display results in the simulation log when any signal changes.
    initial begin
        $monitor("Time: %0t | Swap Enable: %b | Input: %h | Output: %h",
                  $time, swap_en, data_in, data_out);
    end

    // To create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_NibbleSwapper);
    end

endmodule
