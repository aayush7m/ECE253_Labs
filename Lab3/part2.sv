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



module part2(input logic [3:0] A, B, input logic [1:0] Function, output logic [7:0] ALUout);
    logic [3:0] sum;
    logic [3:0] c_out;

    part1 rca_inst (
    .a(A),  //connect ALU input A to RCA input a
    .b(B),  //connect ALU input B to RCA input b
    .c_in(1'b0),  //force carry-in = 0
    .s(sum),   //RCA 4-bit sum goes to local wire s
    .c_out(c_out)  //RCA carry goes to local wire c_out
    );

    logic any_bit, all_bits;
    assign any_bit  = |{A, B};   // any_bit is a single bit (1 if any bit of A or B = 1)
    assign all_bits = &{A, B};   // all_bits is 1 only if all 8 bits of A and B are 1

    always_comb 
        begin
            case (Function)
                2'b00: ALUout = {3'b000, c_out[3], sum}; // zero-extend (carry + sum) to 8 bits
                2'b01: ALUout = {7'b0, any_bit};
                2'b10: ALUout = {7'b0, all_bits};
                2'b11: ALUout = {A, B};
                default: ALUout = 8'h00;
            endcase
        end
endmodule


