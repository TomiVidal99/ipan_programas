% HECHO POR TOMAS VIDAL
% METODO DE NEWTON PARA HALLAR UNA FUNCION QUE INTERPOLE UN CONJUNTO DE PUNTOS DADOS

function [f, error_code] = interpolacion_newton(data)
    % la funcion devuelve f que es la funcion que se quiere obtener para ajustar los datos
    % y devulve un numero de error dependiendo el estado en el que haya terminado de ejecutarse la funcion
    % polinome_grade es el grado del polinomio que se desea obtener
    % se requiere que se le de data como parametro, data es el conjunto de puntos de la funcion a aproximar, se suponen que los datos se dan en dos columnas y n filas, donde en la primera columna estan los datos de la variable independiente y en la segunda los de la dependiente.
    error_code = 0;
    f = 0;
    [data_rows, data_columns] = size(data);

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

        % defino la tabla de diferencias divididas
        table = zeros(N, N+1);
        % le asigno las dos primeras columnas a los puntos dados
        table(1:end, 1) = X;
        table(1:end, 2) = Y;

        % aplico el algoritmo para llenar la tabla con las diferencias divididas
        for (m = 3:(N+1))
            for (n = 1:N-1)
               diferencia_dividida = (Y(n+1) - Y(n)) / (X(n+1) - X(n));
               table(n,m) = diferencia_dividida;
            end
        end

        % ahora creo el polinomio a partir de la tabla de diferencias divididas
        f = @(x) Y(1);
        for (n = 3:(N+1))

            % creo el producto de los N (x - xn)
            product = @(x) 1;
            for (k = 1:(n-2))
               product = @(x) (product(x) * (x - X(k)));
            end

            % ahora hago la suma 
            f = @(x) f(x) + table(1, n) * product(x);

        end

    end

end
