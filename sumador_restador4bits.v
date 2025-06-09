//`include "sum1bit.v"
//`include "sum4bit.v"

module sum_rest4bits(
    input [3:0] A,    // Primer operando de 4 bits
    input [3:0] BB,    // Segundo operando de 4 bits
    input  SELECTOR,    //  Elijes si suma o resta 0 suma 1 resta
    output [3:0] S,   // Suma de salida de 4 bits
    output Co         // Acarreo de salida
);
    wire [3:0]B;  // Acarreo entre el bit 0 y el bit 1
    assign B = BB ^ {4{SELECTOR}};  // Repite sel 4 veces para hacer XOR bit a bit

        sum4b mi_sumador (
        .A(A),
        .B(B),
        .Ci(SELECTOR),
        .S(S),
        .Co(Co)
    );

endmodule



