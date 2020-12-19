
% HECHO POR TOMAS VIDAL
% METODO DE RUNGE KUTTA PARA RESOLVER PROBLEMAS DE VALOR INICIAL de ecuaciones diferenciales de primer orden ordinarias

function [aproximated_points, acumulated_error, error_code] = runge_kutta_pvi(function_x_y, polinome_grade, initial_condition, interval, looping_step, real_function)
    % aproximated_points son los puntos que aproximan a la funcion que resulve la ecuacion diferencial 
    % acumulated_error es el error acumulado debido a que se usan aproximaciones 
    % error_code es el codigo de error que si es cero es que el programa se ha ejecutado correctamente
    % function_x_y es la funcion implicita f(x,y) = y' 
    % initial_condition es el punto de condicion inicial que se espera que sea de la forma: [x,y]
    % polinome_grade es el grado del polinomio de runge kutta que se quiere utilizar: SOLO PUEDE SER 4 POR EL MOMENTO
    % interval es el intervalo de la forma [a,b]
    % looping_step es el paso con el que se quiere hacer la aproximacion
    % real_function es la funcion analitica real, que si se proporciona se puede saber el error local y absoluto

    % defino los valores que devuelve la funcion
    interval_a = interval(1);
    interval_b = interval(2);

    error_code = 0;
    acumulated_error = NaN;
    aproximated_points = NaN;

    % defino las maximas iteraciones que se dan debido a la longitud del intervalo y el paso elegido
    max_iterations = (interval_b-interval_a)/looping_step+1;

    % genero el vector que contiene los valores de la variable independiente
    X = [interval_a:looping_step:interval_b];
    % genero el vector que contiene los valores de la variable dependiente
    Y(1:max_iterations) = 0;

    % TODO: comprobar mas condiciones de los parametros
    % verifico que se den las condiciones necesarias para aplicar el algoritmo
    if (polinome_grade > 1 && interval_b > interval_a && (interval_b-interval_a) > looping_step)

        % defino el valor para el cual el n es el de la condicion inicial
        % y asigno el valor de yi(xi) a Y (condicion inicial)
        n_position = 0;
        k = 1;
        for (n = X)
            if (n == initial_condition(1))
                n_position = k;
                Y(k) = initial_condition(2);
            end
            k = k + 1;
        end

        % eligo el algoritmo correcto dependiendo del grado ingresado
        switch (polinome_grade)
            % caso para grado 4
            case 4
                if (n_position != 1)
                    for (n = n_position:-1:2)
                        k1 = looping_step*function_x_y(X(n), Y(n));
                        k2 = looping_step*function_x_y(X(n)+looping_step/2, Y(n) + k1/2);
                        k3 = looping_step*function_x_y(Y(n)+looping_step/2, Y(n) + k2/2);
                        k4 = looping_step*function_x_y(X(n+1), Y(n) + k3);
                        Y(n-1) = Y(n) - (k1 + 2*k2 + 2*k3 + k4)/6;
                    end
                end
                if (n_position != max_iterations)
                    for (n = n_position:(max_iterations-1))
                        k1 = looping_step*function_x_y(X(n), Y(n));
                        k2 = looping_step*function_x_y(X(n)+looping_step/2, Y(n) + k1/2);
                        k3 = looping_step*function_x_y(Y(n)+looping_step/2, Y(n) + k2/2);
                        k4 = looping_step*function_x_y(X(n+1), Y(n) + k3);
                        Y(n+1) = Y(n) + (k1 + 2*k2 + 2*k3 + k4)/6;
                    end
                end
            % caso para cuando el grado ingresado no existe: es decir es un error
            otherwise
                error_code = 2;
                disp('ERROR: el grado de runge kutta no esta programado todavia');
        end
    else
        error_code = 1;
        disp('ERROR: uno de los parametros utilizados no es valido.');
    end

    aproximated_points = [X; Y];
    acumulated_error = abs(Y(length(X)) - real_function(length(X)));

end
