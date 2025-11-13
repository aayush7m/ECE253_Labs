# ECE253 Labs

Our lab work for ECE253 (Digital and Computer Systems) at the University of Toronto, done together by Aayush and Mani. Labs 2–4 are in SystemVerilog, with ModelSim `.do` scripts for simulation. Labs 6–9 are in RISC-V assembly for the DE1-SoC board / CPUlator.

## Lab 2: Multiplexers
We built a 2-to-1 multiplexer two ways: once with a single behavioural `assign`, and once structurally by wiring together models of 7400-series logic chips (7404 NOT, 7408 AND, 7432 OR). Part 3 is a 7-to-1 multiplexer written with a `case` statement, and the design is simulated in ModelSim with a `.do` script.

## Lab 3: Adders and ALUs
We made a full adder and chained four of them into a 4-bit ripple-carry adder. That adder then went into a 4-bit ALU that can add, OR-reduce, AND-reduce, or concatenate its inputs. Part 3 adds a clocked register with synchronous reset, which turns it into an accumulator-style ALU that can add, multiply, shift, or hold.

## Lab 4: Shift Registers and Counters
We designed a 4-bit rotating register out of multiplexers and flip-flops. It supports parallel load, rotate left/right, and arithmetic shift right. Part 2 is a parameterized rate divider that drives a 4-bit counter, so the count speed can be selected.

## Lab 6: Intro to RISC-V Assembly
Our first assembly programs walk through a list ending in -1 to count its elements and add them up, and there's also an optimized version of that loop. Part 2 finds the longest run of consecutive 1s in a word by repeatedly computing `x & (x >> 1)`.

## Lab 7: Subroutines
We moved the longest-run-of-1s code into a subroutine and called it on every word in a list to find the maximum. Part 2 is an in-place bubble sort that calls a `SWAP` subroutine and stops early once a pass makes no swaps (`part2_pseudocode.s` is our planning sketch).

