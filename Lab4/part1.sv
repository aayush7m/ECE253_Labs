module rotate_reg(input logic right, left, LoadLeft, D, loadn, clk, reset, output logic Q);
    logic w0;  //output of first mux of loadleft
    logic w1; //output of seconf mux of loadn goign into the FF
    assign w0 = (LoadLeft) ? left : right;
    assign w1 = (loadn) ? w0 : D; 

    always_ff @(posedge clk)
    begin
        if(reset)
            Q <= 1'b0;
        else
            Q <= w1; 
    end
endmodule


module part1 (input logic clock, reset, ParallelLoadn, RotateRight, ASRight, input logic [3:0] Data_IN, output logic [3:0] Q);
    
    //Deal with ASRight and its effect on Q3 output
    logic left_input3;

    always_comb
    begin 
        if(ASRight && RotateRight)
            left_input3 = Q[3];  //to copy we keep Q3 
        else
            left_input3 = Q[0];  
    end

    //instantiate 4 rotate_reg
    rotate_reg u3 (Q[2], left_input3, RotateRight, Data_IN[3], ParallelLoadn, clock, reset, Q[3]);
    rotate_reg u2 (Q[1], Q[3], RotateRight, Data_IN[2], ParallelLoadn, clock, reset, Q[2]);
    rotate_reg u1 (Q[0], Q[2], RotateRight, Data_IN[1], ParallelLoadn, clock, reset, Q[1]);
    rotate_reg u0 (Q[3], Q[1], RotateRight, Data_IN[0], ParallelLoadn, clock, reset, Q[0]);
endmodule

