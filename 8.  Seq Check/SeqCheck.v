// Module: SeqCheck

// Detects 3 rising edges on an input within a 5-cycle window.
module SeqCheck(
    input   clk,
    input   rst_n,
    input   sig_in,
    output  flag_out
);

    // Internal signals
    reg   sig_in_prev;
    wire  rise_event;
    reg [4:0] window_sr;   // 5-bit shift register for the window
    reg [2:0] edge_count;  // Counter for the number of edges
    
    integer i;

    // 1. Rising Edge Detector
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sig_in_prev <= 1'b0;
        end
        else begin
            sig_in_prev <= sig_in;
        end
    end
    assign rise_event = sig_in & ~sig_in_prev;

    // 2. Windowed Shift Register
    // On every clock, shift in the result of the edge detection.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            window_sr <= 5'b0;
        end
        else begin
            window_sr <= {window_sr[3:0], rise_event};
        end
    end
    
    // 3. Bit Counter
    // Combinational logic to count the number of events in the window.
    always @(*) begin
        edge_count = 3'd0;
        for (i = 0; i < 5; i = i + 1) begin
            if (window_sr[i] == 1'b1) begin
                edge_count = edge_count + 1;
            end
        end
    end

    // 4. Output Logic
    // Assert the flag for a single cycle when the condition is met.
    reg condition_met_prev;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            condition_met_prev <= 1'b0;
        end
        else begin
            condition_met_prev <= (edge_count >= 3);
        end
    end
    
    assign flag_out = (edge_count >= 3) & ~condition_met_prev;

endmodule
