// Module: GrayCoder

// Converts a 4-bit binary input to its Gray code equivalent.
module GrayCoder(
    input  [3:0] bin_in,
    output [3:0] gray_out
);

    // Gray code can be calculated by XORing the binary number
    // with itself right-shifted by one position.
    assign gray_out = bin_in ^ (bin_in >> 1);

endmodule
