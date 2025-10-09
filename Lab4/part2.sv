
module part2 #(parameter CLOCK_FREQUENCY = 500)
    (input logic ClockIn, Reset, 
    input logic [1:0] Speed, 
    output logic [3:0] CounterValue);

    logic Enable;
    RateDivider #(.CLOCK_FREQUENCY (CLOCK_FREQUENCY)) u1 (ClockIn, Reset, Speed, Enable);
    DisplayCounter u2 (ClockIn, Reset, Enable, CounterValue); 
endmodule



module RateDivider #(parameter CLOCK_FREQUENCY=500)(
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic Enable);

    logic [31:0] start_value;  //define the start value that counts down to zero

    always_comb
        case (Speed)
            2'b00: start_value = 32'd0;
            2'b01: start_value = CLOCK_FREQUENCY - 32'd1;      
            2'b10: start_value = (CLOCK_FREQUENCY * 2) - 32'd1; 
            2'b11: start_value = (CLOCK_FREQUENCY * 4) - 32'd1;
        endcase

    logic [31:0] counter;
    always_ff@(posedge ClockIn)
        if (Reset)
            counter <= start_value;
        else if (counter == 32'd0)
            counter <= start_value;
        else
            counter <= counter - 32'd1;
    
    assign Enable = (counter == 32'd0);

endmodule



module DisplayCounter (
    input logic Clock,
    input logic Reset,
    input logic EnableDC,
    output logic [3:0] CounterValue);

    always_ff@(posedge Clock)
        if (Reset)
            CounterValue <= 4'b0;
        else if (EnableDC)
            if (CounterValue == 4'b1111)
                CounterValue <= 4'b0;
            else 
                CounterValue <= CounterValue + 4'b0001;

endmodule
    

