% HECHO POR TOMAS VIDAL
% METODO NUMERICO PARA RESOLVER ECUACIONES DIFERENCIALES PARCIALES LINEALES DEL TIPO ELIPTICAS
% CON CONDICIONES DE BORDES DE DIRCHLET 

function [aprox_points, error_code] = edp_elipticas(border_conditions, intervals, looping_step)
    % function_x_y es la funcion diferencial de dos variables independientes 
    % border_conditions son las condiciones de borde de dirichlet {a, @(y) u(a,y); b, @(y) u(b, y); c, @(x) u(x, c); d, @(x) u(x, d)}
    % intervals son los intervalos considerados se espera de la forma [a,b; c,d]
    % looping_steps son los pasos que se quieren tomar para iterar, se espera de la forma [0.1,0.5], o si solo se pasa [0.1] es lo mismo que [0.1, 0.1]

    aprox_points = NaN;
    error_code = 0;

    % defino las maximas iteraciones para ambos intervalos
    max_iterations_x = (abs(intervals(1,1)-intervals(1,2)))/looping_step;
    max_iterations_y = (abs(intervals(2,1)-intervals(2,2)))/looping_step;

    disp(max_iterations_x)

    % defino la matriz H que contiene todos los coeficientes de las ecuaciones
    H = zeros(max_iterations_x);

    % defino el vector resultado
    result_vector = zeros(1, max_iterations_x);

    X = [intervals(1,1):looping_step:intervals(1,2)];
    Y = [intervals(2,1):looping_step:intervals(2,2)];

    for (j = 2:(max_iterations_y-1))
        for (i = 2:(max_iterations_x-1))

            if (i == intervals(1, 1))
                condition = border_conditions{1,2};
                H(i, 1) = condition(X(i));
            elseif (i == intervals(2, 1))
                condition = border_conditions{2,2};
                H(i, max_iterations_y) = condition(X(i));
            elseif (j == intervals(2, 1))
                condition = border_conditions{3,2};
                H(1, j) = condition(Y(j));
            elseif (j == intervals(2, 2))
                condition = border_conditions{4,2};
                H(max_iterations_x, j) = condition(Y(j));
            else
                H(i-1,j) = -1;
                H(i,j+1) = -1;
                H(i,j) = 4;
                H(i+1,j) = -1;
                H(i,j-1) = -1;
            end

        end
    end

%    for (i = 1:max_iterations_x)
%        condition = border_conditions{1,2};
%        H(i, 1) = condition(X(i));
%    end
%    for (i = 1:max_iterations_x)
%        condition = border_conditions{2,2};
%        H(i, max_iterations_y) = condition(X(i));
%    end
%    for (j = 1:max_iterations_y)
%        condition = border_conditions{3,2};
%        H(1, j) = condition(Y(j));
%    end
%    for (j = 1:max_iterations_y)
%        condition = border_conditions{4,2};
%        H(max_iterations_x, j) = condition(Y(j));
%    end

    disp(H);

end
