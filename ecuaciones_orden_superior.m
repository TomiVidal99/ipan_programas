% HECHO POR TOMAS VIDAL
% METODO PARA RESOLVER UNA ECUACION DIFERENCIAL IMPLICITA DE ORDEN K A PARTIR DE PLANTEAR UN CAMBIO DE VARIABLE Y PRESENTAR LA ECUACION COMO UN SISTEMA DE ECUACIONES DE ORDEN MENOR

function [aprox_points, error_code] = ecuaciones_orden_superior(diff_function, initial_conditions, max_order, interval, looping_step, method)
    % diff_function es la ecuacion diferencial implicita con el mayor orden despejado como la funcion, SE ESPERA QUE SE ENTREGUE DE LA FORMA diff_function = @(x,y,z,w,etc..)
    % initial_conditions es el vector que contiene las condiciones iniciales, SE CONSIDERA QUE LA VARIABLE INDEPENDIENTE UTILIZADA ES EL MISMO VALOR QUE EL DEL INCIO DEL INTERVALO, SE ESPERA QUE SEA UN VECTOR
    % max_order es el orden maximo de la ecuacion diferencial
    % interval es el intervalo considerado, SE ESPERA QUE SEA DE LA FORMA [a,b]
    % looping_step es el paso de iteracion que se quiere usar 
    % method es el metodo a usar, es decir euler runge-kutta etc SOLAMENTE ESTAN PROGRAMADOS EULER Y KUTTA4 (RUNGE-KUTTA 4)

    error_code = 0;
    aprox_points = NaN;

    switch (max_order)
        case 2
            % para el caso en el que la ecuacion diferencial tiene orden 2
            % llamo X al vector que contiene los valores de Y'
            X(1) = initial_conditions(1);
            % llamo U al vector que contiene los valores de Y'' (que son los que me terminan resolviendo la ecuacion diferencial)
            U(1) = initial_conditions(2);
            % el vector x contiene los n valores de la variabel independiente
            x = [interval(1):looping_step:interval(2)];

            max_iterations = length(x)-1;
            for (n = 1:max_iterations)

                switch (method)
                    case 'euler'
                        % por euler
                        X(n+1) = X(n) + looping_step*(U(n));
                        U(n+1) = U(n) + looping_step*diff_function(x(n), X(n), U(n));
                    case 'kutta4'
                        % por runge kutta
                        k11 = looping_step*U(n);
                        k12 = looping_step*diff_function(x(n), X(n), U(n));
                        k21 = looping_step*(U(n)+k12/2);
                        k22 = looping_step*diff_function(x(n)+looping_step/2, X(n)+k11/2, U(n)+k12/2);
                        k31 = looping_step*(U(n)+k22/2);
                        k32 = looping_step*diff_function(x(n)+looping_step/2, X(n)+k21/2, U(n)+k22/2);
                        k41 = looping_step*(U(n)+k32);
                        k42 = looping_step*diff_function(x(n)+looping_step, X(n)+k31, U(n)+k32);

                        X(n+1) = X(n) + (k11 + 2*k21 + 2*k31 + k41)/6;
                        U(n+1) = U(n) + (k12 + 2*k22 + 2*k32 + k42)/6;
                    otherwise
                        error_code = 2;
                        disp('ERROR: el metodo no existe o no esta programado');
                end
            end
            
        otherwise
            error_code = 1;
            disp('ERROR: actualmente no esta programado para poder resolver este grado');
    end

    aprox_points = [x; X; U];

end
