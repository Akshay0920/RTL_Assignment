// Testbench

module tb_EvenOddFSM;

    // Testbench signals
    reg  clk;
    reg  rst_n;
    reg  bit_in;
    wire is_odd;

    // Instantiate the Design Under Test (DUT)
    EvenOddFSM dut (
        .clk(clk),
        .rst_n(rst_n),
        .bit_in(bit_in),
        .is_odd(is_odd)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus sequence
    initial begin
        // Apply reset
        rst_n = 1'b0;
        bit_in = 1'b0;
        #20;
        rst_n = 1'b1;
        
        // Test sequence: 1, 0, 1, 1, 1
        @(posedge clk);
        bit_in = 1'b1; // Count of 1s is 1 (Odd)

        @(posedge clk);
        bit_in = 1'b0; // Count of 1s is 1 (Odd)

        @(posedge clk);
        bit_in = 1'b1; // Count of 1s is 2 (Even)

        @(posedge clk);
        bit_in = 1'b1; // Count of 1s is 3 (Odd)
        
        @(posedge clk);
        bit_in = 1'b1; // Count of 1s is 4 (Even)

        #10;
        $finish;
    end

    // Display results in the simulation log.
    initial begin
        $monitor("Time: %0t | Reset: %b | Input: %b | Is_Odd Output: %b",
                  $time, rst_n, bit_in, is_odd);
    end

    // Commands to create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_EvenOddFSM);
    end

endmodule
