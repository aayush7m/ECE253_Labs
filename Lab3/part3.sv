
module part3(input logic Clock, Reset_b, input logic [3:0] Data, input logic [2:0] Function, output logic [7:0] ALU_reg_out);
    logic [7:0] ALU_out;  // what to store on next clock (Alu value)

    logic [7:0] A_ext, B_ext;

    assign A_ext = {4'b0, Data};
    assign B_ext = {4'b0, ALU_reg_out[3:0]};

    // combinational ALU
    always_comb 
    begin
        case (Function)
            3'b000: ALU_out = A_ext + B_ext;
            3'b001: ALU_out = A_ext * B_ext;
            3'b010: ALU_out = B_ext << Data;
            3'b011: ALU_out = ALU_reg_out;   // hold
            default: ALU_out = 8'b00000000;
        endcase
    end
    
    // Sequential part
    always_ff @(posedge Clock) 
    begin
        if (Reset_b)
            ALU_reg_out <= 8'b0;   // clear to 0
        else
            ALU_reg_out <= ALU_out;  //store value
    end
endmodule