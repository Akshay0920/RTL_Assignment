// EvenOddFSM

// A Finite State Machine that tracks the parity of incoming bits.
module EvenOddFSM(
    input        clk,
    input        rst_n,
    input        bit_in,
    output reg   is_odd
);

    // Define the states for the FSM.
    parameter EVEN_STATE = 1'b0;
    parameter ODD_STATE  = 1'b1;

    // State registers.
    reg current_state;
    reg next_state;

    // Sequential Block: Handles state transitions on clock edges.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= EVEN_STATE; // Reset to the EVEN state.
        end
        else begin
            current_state <= next_state;
        end
    end

    // Combinational Block: Determines the next state based on
    // the current state and the input bit.
    always @(*) begin
        case (current_state)
            EVEN_STATE: begin
                if (bit_in)
                    next_state = ODD_STATE; // Even + 1 = Odd
                else
                    next_state = EVEN_STATE;
            end
            ODD_STATE: begin
                if (bit_in)
                    next_state = EVEN_STATE; // Odd + 1 = Even
                else
                    next_state = ODD_STATE;
            end
            default: begin
                next_state = EVEN_STATE;
            end
        endcase
    end

    // Output Logic Block: Sets the output based on the current state.
    // This is a Moore FSM, as the output depends only on the state.
    always @(*) begin
        if (current_state == ODD_STATE) begin
            is_odd = 1'b1;
        end
        else begin
            is_odd = 1'b0;
        end
    end

endmodule
