// Testbench 
module tb_LightChaser;

    // Testbench signals
    reg        clk;
    reg        rst_n;
    reg        enable;
    wire [7:0] led_pattern;

    // Instantiate the Design Under Test (DUT)
    LightChaser dut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .led_pattern(led_pattern)
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
        enable = 1'b0;
        #20;
        rst_n  = 1'b1;
        
        // Enable the rotation
        enable = 1'b1;
        #80; // Run for 8 rotations (8 * 4 cycles = 32 cycles total)

        //  Disable the rotation
        enable = 1'b0;
        #40; // Pattern should freeze

        // Re-enable the rotation
        enable = 1'b1;
        #40; // Pattern should resume rotating

        $finish;
    end

    // Display results in the simulation log.
    initial begin
        $monitor("Time: %0t | Enable: %b | LED Pattern: %b",
                  $time, enable, led_pattern);
    end

    // Commands to create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_LightChaser);
    end

endmodule
