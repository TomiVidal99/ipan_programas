% HECHO POR TOMAS VIDAL
% METODO DE ADAMS BASHFORTH PARA RESOLVER PROBLEMAS DE VALOR INICIAL de ecuaciones diferenciales de primer orden ordinarias
% IMPORTANTE ESTE METODO SOLO LO VOY A CONSIDERAR PARA PREDECIR PUNTOS, NO MEJORARLOS, POR LO QUE SE ESPERA QUE SE DEN SOLO DOS PUNTOS "CONOCIDOS"

function [aproximated_points, acumulated_error, error_code] = adams_bashforth_pvi(function_x_y, known_points, grade, interval, looping_step, real_function)
    % function_x_y es la funcion implicita a la que se le quiere conocer la solucion
    % known_points son los puntos que son conocidos (calculados con metodos de un paso por ejemplo) con dos como minimo, los puntos ingresados se toman como condiciones iniciales POR LO QUE DEBEN ESTAR DENTRO DEL INTERVALO DADO, ADEMAS DEBEN SER CONTIGUOS
    % grade es el grado ( de dos pasos o tres pasos ) 
    % interval es el intervalo considerado
    % looping_step es el paso con el que se va a realizar la iteracion
    % real_function es la funcion analitica que resuelve la solucion, si se conoce se puede conocer los errores exactos

    error_code = 0;
    acumulated_error = NaN;
    aproximated_points = NaN;

    % TODO: comprobar que se cumplan las condiciones necesarias para aplicar el metodo

    % creo la variable que contiene las maximas iteraciones que se deben realizar para llegar desde a hasta b con el paso looping_step
    max_iterations = ((abs(interval(2)-interval(1)))/(looping_step)+1);
    % creo el vector con los valores de la variable independiente
    X = [interval(1):looping_step:interval(2)];
    % creo el vector con los valores de la variable dependiente
    Y(1,max_iterations) = 0;

    % busco la posicion que corresponde al primer posicion de una de las condiciones iniciales
    n_iteration = 0;
    k = 1;
    for (n = X)
        if (known_points(1,1) == n)
            n_iteration = k;            
            break;
        end
        k = k + 1;
    end
    if (k == max_iterations)
        % no se encontro el n_iteration
        error_code = 3;
        disp('ERROR: el paso elegido debe ser menor para poder usar las condiciones iniciales dadas');
    else

        % reemplazo los valores de Y con los que ya conozco
        for (n = 0:(grade-1))
            Y(n_iteration+n) = known_points(2, 1+n);
        end

        % aplico el algoritmo
        switch (grade)
            case 2
                % para el caso de dos pasos
                if (length(known_points) == 2)
                    for (n = n_iteration:(max_iterations-2))
                        Y(n+2) = Y(n+1) + (looping_step/2)*(3*function_x_y(X(n+1), Y(n+1))-function_x_y(X(n), Y(n)));
                    end
                else
                    error_code = 4;
                    disp('ERROR: se requieren 2 puntos conocidos para poder calcular con grado 2');
                end
            case 3
                % para el caso de tres pasos
                if (length(known_points) == 3)
                    for (n = (n_iteration+2):(max_iterations-2))
                        Y(n+1) = Y(n) + (looping_step/12)*(23*function_x_y(X(n),Y(n)) - 16*function_x_y(X(n-1), Y(n-1)) + 5*function_x_y(X(n-2), Y(n-2)));
                    end
                else
                    error_code = 5;
                    disp('ERROR: se requieren 3 puntos conocidos para poder calcular con grado 3');
                end
            case 4
                % para el caso de cuatro pasos
                if (length(known_points) == 4)
                    for (n = (n_iteration+3):(max_iterations-3))
                        Y(n+1) = Y(n) + (looping_step/24)*(55*function_x_y(X(n), Y(n)) - 59*function_x_y(X(n-1), Y(n-1)) + 37*function_x_y(X(n-2), Y(n-2)) - 9*function_x_y(X(n-3), Y(n-3)));
                    end
                else
                    error_code = 6;
                    disp('ERROR: se requieren 4 puntos conocidos para poder calcular con grado 4');
                end
            case 5
                % para el caso de cinco pasos
                if (length(known_points) == 5)
                    for (n = (n_iteration+4):(max_iterations-4))
                        Y(n+1) = Y(n) + (looping_step/720)*(1901*function_x_y(X(n), Y(n)) - 2774*function_x_y(X(n-1), Y(n-1)) + 2616*function_x_y(X(n-2), Y(n-2)) - 1274*function_x_y(X(n-3), Y(n-3)) + 251*function_x_y(X(n-4), Y(n-4)));
                    end
                else
                    error_code = 7;
                    disp('ERROR: se requieren 5 puntos conocidos para poder calcular con grado 5');
                end
            otherwise
                % para cualquier otro caso es un error
                error_code = 1;
                disp("ERROR: el grado elegido no es correcto");
        end

        aproximated_points = [X;Y];

    end
end
