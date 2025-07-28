// Testbench 
module tb_RotatorUnit;

    // Testbench signals
    reg        clk;
    reg        rst_n;
    reg        direction;
    wire [7:0] rotated_out;

    // Instantiate the Design Under Test (DUT)
    RotatorUnit dut (
        .clk(clk),
        .rst_n(rst_n),
        .direction(direction),
        .rotated_out(rotated_out)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus sequence
    initial begin
        // Apply reset
        rst_n     = 1'b0;
        direction = 1'b0;
        #20;
        rst_n     = 1'b1;
        
        // Rotate Left
        direction = 1'b1;
        #80; // Run for 8 cycles to see a full rotation

        // Rotate Right
        direction = 1'b0;
        #80; // Run for 8 cycles to rotate back to the start

        // Change direction dynamically
        direction = 1'b1; #20;
        direction = 1'b0; #20;
        direction = 1'b1; #20;

        $finish;
    end

    // Display results in the simulation log.
    initial begin
        $monitor("Time: %0t | Direction: %b | Rotated Out: %b",
                  $time, direction, rotated_out);
    end

    // Commands to create the waveform dump file.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_RotatorUnit);
    end

endmodule
