//`include "sum1bit.v"
//`include "sum4bit.v"

module sum_rest4bits(
    input [3:0] A,         // Primer operando de 4 bits
    input [3:0] BB,        // Segundo operando de 4 bits
    input SELECTOR,        // 0 = suma, 1 = resta
    output [3:0] S,        // Salida negada (por lógica CODIFA)
    output Co              // Acarreo de salida negado
);

    wire [3:0] B;                  // Segundo operando después del XOR
    wire [3:0] S_internal;         // Suma/resta sin negar aún
    wire Co_internal;             // Acarreo sin negar aún

    // Realiza el complemento si es resta
    assign B = BB ^ {4{SELECTOR}};

    // Instanciación del sumador de 4 bits (versión sin lógica negada en la salida)
    sum4b mi_sumador (
        .A(A),
        .B(B),
        .Ci(SELECTOR),     // Ci = 1 para resta (complemento a 2)
        .S(S_internal),
        .Co(Co_internal)
    );

    // Negación para lógica CODIFA
    assign S = ~S_internal;
    assign Co = ~Co_internal;

endmodule


module sum_rest4bits(
    input [3:0] A,      // Entradas negadas físicamente
    input [3:0] BB,     // Segundo operando negado físicamente
    input SELECTOR,     // Selector negado físicamente (0 suma, 1 resta)
    output [3:0] S,
    output Co
);

    // Negar las señales de entrada si vienen en lógica activa baja
    wire [3:0] A_n = ~A;
    wire [3:0] BB_n = ~BB;
    wire SELECTOR_n = ~SELECTOR;

    // Operación XOR para hacer complemento a 2 si SELECTOR = 1
    wire [3:0] B;
    assign B = BB_n ^ {4{SELECTOR_n}};  // Esto hace B = BB_n si suma, ~BB_n si resta

    // Llamamos al sumador con señales ya en lógica normal
    sum4b mi_sumador (
        .A(A_n),
        .B(B),
        .Ci(SELECTOR_n),  // Ci = 1 si resta
        .S(S),
        .Co(Co)
    );

endmodule



