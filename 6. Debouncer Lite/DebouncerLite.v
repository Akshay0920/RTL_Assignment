// Module: DebouncerLite

// Filters a noisy input to produce a clean, stable output.
module DebouncerLite(
    input        clk,
    input        rst_n,
    input        noisy_in,
    output reg   clean_out
);

    // Define how many cycles the input must be stable to be valid.
    parameter STABLE_CYCLES = 4;
    
    // Calculate the number of bits needed for the counter.
    localparam COUNTER_BITS = $clog2(STABLE_CYCLES) + 1;

    // Internal registers
    reg [COUNTER_BITS-1:0] counter;
    reg [1:0]              sync_ff; // 2-flip-flop synchronizer

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync_ff   <= 2'b0;
            counter   <= 0;
            clean_out <= 1'b0;
        end
        else begin
            // 1. Synchronize the asynchronous input to the clock domain.
            sync_ff <= {sync_ff[0], noisy_in};

            // 2. Check the stable, synchronized input.
            if (sync_ff[1] == 1'b1) begin
                // If input is high, increment counter until it's full.
                if (counter < STABLE_CYCLES) begin
                    counter <= counter + 1;
                end
            end
            else begin
                // If input is low, reset the counter.
                counter <= 0;
            end

            // 3. Set the clean output based on the counter status.
            if (counter == STABLE_CYCLES) begin
                clean_out <= 1'b1;
            end
            else begin
                // Output goes low immediately if input is not stable high.
                clean_out <= 1'b0;
            end
        end
    end

endmodule
