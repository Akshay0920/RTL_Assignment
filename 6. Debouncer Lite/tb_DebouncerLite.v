// Testbench

module tb_DebouncerLite;

    // Testbench signals
    reg  clk;
    reg  rst_n;
    reg  noisy_in;
    wire clean_out;

    // Instantiate the Design Under Test (DUT)
    DebouncerLite dut (
        .clk(clk),
        .rst_n(rst_n),
        .noisy_in(noisy_in),
        .clean_out(clean_out)
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
        
        // Bouncing signal on press
        #10; noisy_in = 1'b1; // First contact
        #10; noisy_in = 1'b0; // Bounce
        #10; noisy_in = 1'b1; // Bounce
        #10; noisy_in = 1'b0; // Bounce
        #10; noisy_in = 1'b1; // Stable high

        // Wait long enough for the output to go high
        #100;

        // Bouncing signal on release
        noisy_in = 1'b0; // First release
        #10; noisy_in = 1'b1; // Bounce
        #10; noisy_in = 1'b0; // Stable low
        #50;

        $finish;
    end

    // Display results in the simulation log.
    initial begin
        $monitor("Time: %0t | Noisy In: %b | Clean Out: %b",
                  $time, noisy_in, clean_out);
    end

    // Commands to create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_DebouncerLite);
    end

endmodule
