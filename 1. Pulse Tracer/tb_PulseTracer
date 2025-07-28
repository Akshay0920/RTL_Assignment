// Testbench

module tb_PulseTracer;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg noisy_in;
    wire pulse_detected;

    // Instantiate the Design Under Test (DUT)
    PulseTracer dut (
        .clk(clk),
        .rst_n(rst_n),
        .noisy_in(noisy_in),
        .pulse_detected(pulse_detected)
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
        noisy_in = 1'b0;
        #20;
        rst_n = 1'b1;
        #10;

        // Test 1: Perfect one-cycle pulse
        @(posedge clk);
        noisy_in = 1'b1;
        @(posedge clk);
        noisy_in = 1'b0;
        #20;

        // Test 2: Two-cycle pulse (should be ignored)
        @(posedge clk);
        noisy_in = 1'b1;
        @(posedge clk);
        noisy_in = 1'b1;
        @(posedge clk);
        noisy_in = 1'b0;
        #20;

        $finish;
    end

    // Commands to create the waveform dump file
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_PulseTracer);
    end

endmodule
