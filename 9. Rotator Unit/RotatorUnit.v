// Module: RotatorUnit

// Rotates an 8-bit pattern left or right on each clock cycle.
module RotatorUnit(
    input        clk,
    input        rst_n,
    input        direction, // 1 for left, 0 for right
    output reg [7:0] rotated_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Initialize to a known starting pattern on reset.
            rotated_out <= 8'b10000000;
        end
        else begin
            // Check the direction signal to decide which way to rotate.
            if (direction == 1'b1) begin
                // Rotate Left: MSB wraps around to LSB.
                rotated_out <= {rotated_out[6:0], rotated_out[7]};
            end
            else begin
                // Rotate Right: LSB wraps around to MSB.
                rotated_out <= {rotated_out[0], rotated_out[7:1]};
            end
        end
    end

endmodule
