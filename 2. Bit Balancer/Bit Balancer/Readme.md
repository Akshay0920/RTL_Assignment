# Challenge 2: BitBalancer

### 1. Problem Description
- The task is to count the number of 1s in an 8-bit input value and output the total count. 
- The design must ensure the count resets correctly for each new input.

### 2. Design Approach
- The circuit is purely combinational, implemented with an `always @(*)` block. 
- This ensures the output count updates immediately whenever the 8-bit input changes.

- The logic uses a `for` loop to iterate through each bit of the input vector. A 4-bit register, `one_count`, is incremented for each bit that is a '1'. 
- The counter is initialized to zero at the start of every block execution, which satisfies the requirement for the count to reset for each new input.

### 3. Files
* `BitBalancer.v`: The Verilog design module.
* `tb_BitBalancer.v`: The testbench for verification.

### 4. Simulation Results
- The design was verified using a testbench that provided several 8-bit values, including edge cases (all zeros, all ones) and various mixed patterns. 
- The simulation log confirmed that the `one_count` output was correct for every input vector. All test cases passed.

- ![Waveform](../images/waveform2.png)
