// Testbench

module tb_SeqCheck;

    // Testbench signals
    reg   clk;
    reg   rst_n;
    reg   sig_in;
    wire  flag_out;

    // Instantiate the Design Under Test (DUT)
    SeqCheck dut (
        .clk(clk),
        .rst_n(rst_n),
        .sig_in(sig_in),
        .flag_out(flag_out)
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
        
        // Test 1: Generate 3 edges within 5 cycles
        @(posedge clk); sig_in = 1'b1; // Edge 1
        @(posedge clk); sig_in = 1'b0;
        @(posedge clk); sig_in = 1'b1; // Edge 2
        @(posedge clk); sig_in = 1'b0;
        @(posedge clk); sig_in = 1'b1; // Edge 3 -> Flag should be asserted
        @(posedge clk); sig_in = 1'b0;
        #40;

        // Test 2: Edges are too far apart
        @(posedge clk); sig_in = 1'b1; // Edge 1
        @(posedge clk); sig_in = 1'b0;
        #30; // Wait 3 cycles
        @(posedge clk); sig_in = 1'b1; // Edge 2
        @(posedge clk); sig_in = 1'b0;
        #30; // Wait 3 cycles, first edge is now outside the window
        @(posedge clk); sig_in = 1'b1; // Edge 3 -> Flag should NOT be asserted
        @(posedge clk); sig_in = 1'b0;
        #40;

        $finish;
    end

    // Display results in the simulation log.
    initial begin
        $monitor("Time: %0t | Sig In: %b | Flag Out: %b",
                  $time, sig_in, flag_out);
    end

    // Commands to create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_SeqCheck);
    end

endmodule
