// Module: EdgeHighlighter

// Detects rising and falling edges and generates single-cycle pulses.
module EdgeHighlighter(
    input        clk,
    input        rst_n,
    input        sig_in,
    output       rising_edge_pulse,
    output       falling_edge_pulse
);

    // Register to store the input's value from the previous cycle.
    reg sig_in_prev;

    // On each clock edge, update the stored previous value.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sig_in_prev <= 1'b0;
        end
        else begin
            sig_in_prev <= sig_in;
        end
    end

    // A rising edge occurs when the previous value was 0 and the current is 1.
    assign rising_edge_pulse = (sig_in == 1'b1) & (sig_in_prev == 1'b0);

    // A falling edge occurs when the previous value was 1 and the current is 0.
    assign falling_edge_pulse = (sig_in == 1'b0) & (sig_in_prev == 1'b1);

endmodule
