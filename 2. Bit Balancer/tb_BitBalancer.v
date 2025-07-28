// Testbench for the BitBalancer module.

module tb_BitBalancer;

    // Testbench signals
    reg  [7:0] data_in;
    wire [3:0] one_count;

    // Instantiate the Design Under Test (DUT)
    BitBalancer dut (
        .data_in(data_in),
        .one_count(one_count)
    );

    // Test stimulus sequence
    initial begin
        // All zeros
        data_in = 8'b00000000;
        #10;

        // All ones
        data_in = 8'b11111111;
        #10;

        // Alternating bits
        data_in = 8'b10101010;
        #10;
        
        // A custom value
        data_in = 8'b11010011;
        #10;

        // A single bit
        data_in = 8'b00000001;
        #10;

        $finish;
    end

    // Display results in the simulation log when inputs change.
    initial begin
        $monitor("Input: %b, Count: %d", data_in, one_count);
    end

    // Commands to create the waveform dump file
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_BitBalancer);
    end

endmodule
