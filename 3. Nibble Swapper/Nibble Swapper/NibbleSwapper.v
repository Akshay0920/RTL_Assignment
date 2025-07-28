// Module: NibbleSwapper

// Swaps the upper and lower 4 bits (nibbles) of an 8-bit input.
module NibbleSwapper(
    input  [7:0] data_in,
    input        swap_en,
    output [7:0] data_out
);

    // A single continuous assignment with a ternary operator to select the output.
    // If swap_en is high, concatenate the swapped nibbles {lower, upper}.
    // Otherwise, pass the input through unchanged.
    assign data_out = swap_en ? {data_in[3:0], data_in[7:4]} : data_in;

endmodule
