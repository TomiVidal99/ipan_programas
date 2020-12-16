% HECHO POR TOMAS VIDAL
% METODO DE UN PASO DE TAYLOR PARA RESOLVER NUMERICAMENTE PROBLEMAS DE VALOR INICIAL
% SE USA SOLO PARA ECUACIONES DIFERENCIALES ORDINARIAS DE ORDEN 1 EXPLICITAS

function [aproximated_points, acumulated_error, error_code] = taylor_pvi(functions_and_derivates, polinome_grade, initial_conditions, interval_a, interval_b, looping_step)
    % functions_and_derivates es la funcion f(x,y) y todas las derivadas hasta polinome_grade - 1, SE ESPERA QUE 
    % SEAN DE LA FORMA DE UNA STRING, POR EJEMPLO: '@(x,y) x+1 @(x,y) y+2x', DONDE SOLO SON FUNCIONES ANONIMAS SEPARADAS POR UN ESPACIO
    % initial_conditions es la condicion inicial al problema, SE ESPERA QUE SEA LA EVALUACION DE Y' EN EL x=interval_a
    % interval_a y interval_b son los extremos del intervalo considerado [a,b]
    % looping_step es el paso con el que se va a realizar la aproximacion
    % por otro lado lo que se espera que es devuelva es aproximated_points que son los puntos aproximados con los datos dados
    % acumulated_error es el error acumulado debido a que solo es una aproximacion
    % y el codigo de error que es cero si todo a salido segun lo esperado

    % defino los valores que devuelve la funcion
    error_code = 0;
    acumulated_error = NaN;
    aproximated_points = NaN;

    % defino una funcion que me devuelva la n-esima funcion entregada por la string dada
    function [function_x_y] = function_from_string(functions_string, function_index)
        string_length = length(functions_string);
        current_function_string = strsplit(functions_string, '@(x,y)');
        function_x_y = str2func(strcat('@(x,y) ', current_function_string{function_index+1}));
    end

    % TODO: comprobar mas condicione de los parametros

    % verifico que se den las condiciones necesarias para aplicar el algoritmo
    if (polinome_grade > 1 && interval_b > interval_a && (interval_b-interval_a) > looping_step)
        

        % las maximas iteraciones que voy a hacer por el intervalo
        max_iterations = (interval_b-interval_a)/looping_step;

        % X es el vector que contiene los valores de la variable independiente
        X = [interval_a:looping_step:interval_b];
        % Y es el vector que contiene polinome_grade de valores inciales y luego se llena con las aproximaciones del algoritmo
        for (n = 1:length(initial_conditions))
            Y(n) = initial_conditions(n);
        end

        % aplico el algoritmo
        for (n = 1:max_iterations)
            % hago la suma del termino de series de taylor
            total_sum = 0;
            for (m = 1:polinome_grade)
                current_function = function_from_string(functions_and_derivates, m);
                local_sum = ((looping_step^(m))/(factorial(m)))*(current_function(X(n), Y(n)));
                total_sum = total_sum + local_sum;
            end
            Y(n+1) = Y(n) + total_sum;
        end

        % TODO: CALCULAR ERROR LOCAL

    else
        error_code = 1;
        disp('ERROR: uno de los parametros utilizados no es valido.');
    end
    
    aproximated_points = [X; Y];

end

