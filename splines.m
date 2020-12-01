% HECHO POR TOMAS VIDAL
% METODO DE INTERPOLACION SPLINES PARA HALLAR UNA FUNCION QUE INTERPOLA LOS DATOS DADOS 
% TRAZANDO RECTAS ENTRE LOS PUNTOS

function [f, error_code] = splines(data)
    % la funcion devuelve f que es la funcion que se quiere obtener para ajustar los datos
    % y devulve un numero de error dependiendo el estado en el que haya terminado de ejecutarse la funcion
    % polinome_grade es el grado del polinomio que se desea obtener
    % se requiere que se le de data como parametro, data es el conjunto de puntos de la funcion a aproximar, se suponen que los datos se dan en dos columnas y n filas, donde en la primera columna estan los datos de la variable independiente y en la segunda los de la dependiente.
    error_code = 0;
    [data_rows, data_columns] = size(data);
    f = @(x) 0;

    % defino el vector X que contiene los valores de la variable independiente
    X = data(1:end, 1);
    % defino el vector Y que ocntien los valores de la variable dependiente
    Y = data(1:end, 2);

    % N es el grado del polinomio al que voy a llegar
    N = data_rows;

    % compruebo que los puntos dados tengan la dimension correcta
    if (data_rows == 0 || data_columns == 0 || data_rows  < data_columns) 
        error_code = 1;
        disp('ERROR: los datos ingresados no tienen la dimension correcta');
    else

        step = 0.05;
        for (n = 2:N)
            a = Y(n-1);
            b = (Y(n) - Y(n-1)) / (X(n) - X(n-1));
            sn = @(x) (a + b * (x - X(n)));
            for (j = X(n-1):step:X(n))
                hold on;
                plot(j, sn(j), 'r*');
            end
        end

    end

end
