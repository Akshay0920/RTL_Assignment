// Testbench

module tb_GrayCoder;

    // Testbench signals
    reg  [3:0] bin_in;
    wire [3:0] gray_out;

    // An integer for the loop counter.
    integer i;

    // Instantiate the Design Under Test (DUT)
    GrayCoder dut (
        .bin_in(bin_in),
        .gray_out(gray_out)
    );

    // Test stimulus sequence
    initial begin
        // Loop through all 16 possible 4-bit inputs
        for (i = 0; i < 16; i = i + 1) begin
            bin_in = i;
            #10;
        end
        $finish;
    end

    // Display results in the simulation log when inputs change.
    initial begin
        $monitor("Time: %0t | Binary In: %b | Gray Out: %b",
                  $time, bin_in, gray_out);
    end

    // Commands to create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_GrayCoder);
    end

endmodule
