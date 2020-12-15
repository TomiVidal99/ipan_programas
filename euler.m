% HECHO POR TOMAS VIDAL
% METODO DE UN PASO DE EULER PARA RESOLVER NUMERICAMENTE PROBLEMAS DE VALOR INICIAL
% SE USA SOLO PARA ECUACIONES DIFERENCIALES ORDINARIAS DE ORDEN 1 EXPLICITAS

function [function_aproximated, acumulated_error, error_code] = euler_pvi(function_x_y, initial_condition, interval_a, interval_b, looping_step)
    % function_x_y es la funcion f(x,y) a la que es igual y'
    % looping_step es el paso con el que se va a ir iterando y que determinara el error al finalizar
    % interval es el intervalo [a;b] en el que se sabe/quiere resolver la ecuacion
    % initial_condition es la condicion inicial al problema, que necesariamente tiene que ser Y(a)
    % data se espera que sea de la forma: 

    % defino los valores que devuelve la funcion
    error_code = 0;
    acumulated_error = NaN;
    function_aproximated = @(x) NaN;

    % compruebo que los parametros requeridos tengas las condiciones necesarias
    if (looping_step == 0) % looping_step no tiene las condiones necesarias
        error_code = 1;
        disp("ERROR: el paso de iteracion no es correcto");
    else
        % caso para cuando las condiones son correctas para resolver la ecuacion

        % las maximas iteraciones estan dadas por el paso y la longitud del intervalo dado
        max_iterations = round( (interval_b - interval_a) / looping_step);

        % X e Y son los vectores que contiene Xn y los Yn 
        X(1:max_iterations-1) = 0;
        Y(1) = initial_condition;
        Y(2:max_iterations-1) = 0;

        % comienzo a calcular los valores de X e Y
        for (n = 1:max_iterations)
            X(n) = (interval_a+n*looping_step);
        end
        for (n = 1:max_iterations)
            if (n != max_iterations)
                h = X(n+1) - X(n);
                Y(n+1) = Y(n) + h*function_x_y(X(n), Y(n));
            end
        end

        % calculo el error acumulador para el n-esimo valor
        acumulated_error = Y(length(Y)-1) - Y(length(Y));

    end
end
