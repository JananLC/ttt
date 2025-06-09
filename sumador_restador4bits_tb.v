`include "sum1bit.v"
`include "sum4bit.v"
`include "sumador_restador4bits.v"


`timescale 1ns / 1ps

module tb_sum_rest4bits;

    // Entradas
    reg [3:0] A;
    reg [3:0] BB;
    reg SELECTOR;

    // Salidas
    wire [3:0] S;
    wire Co;

    // Instancia del módulo a probar
    sum_rest4bits dut (
        .A(A),
        .BB(BB),
        .SELECTOR(SELECTOR),
        .S(S),
        .Co(Co)
    );

    initial begin
        // Archivo VCD
        $dumpfile("sumador_restador4bits_tb.vcd"); // Nombre del archivo
        $dumpvars(0, tb_sum_rest4bits);    // Volcado de todas las señales del módulo

        $display("Tiempo | A    | BB   | SEL | Resultado | Co");
        $monitor("%4dns | %b | %b |  %b  |    %b     | %b", $time, A, BB, SELECTOR, S, Co);

        // Prueba 1: 3 + 2 = 5
        A = 4'b0011; BB = 4'b0010; SELECTOR = 0; #10;

        // Prueba 2: 7 - 2 = 5
        A = 4'b0111; BB = 4'b0010; SELECTOR = 1; #10;

        // Prueba 3: 5 + 5 = 10
        A = 4'b0101; BB = 4'b0101; SELECTOR = 0; #10;

        // Prueba 4: 4 - 6 = -2 => 1110
        A = 4'b0100; BB = 4'b0110; SELECTOR = 1; #10;

        // Prueba 5: 15 - 15 = 0
        A = 4'b1111; BB = 4'b1111; SELECTOR = 1; #10;

        // Prueba 6: 8 + 9 = 17 => 0001 con acarreo
        A = 4'b1000; BB = 4'b1001; SELECTOR = 0; #10;

        $finish;
    end

endmodule
