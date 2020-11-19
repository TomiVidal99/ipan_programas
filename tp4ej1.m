clc; clear all; format long;
# HECHO POR TOMAS VIDAL
# PROGRAMA QUE APROXIMA RAICES CON CIERTO ERROR DEFINIDO CON EL METODO DE BISECCION

# FUNCION ANONIMA QUE VOY A EVALUAR
f = @(x) x*exp(-x) + x**(2) - 1;

function [r, k] = biseccion(f, a, b, max_error, max_iterations)
    # f ES LA FUNCION A LA QUE LE VOY A APROXIMAR LA RAIZ
    # a Y b SON LOS EXTREMOS DEL INTERVALO EN QUE SE CREE QUE ESTA LA RAIZ
    # max_error ES LA TOLERANCIA QUE SE QUIERE, EL PROGRAMA NO VA DEJAR DE ITERAR HASTA QUE 
    # CONSIGA UNA TOLERANCIA IGUAL O MENOR A LA DADA, O QUE EL NUMERO DE ITERACIONES SEA MUY GRANDE,
    # (PARA EVITAR UN LOOP MUY GRANDE)
    lim_inf = a;
    lim_sup = b;
    k = 1;
    do
        r(k) = (lim_inf+lim_sup)/2;
        if (f(r(k))*f(lim_inf) > 0) # VERIFICO SI LA RAIZ SE ENCUENTRA ENTRE EL LIMITE INFERIOR Y LA NUEVA RAIZ
            # DE SER ASI LE ASIGNO AL LIMITE INFERIOR LA NUEVA RAIZ
            lim_inf = r(k);
        elseif (f(r(k))*f(lim_sup) > 0) # VERIFICO SI LA RAIZ SE ENCUTRA ENTRE EL LIMITE SUPERIOR Y LA NUEVA RAIZ 
            # DE SER ASI LE ASIGNO AL LIMITE SUPERIOR LA NUEVA RAIZ
            lim_sup = r(k);
        else
            # NO EXISTEN RAICES EN EL INTERVALO DADO
            disp("ERROR 1, NO EXISTEN RAICES EN EL INTERVALO DADO");
        endif;
        k = k + 1;
        error = abs(((lim_sup-lim_inf)/2));
    until (k == max_iterations || error <= max_error)
endfunction;

function [r, k] = false_position(f, a, b, max_error, max_iterations)
    # f ES LA FUNCION A LA QUE LE VOY A APROXIMAR LA RAIZ
    # a Y b SON LOS EXTREMOS DEL INTERVALO EN QUE SE CREE QUE ESTA LA RAIZ
    # max_error ES LA TOLERANCIA QUE SE QUIERE, EL PROGRAMA NO VA DEJAR DE ITERAR HASTA QUE 
    # CONSIGA UNA TOLERANCIA IGUAL O MENOR A LA DADA, O QUE EL NUMERO DE ITERACIONES SEA MUY GRANDE,
    # (PARA EVITAR UN LOOP MUY GRANDE)
    lim_inf = a;
    lim_sup = b;
    k = 1;
    do
        r(k) = lim_sup - ((f(lim_sup)*(lim_inf-lim_sup)) / ( f(lim_inf) - f(lim_sup) ));
        if (f(r(k))*f(lim_inf) > 0)
            lim_inf = r(k);
        elseif (f(r(k))*f(lim_inf) > 0)
            lim_sup = r(k);
        else
            # NO EXISTEN RAICES EN EL INTERVALO DADO
            disp("ERROR 1, NO EXISTEN RAICES EN EL INTERVALO DADO");
        endif;
        k = k + 1;
        error = abs(((lim_sup-lim_inf)/2));
    until (k == max_iterations || error <= max_error) # HAGO EL LOOP HASTA QUE SE ALCANCE LA TOLERANCIA DESEADA O QUE LLEGUE AL MAXIMO DE ITERACIONES
endfunction;

LOWER_LIM = 0;
UPPER_LIM = 1;
MAX_ITERATIONS = 5000;
TOLERANCE = input("Tolerancia: ");

method_type = 0;
do 
  method_type = input("Biseccion o falsa posicion? [1 o 2]");
until (method_type == 1 || method_type == 2);

if (method_type == 1) # APLICAR EL METODO DE BISECCION
  [roots, iterations] = biseccion(f, LOWER_LIM, UPPER_LIM, TOLERANCE, MAX_ITERATIONS);
elseif (method_type == 2) # APLICAR EL METODO DE FALSA POSICION
  [roots, iterations] = false_position(f, LOWER_LIM, UPPER_LIM, TOLERANCE, MAX_ITERATIONS);
endif;

clc;
disp(cstrcat("La raiz en el intervalo es aproximadamente ", num2str(roots(iterations-1)), ", con un error menor igual a ", num2str(TOLERANCE), ", y se necesitaron ", num2str(iterations), " iteraciones para llegar a esta tolerancia."));
plot(roots);
