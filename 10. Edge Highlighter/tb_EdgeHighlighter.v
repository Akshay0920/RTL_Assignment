// Testbench 
module tb_EdgeHighlighter;

    // Testbench signals
    reg  clk;
    reg  rst_n;
    reg  sig_in;
    wire rising_edge_pulse;
    wire falling_edge_pulse;

    // Instantiate the Design Under Test (DUT)
    EdgeHighlighter dut (
        .clk(clk),
        .rst_n(rst_n),
        .sig_in(sig_in),
        .rising_edge_pulse(rising_edge_pulse),
        .falling_edge_pulse(falling_edge_pulse)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus sequence
    initial begin
        // Apply reset
        rst_n  = 1'b0;
        sig_in = 1'b0;
        #20;
        rst_n  = 1'b1;
        
        // Generate a rising edge
        @(posedge clk);
        sig_in = 1'b1;
        #20;

        // Generate a falling edge
        @(posedge clk);
        sig_in = 1'b0;
        #20;

        // Generate a full pulse
        @(posedge clk); sig_in = 1'b1; // Rising
        @(posedge clk); sig_in = 1'b0; // Falling
        #20;

        $finish;
    end

    // Display results in the simulation log.
    initial begin
        $monitor("Time: %0t | Sig In: %b | Rising Pulse: %b | Falling Pulse: %b",
                  $time, sig_in, rising_edge_pulse, falling_edge_pulse);
    end

    // Commands to create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_EdgeHighlighter);
    end

endmodule
