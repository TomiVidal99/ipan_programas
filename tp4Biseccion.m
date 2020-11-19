# HECHO POR TOMAS VIDAL
# CALCULA LA RAIZ DEL POLINOMIO f CON EL METODO DE BISECCION
clc; clear all;

f=@(x) x*exp(-x)+x^2-1;

[raices, iteraciones] = biseccion(f, 0, 1, 0.00000005);

disp(raices);
disp(iteraciones);