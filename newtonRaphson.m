# HECHO POR TOMAS VIDAL
# METODO PARA ENCONTRAR RAICES DE NEWTON-RAPHSON
clc; clear all; format long;

f = @(x) exp(-x) - x;
first_derivate = @(x) -exp(-x) - 1;

function [r] = newton_raphson(f, first_derivate, initial_value, max_iterations)
  k = 1;
  r(k) = initial_value;
  do
    r(k+1) = r(k) - f(r(k)) / first_derivate(r(k));
    k = k + 1;
  until (k == max_iterations);
endfunction;

##function [r] = secante(f, initial_value, max_iterations);
##  k = 1;
##  r(k) = initial_value;
##  do  
##    r(k+1) = r(k) - ( f(r(k-1))*() );
##    k = k + 1;
##  until
##endfunction;

r = newton_raphson(f, first_derivate, -10, 1000);
disp(cstrcat("La raiz aproximada es ", num2str(r(length(r)))));