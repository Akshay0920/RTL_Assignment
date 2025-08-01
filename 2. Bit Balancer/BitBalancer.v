// Module: BitBalancer

// Counts the number of set bits (1s) in an 8-bit input.
module BitBalancer(
    input  [7:0] data_in,
    output reg [3:0] one_count
);

    // An integer for the loop counter.
    integer i;

    // Use a combinational always block to count the bits.
    // This block re-evaluates whenever the input `data_in` changes.
    always @(*) begin
        one_count = 4'd0; // Reset count to zero for each new input.
        for (i = 0; i < 8; i = i + 1) begin
            if (data_in[i] == 1'b1) begin
                one_count = one_count + 1;
            end
        end
    end

endmodule
