//`include "sum1bit.v"

module sum4b (
    input [3:0] A,    // Primer operando de 4 bits
    input [3:0] B,    // Segundo operando de 4 bits
    input Ci,         // Acarreo de entrada
    output [3:0] S,   // Suma de salida de 4 bits
    output Co         // Acarreo de salida
);

    // Declaración de señales internas para los acarreo
    wire C1;  // Acarreo entre el bit 0 y el bit 1
    wire C2;  // Acarreo entre el bit 1 y el bit 2
    wire C3;  // Acarreo entre el bit 2 y el bit 3

    // Instanciación de los módulos sum1b
    sum1b sum0 (.a(A[0]), .b(B[0]), .ci(Ci),  .s(S[0]), .co(C1));
    sum1b sum1 (.a(A[1]), .b(B[1]), .ci(C1), .s(S[1]), .co(C2));
    sum1b sum2 (.a(A[2]), .b(B[2]), .ci(C2), .s(S[2]), .co(C3));
    sum1b sum3 (.a(A[3]), .b(B[3]), .ci(C3), .s(S[3]), .co(Co));

endmodule
