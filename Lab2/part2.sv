//m = sbar x + s y
module mux2to1 (input logic x,y,s, output logic m);
    logic first_and;
    logic second_and;
    logic s_complement;
    v7404 u0 (
        .pin1(s),
        .pin2(s_complement),
		.pin3(),
		.pin4(),
		.pin5(),
		.pin6(),
		.pin8(),
		.pin9(),
		.pin10(),
		.pin11(),
		.pin12(),
		.pin13()
    );
    v7408 u1 (
        .pin1(s_complement),
        .pin2(x),
        .pin3(first_and),
        .pin4(s),
        .pin5(y),
        .pin6(second_and),
		.pin8(),
		.pin9(),
		.pin10(),
		.pin11(),
		.pin12(),
		.pin13()
    );
    v7432 u2 (
        .pin1(first_and),
        .pin2(second_and),
        .pin3(m),
		.pin4(),
		.pin5(),
		.pin6(),
		.pin8(),
		.pin9(),
		.pin10(),
		.pin11(),
		.pin12(),
		.pin13()
    );
endmodule


// inverter
module v7404 (input logic pin1, pin3, pin5, pin9, pin11, pin13, output logic
pin2, pin4, pin6, pin8, pin10, pin12);
    assign pin2 = ~pin1;
    assign pin4 = ~pin3;
    assign pin6 = ~pin5;
    assign pin8 = ~pin9;
    assign pin10 = ~pin11;
    assign pin12 = ~pin13;
endmodule

// and
module v7408 (input logic pin1, output logic pin3, input logic pin5, input
logic pin9, output logic pin11, input logic pin13, input logic pin2, input
logic pin4, output logic pin6, output logic pin8, input logic pin10, input
logic pin12);
    assign pin3 = pin1 & pin2;
    assign pin6 = pin4 & pin5;
    assign pin8 = pin9 & pin10;
    assign pin11 = pin13 & pin12;
endmodule

// or
module v7432 (input logic pin1, output logic pin3, input logic pin5, input
logic pin9, output logic pin11, input logic pin13, input logic pin2, input
logic pin4, output logic pin6, output logic pin8, input logic pin10, input
logic pin12);
    assign pin3 = pin1 | pin2;
    assign pin6 = pin4 | pin5;
    assign pin8 = pin9 | pin10;
    assign pin11 = pin12 | pin13;
endmodule