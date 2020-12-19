% HECHO POR TOMAS VIDAL
% METODO DE UN PASO DE EULER PARA RESOLVER NUMERICAMENTE PROBLEMAS DE VALOR INICIAL
% SE USA SOLO PARA ECUACIONES DIFERENCIALES ORDINARIAS DE ORDEN 1 EXPLICITAS

function [aproximated_points, acumulated_error, error_code] = euler_pvi(function_x_y, initial_condition, interval_a, interval_b, looping_step, real_function)
    % function_x_y es la funcion f(x,y) a la que es igual y'
    % looping_step es el paso con el que se va a ir iterando y que determinara el error al finalizar
    % interval es el intervalo [a;b] en el que se sabe/quiere resolver la ecuacion
    % initial_condition es la condicion inicial al problema se considera que es para x=0, que necesariamente tiene que ser Y(a)
    % si se quiere conocer el error local se debe ingresar la funcion real, en caso de no querer ingresar nada solo reemplazar el argumento con cero
    % aproximated_points devuelve los puntos aproximados por el algoritmo y ademas para cada x un valor que es el error local

    % defino los valores que devuelve la funcion
    error_code = 0;
    acumulated_error = NaN;
    aproximated_points = NaN;

    % compruebo que los parametros requeridos tengas las condiciones necesarias
    if (looping_step > 0 && (interval_b > interval_a) && (interval_b-interval_a) > looping_step)
        % caso para cuando las condiones son correctas para resolver la ecuacion

        % las maximas iteraciones estan dadas por el paso y la longitud del intervalo dado
        max_iterations = round( (interval_b - interval_a) / looping_step);

        % X e Y son los vectores que contiene Xn y los Yn 
        X(1:max_iterations-1) = 0;
        Y(1) = initial_condition;
        Y(2:max_iterations-1) = 0;

        local_error(1:max_iterations) = 0;

        % comienzo a calcular los valores de X e Y
        for (n = 1:max_iterations)
            X(n) =(interval_a+n*looping_step);
            if (n != max_iterations)
                Y(n+1) = Y(n) + looping_step*function_x_y(X(n), Y(n));
                if (exist('real_function') == 1 && n < max_iterations && n > 1)
                    real_value = real_function(X(n), Y(n));
                    local_error(n) = Y(n) - real_value;
                end
            end
        end

        % calculo el error acumulador para el n-esimo valor
        acumulated_error = Y(length(Y)-1) - Y(length(Y));

        if (exist('real_function') == 1)
            aproximated_points = [X;Y; local_error];
        end

    else 
        error_code = 1;
        disp('ERROR: uno de los parametros dados no es correcto');
    end
end
