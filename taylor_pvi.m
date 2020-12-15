% HECHO POR TOMAS VIDAL
% METODO DE UN PASO DE TAYLOR PARA RESOLVER NUMERICAMENTE PROBLEMAS DE VALOR INICIAL
% SE USA SOLO PARA ECUACIONES DIFERENCIALES ORDINARIAS DE ORDEN 1 EXPLICITAS

function [aproximated_points, acumulated_error, error_code] = taylor_pvi(functions_and_derivates, polinome_grade, initial_conditions, interval_a, interval_b, looping_step)
    % functions_and_derivates es la funcion f(x,y) y todas las derivadas hasta polinome_grade - 1, SE ESPERA QUE 
    % SEAN DE LA FORMA DE UNA VECTOR DE n FUNCIONES
    % initial_conditions son las condiciones iniciales dependientes del grado de aproximacion usado, AL IGUAL QUE functions_and_derivates SE ESPERA QUE SEA UN VECTOR
    % interval_a y interval_b son los extremos del intervalo considerado [a,b]
    % looping_step es el paso con el que se va a realizar la aproximacion
    % por otro lado lo que se espera que es devuelva es aproximated_points que son los puntos aproximados con los datos dados
    % acumulated_error es el error acumulado debido a que solo es una aproximacion
    % y el codigo de error que es cero si todo a salido segun lo esperado

    % defino los valores que devuelve la funcion
    error_code = 0;
    acumulated_error = NaN;
    aproximated_points = NaN;

    % verifico que se den las condiciones necesarias para aplicar el algoritmo
    if (length(functions_and_derivates) != 1 && polinome_grade > 1 && length(initial_conditions) > 1 && interval_b > interval_a && (interval_b-interval_a) > looping_step)
        
    else
        error_code = 1;
        disp('ERROR: uno de los parametros utilizados no es valido.');
    end

end
