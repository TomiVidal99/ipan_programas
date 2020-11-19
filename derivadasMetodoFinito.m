clc; clear all; format long;

f = @(x) cosh(x);
g = @(x) cos(pi*x);
j = @(x) 3*(x^3) - 1;

function [aprox_derivate] = diferencias_finitas_orden_dos(f, center, step)
  prev_step = center-step;
  next_step = center+step;
  
  aprox_derivate = (f(next_step)-f(prev_step)) / (2*step);
endfunction

function [aprox_derivate] = diferencias_finitas_orden_cuatro(f, center, step)
  prev_step = center-step;
  prev_prev_step = center-2*step;
  next_step = center+step;
  next_next_step = center+2*step;
  
  aprox_derivate = (-f(next_next_step)+8*f(next_step)-8*f(prev_step)+f(prev_prev_step)) / (12*step);
endfunction

disp("Aproximacion de orden 2: ");
aprox = diferencias_finitas_orden_dos(j, 0.5, 0.1);
disp(aprox);
#disp("Aproximacion de orden 4: ");
#aprox_cuatro = diferencias_finitas_orden_cuatro(f, 1, 0.1);
#disp(aprox_cuatro);

valor_real = input("Valor real? ");

error_absoluto_segundo_orden = valor_real-aprox;
disp(error_absoluto_segundo_orden);
#error_absoluto_cuarto_orden = valor_real-aprox_cuatro;
#disp(error_absoluto_cuarto_orden);

