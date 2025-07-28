// Module: LightChaser

// Rotates a single bit through an 8-bit register.
module LightChaser(
    input        clk,
    input        rst_n,
    input        enable,
    output reg [7:0] led_pattern
);

    // Parameter to control the speed of rotation (shifts every N clock cycles).
    parameter ROTATE_SPEED = 4;

    // Counter to divide the clock.
    reg [$clog2(ROTATE_SPEED)-1:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset to a known starting pattern.
            led_pattern <= 8'b00000001;
            counter     <= 0;
        end
        else begin
            // Only count and rotate if the module is enabled.
            if (enable) begin
                // When the counter reaches its max, reset it and rotate the pattern.
                if (counter == ROTATE_SPEED - 1) begin
                    counter     <= 0;
                    led_pattern <= {led_pattern[6:0], led_pattern[7]}; // Circular shift left
                end
                else begin
                    counter <= counter + 1;
                end
            end
        end
    end

endmodule
