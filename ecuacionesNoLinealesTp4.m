# HECHO POR TOMAS VIDAL
# METODO PARA HALLAR RAICES DE ECUACIONES NO LINEALES
# METODO PUNTO FIJO
clc; clear all; format long;

f = @(x) exp(-x);
g = @(x) exp(x);
j = @(x) cos(x);

h = @(x) ( (x^3)/3 + (3/4)/(3.1314) )^(1/2);
h2 = @(x) ( 3*( x^2 - (3/4)/(3.1415) ) )^(1/3);

# SI LA FUNCION DEVULVE ERROR = 1 ES QUE OCURRIO UN ERROR, SI ES CERO TODO ESTA BIEN
function [r, error] = roots(f, starting_point, max_iterations)
  k = 1;
  error = 0;
  r(k) = starting_point;
  do
    prev_root = r(k);
    new_root = f(r(k));
    if (length(r) > 3)
      derivate = ( r(2) - f(r(k)) ) / ( r(1) - r(k) );
      if ( abs(derivate) <= 1) # LA DERIVADA DECRECE, POR LO QUE f CONVERGE
        r(k+1) = new_root;    
      else
        error = 1;
        disp("ERROR 1");
        disp("La funcion diverge!!!");
        break;
      endif;
    else
      r(k+1) = new_root;    
    endif;
    
    k = k + 1;
  until (k == max_iterations)
endfunction;


MAX_ITERATIONS = input("Hasta cuantas iteraciones? ");

[r, error] = roots(h, 1.5, MAX_ITERATIONS);
plot(r); hold on; 

if (error != 1)
  disp(cstrcat("La raiz aproximada es "));
  disp(r(length(r)));
endif;

hold off;