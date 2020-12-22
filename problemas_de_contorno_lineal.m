% HECHO POR TOMAS VIDAL
% METODO DE DIFERENCIAS FINITAS PARA RESOLVER UNA ECUACION DIFERENCIAL CON CONDICIONES DE CONTORNO
% LA ECUACION DEBE ESTAR DE FORMA IMPLICITA

function [aprox_points, error_code] = problemas_de_contorno_lineal(coeficients, initial_conditions, interval, looping_step)
    % coeficients son los n coeficients de las variables ej: y'' = a1 y' + a2 y + f(x), SE ESPERA QUE SEA UNA LISTA EJ: coeficients = {f(x), a0, a1, ... , an}
    % initial_conditions es el vector que contiene las condiciones iniciales, SE CONSIDERA QUE SEA UN VECTOR DE DOS FILAS Y N COLUMNAS PARA N CONDICIONES INCIALES, DONDE LA PRIMERA FILA CORRESPONDE A LOS VALORES DE LA VARIABLE DEPENDIENTE CON VARIABLE INDEPENDIENTE IGUAL AL VALOR DEL COMIENZO DEL INTERVALO, Y LA SEGUNDA FILA A LOS DE LA VARIABLE INDEPENDIENTE DEL VALOR DEL FINAL DEL INTERVALO, ES DECIR: [c1(a), c2(a); c3(b), c4(b)]
    % interval es el intervalo considerado, SE ESPERA QUE SEA DE LA FORMA [a,b]
    % looping_step es el paso de iteracion que se quiere usar 

    aprox_points = NaN;
    error_code = 0;

    % max_order es el orden de la ecuacion diferencial
    max_order = length(coeficients)-1;
    switch (max_order)
        % para cuando el orden de la ecuacion diferencial es 2
        case 2
            % defino el vector X que contiene los n valores de la variable independiente
            X = [interval(1):looping_step:interval(2)];
            % defino p que es coeficiente de Y' 
            p = coeficients{3}
            % defino q que es coeficiente de Y
            q = coeficients{2}
            % defino r que es coeficiente de Y
            r = coeficients{1}
            % defino la matriz para calcular las aproximaciones
            matrix = zeros(length(X), length(X));
            matrix(1,1) = 1;
            matrix(length(X), length(X)) = 1;
            % defino el vector que contiene las condiciones iniciales y los r(Xn)
            result_vector(1) = initial_conditions(1,1);
            result_vector(length(X)) = initial_conditions(2,1);
            result_vector(2:(length(X)-1)) = 0;
            result_vector(2:(length(X)-1)) = r(X(1:(length(X)-2)));
            % max_iterations es la maxima iteracion
            max_iterations = length(X)-1;
            for (n = 2:max_iterations)

                % defino los coeficientes para la matriz
                v1 = (1 + looping_step*(p(X(n-1))) - (looping_step^2)*q(X(n-1)))/(looping_step^2);
                v2 = (-1)*( (2+looping_step*p(X(n-1)))/(looping_step^2));
                v3 = 1/(looping_step^2);

                % le asigno los valores a la matriz
                matrix(n, n-1) = v1;
                matrix(n, n) = v2;
                matrix(n, n+1) = v3;

            end

            solved_matrix = (inv(matrix)*transpose(result_vector));
            aprox_points = [X; transpose(solved_matrix)];

        otherwise
            error_code = 1;
            disp('ERROR: el grado de la ecuacion diferencial no esta programado');
    end

end
