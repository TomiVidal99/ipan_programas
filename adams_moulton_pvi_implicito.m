% HECHO POR TOMAS VIDAL
% METODO MULTIPASO DE ADAMS-MOULTON PARA REDUCIR EL ERROR DE APROXIMACION PARA ECUACIONES DIFERENCIALES ORDINARIAS DE ORDEN 1

function [better_aprox_points, acumulated_error, error_code] = adams_moulton_pvi_implicito(functions_x_y, known_points, tolerance, grade, real_function, max_iterations_of_algorithms, looping_step)
    % functions_x_y es la funcion que implicita de la ecuacion diferencial
    % known_points son los puntos que se quieren mejorar 
    % tolerance es la tolerancia que se quiere tener 
    % grade indica el paso del metodo por ejemplo grade=2 es paso 2
    % como para poder calcular el error debe usar la derivada de orden grade, derivate_grade es esa derivada se espera que se de la forma derivate_grade = @(x,y) x = y^(grade)
    % better_aprox_points son los puntos con mejor tolerancia
    % error_code es el codigo de error de la funcion, si no hay error debe ser cero

    error_code = 0;
    better_aprox_points = NaN;
    acumulated_error = 0;

    X = known_points(1,:);
    Y = known_points(2,:);

    % defino el paso
    %h = abs(X(2)-X(1));
    h = looping_step;

    % TODO: comprobar que se cumplan las condiciones necesarias para aplicar el algoritmo

    % comienzo a aplicar el algoritmo
    switch (grade)
        case 3
            N = length(known_points);
            local_error = 2*tolerance;
            current_iterations = 1;
            max_iterations = 1000;
            %while (local_error > tolerance)
            for (n = 1:max_iterations_of_algorithms)
                acumulated_error = 0;
                total_error = 0;
                for (n = 2:(N-1))
                    Y(n+1) = Y(n) + (h/12)*(5*functions_x_y(X(n+1), Y(n+1)) + 8*functions_x_y(X(n), Y(n)) - functions_x_y(X(n-1), Y(n-1)));
                    total_error = total_error + (known_points(2, n+1) - Y(n+1));
                end
                if (current_iterations == max_iterations)
                    break;
                end
                local_error = total_error/(N-2);
                current_iterations = current_iterations + 1;
            end
            if (current_iterations == max_iterations)
                disp('ERROR: se alcanzo la maxima iteracion para el error!');
                disp('local_error: ');
                disp(local_error);
            end
        case 5
            N = length(known_points);
            local_error = 2*tolerance;
            current_iterations = 1;
            max_iterations = 1000;
            for (n = 1:max_iterations_of_algorithms)
                acumulated_error = 0;
                total_error = 0;
                for (n = 5:(N-1))
                    Y(n+1) = Y(n) + (h/720)*(1901*functions_x_y(X(n), Y(n)) - 2774*functions_x_y(X(n-1), Y(n-1)) + 2616*functions_x_y(X(n-2), Y(n-2)) - 1274*functions_x_y(X(n-3), Y(n-3)) + 251*functions_x_y(X(n-4), Y(n-4)) );
                    total_error = total_error + (known_points(2, n+1) - Y(n+1));
                end
                if (current_iterations == max_iterations)
                    break;
                end
                local_error = total_error/(N-2);
                current_iterations = current_iterations + 1;
            end

        otherwise
            error_code = 1;
            disp('ERROR: el paso elegido no existe');
    end

    better_aprox_points = [X;Y];
    last_val = length(X)-1;
    acumulated_error = abs(real_function(X(last_val)) - Y(last_val));

end
