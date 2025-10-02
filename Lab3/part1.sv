module full_adder (input logic a, b, c_in, output logic s, c_out);
    logic w;

    // w = a XOR b
    assign w = a ^ b;

    // sum = (a XOR b) XOR c_in
    assign s = w ^ c_in;

    // carry
    assign c_out = (~w & b) | (w & c_in);

endmodule


module part1 (input logic [3:0] a, b, input logic c_in, output logic [3:0]s, c_out);

    full_adder u0(a[0], b[0], c_in, s[0], c_out[0]);
    full_adder u1(a[1], b[1], c_out[0], s[1], c_out[1]);
    full_adder u2(a[2], b[2], c_out[1], s[2], c_out[2]);
    full_adder u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule
