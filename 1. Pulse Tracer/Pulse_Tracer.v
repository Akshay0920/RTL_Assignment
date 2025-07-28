// PulseTracer

// Detects a single-cycle high pulse.
module PulseTracer(
    input clk,
    input rst_n,
    input noisy_in,
    output pulse_detected
);
    // Registers to store a 2-cycle history of the input.
    reg noisy_in_r1;
    reg noisy_in_r2;
    
    // On each clock edge, sample the input signal.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            noisy_in_r1 <= 1'b0;
            noisy_in_r2 <= 1'b0;
        end
        else begin
            noisy_in_r1 <= noisy_in;
            noisy_in_r2 <= noisy_in_r1;
        end
    end
    
    // Assert output high when the 0 -> 1 -> 0 pattern is detected.
    assign pulse_detected = (~noisy_in) & noisy_in_r1 & (~noisy_in_r2);

endmodule
