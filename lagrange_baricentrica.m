% HECHO POR TOMAS VIDAL
% INTERPOLA FUNCION POR MEDIO DE POLINOMIOS DE LAGRANGE
% PERO AHORA SE LE APLICA LA OPTIMIZACION BARICENTRICA

function [function_aproximated, error_code] = lagrange_baricentrica(data, polinome_grade)
    % dado un conjunto de puntos (data) de la forma la primera columa estan los puntos de la variable
    % independiente y en la segunda los de la dependiente
    % y dado un grado del polinomio deseado (polinome_grade) se devuelve la funcion que interpola los datos
    error_code = 0;
    function_aproximated = @(x) 0;

    % defino el vector X de los valores de la variable independiente
    X = data(1:end, 1);
    % defino el vector Y de los valores de la variable dependiente
    Y = data(1:end, 2);

    % defino las variables que contienen las dimensiones de data
    [data_rows, data_cols] = size(data);
    
    % verifico que data tenga las dimensiones correctas
    if (data_cols != 2 || data_rows < 2)
        error_code = 1;
        disp("ERROR: la matriz ingresada no tiene las dimensiones correctas")
    else

        if (polinome_grade < 0 || polinome_grade > 1000 || polinome_grade == 'max')
            error_code = 2;
            disp("ERROR: el grado de polinomio no es aceptable")
            disp("Se usara el maximo disponible: ");
            disp(data_rows);
            polinome_grade = data_rows;
        end
        
        b_n = @(n) 1;
        for (k = 1:polinome_grade)
            b_n = @(n) b_n * (Y(k)/(X(n) * X(k)));
        end
        product_term = @(x) 1;
        for (k = 1:polinome_grade)
            product_term = @(x) (product_term(x)*(x - X(k)));
        end
        sum_term = @(x) 0;
        for (n = 1:polinome_grade)
            sum_term = @(x) (b_n(n) / (x - X(n)));
        end
        

       for n = 1:polinome_grade
           product = @(x) 1;
           for k = 1:polinome_grade
               if (k != n)
                   product = @(x) ( product(x) * ((x - X(k)) / (X(n) - X(k))));
               end
           end
           function_aproximated = @(x) ( function_aproximated(x) + ( Y(n) * product(x) ));
       end
    end
end
