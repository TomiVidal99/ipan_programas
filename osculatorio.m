% HECHO POR TOMAS VIDAL
% METODO ONDULATORIO PARA HALLAR FUNCION QUE INTERPOLE LOS PUNTOS DADOS

function [function_aproximated, error_code] = osculatorio(data, polinome_grade)
    % se devuelve una funcion que depende de x y un codigo de error,
    % data se espera que tenga la forma de 4 columnas por n filas, donde la primera columa
    % corresponde a los valores de la variable independiente de la funcion, la segunda columna corresponde
    % a los valores de la variable dependiente, y lo mismo para la 3ra columna, que contiene los de la derivada primera de la funcion

    error_code = 0;
    function_aproximated = @(x) 0;

    % defino las variables que contienen las dimensiones de data
    [data_rows, data_columns] = size(data);

    % compruebo que se den las condiciones necesarias de las dimensiones de data
    if (data_rows < data_columns || data_columns != 3)
        error_code = 1;
        disp("ERROR: data no tiene las dimensiones correctas");
    else

        % defino la tabla que contiene que todos los datos del polinomio interpolante
        N = data_rows*2;
        table = zeros(N, N+1);

        if (polinome_grade > data_rows || polinome_grade <= 0)
            error_code = 2;
            disp("ERROR: el el grado de polinomio dado no es correcto, se tomara el mayor posible: ");
            disp(N);
            polinome_grade = N;
        end

        % defino los vectores que contienen los datos dados por separado
        X = data(1:end, 1);
        Y = data(1:end, 2);
        Xp = data(1:end, 3);

        % asigno los valores de los datos a los lugares correspondientes de la tabla
        k = 0;
        for (n = 1:N)
            dd = 0;
            if ( mod(n, 2) != 0)
                % cuando n es impar
                k = k+1;
                % si es impar es porque no va una diferencia dividida, sino una derivada
                dd = Xp(k);
            else
                % si n es par defino la diferencia dividida
                if (k != data_rows)
                    dd = ( ( Y(k+1) - Y(k) ) / ( X(k+1) - X(k) ) );
                end
            end
            table(n, 1) = X(k);
            table(n, 2) = Y(k);
            table(n, 3) = dd;
        end

        % aplico el algoritmo para el resto de la tabla
        k = 2;
        for (m = 4:(N+1))
            for (n = 1:(N-k))
               table(n,m) = ( (table(n+1, m-1) - table(n, m)) / (table(n+2, 1) - table(n, 1)) );
            end
            k = k+1;
        end
        disp(table);

        % ahora creo el polinomio a partir de la tabla de diferencias divididas
        %function_aproximated = @(x) table(1, 2);
        %for (j = 3:polinome_grade)
            %product = @(x) 1;
            %for (i = 1:(j-1))
                %product = @(x) ( product(x) * (x - table(i,1)) );
            %end
            %function_aproximated = @(x) ( function_aproximated(x) + product(x) * table(1, j) );
       %end

        % ahora creo el polinomio a partir de la tabla de diferencias divididas
         function_aproximated = @(x) table(1, 2);
         for (n = 3:(N+1))

             % creo el producto de los N (x - xn)
             product = @(x) 1;
             for (k = 1:(n-1))
                product = @(x) (product(x) * ( x - table(1, k) ));
             end

             % ahora hago la suma 
             function_aproximated = @(x) function_aproximated(x) + table(1, n) * product(x);

         end


    end
end
