# ECUACIONES NO LINEALES
# HECHO POR TOMAS VIDAL
clc; clear all; format long;

# DEFINO LAS FUNCIONES
f1 = @(x1, x2) x1^2 + x1*x2 - 10;
f2 = @(x1, x2) x2 + 3*x1*(x2^2) - 5;

# DEFINO LOS VALORES INICIALES DE LAS VARIABLES
x1_0 = 1.5;
x2_0 = 2.5;

# DEFINO LAS FUNCIONES G
g1 = @(x1, x2) (10 - x1*x2)^(1/2);
g2 = @(x1, x2) ( (5 - x2) / (3*x1) )^(1/2);

function [r1, r2] = sistema_de_ecuaciones(g1, g2, x1_0, x2_0, max_iterations)
  k = 1;
  r1(k) = x1_0;
  r2(k) = x2_0;
  do
    r1(k+1) = g1(r1(k), r2(k));
    r2(k+1) = g2(r1(k), r2(k));
    k = k + 1;
  until (k == max_iterations);
endfunction;


[r1, r2] = sistema_de_ecuaciones(g1, g2, x1_0, x2_0, 5);
##disp(cstrcat("Las aproximaciones son ", num2str(r1(length(r1))), " y ", num2str(r2(length(r2))));
disp(r1(length(r1)));
disp(r2(length(r2)));
plot(r1); hold on;
plot(r2); hold on;
