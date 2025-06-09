`include "sum1bit.v"

module sum4b (
    input [3:0] A,    // Primer operando de 4 bits
    input [3:0] B,    // Segundo operando de 4 bits
    input Ci,         // Acarreo de entrada
    output [3:0] S,   // Suma de salida de 4 bits (negada)
    output Co         // Acarreo de salida (negado)
);

    // Declaración de señales internas para los acarreo
    wire C1;  // Acarreo entre el bit 0 y el bit 1
    wire C2;  // Acarreo entre el bit 1 y el bit 2
    wire C3;  // Acarreo entre el bit 2 y el bit 3

    // Señales internas de suma y acarreo antes de negar
    wire [3:0] S_internal;
    wire Co_internal;

    // Instanciación de los módulos sum1b
    sum1b sum0 (.a(A[0]), .b(B[0]), .ci(Ci),  .s(S_internal[0]), .co(C1));
    sum1b sum1 (.a(A[1]), .b(B[1]), .ci(C1),  .s(S_internal[1]), .co(C2));
    sum1b sum2 (.a(A[2]), .b(B[2]), .ci(C2),  .s(S_internal[2]), .co(C3));
    sum1b sum3 (.a(A[3]), .b(B[3]), .ci(C3),  .s(S_internal[3]), .co(Co_internal));

    // Negación de salidas por lógica CODIFA
    assign S  = ~S_internal;
    assign Co = ~Co_internal;

endmodule


module sum4b (
    input [3:0] A,
    input [3:0] B,
    input Ci,
    output [3:0] S,
    output Co
);

    wire C1, C2, C3;

    // Negación de entradas si vienen en lógica negada
    wire [3:0] A_n = ~A;
    wire [3:0] B_n = ~B;
    wire Ci_n = ~Ci;

    // Instancia de sumadores 1-bit con entradas negadas
    sum1b sum0 (.a(A_n[0]), .b(B_n[0]), .ci(Ci_n), .s(S[0]), .co(C1));
    sum1b sum1 (.a(A_n[1]), .b(B_n[1]), .ci(C1),   .s(S[1]), .co(C2));
    sum1b sum2 (.a(A_n[2]), .b(B_n[2]), .ci(C2),   .s(S[2]), .co(C3));
    sum1b sum3 (.a(A_n[3]), .b(B_n[3]), .ci(C3),   .s(S[3]), .co(Co));

endmodule
