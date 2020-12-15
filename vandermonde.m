% HECHO POR TOMAS VIDAL
% METODO DE VANDERMONDE PARA OBTENER FUNCION DE AJUSTE DADOS N PUNTOS

function [f, error_code] = vandermonde(data, grade)
    % la funcion devuelve f que es la funcion que se quiere obtener para ajustar los datos
    % y devulve un numero de error dependiendo el estado en el que haya terminado de ejecutarse la funcion
    % polinome_grade es el grado del polinomio que se desea obtener
    % se requiere que se le de data como parametro, data es el conjunto de puntos de la funcion a aproximar, se suponen que los datos se dan en dos columnas y n filas, donde en la primera columna estan los datos de la variable independiente y en la segunda los de la dependiente.
    error_code = 0;
    f = 0;
    [data_rows, data_columns] = size(data);

    % compruebo que los puntos dados tengan la dimension correcta
    if (data_rows == 0 || data_columns == 0 || data_rows  < data_columns) 
        error_code = 1;
        disp('ERROR: los datos ingresados no tienen la dimension correcta');
    else
        if (grade > data_rows || grade == 'max')
            error_code = 2;
            disp('ERROR: el grado ingresado es mayor al numero de puntos dados');
            disp('Se usara el maximo disponible: ');
            disp(data_rows);
            grade = data_rows;
        end

        % genero la matriz V
        V = ones(grade);
        for (n = 1:grade)
            for (m = 2:grade)
                exponent = m - 1;
                V(n,m) = (data(n, 1))^(exponent);
            end
        end

        % defino el vector con los f(x)
        Y = data(1:grade, 2);
        % resuelvo la ecuacion V*a = Y donde a es el vector que quiero saber, que contiene los coeficientes de los x
        a = inv(V)*Y;

        % creo la funcion a partir de la suma de los coeficientes y los x
        f = @(x) a(1);
        for (i = 2:grade)
            current_coeficient = a(i);
            exponent = i - 1;
            g = @(x) (current_coeficient * (x ^ exponent));
            f = @(x) (f(x) + g(x));
        end

        % grafico para ver como es la aproximacion
        %hold off;
        %for (it = -5:1:5)
           %plot(it, f(it), 'r+'); hold on;
        %end
        %plot(data(1,1:max_iterations), data(2,1:max_iterations), 'b*'); hold on;

    end

end
