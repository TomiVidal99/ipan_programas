% HECHO POR TOMAS VIDAL
% METODO DE VANDERMONDE PARA OBTENER FUNCION DE AJUSTE DADOS N PUNTOS

function [f, error_code] = vandermonde(data, max_grade)
    % la funcion devuelve f que es la funcion que se quiere obtener para ajustar los datos
    % y devulve un numero de error dependiendo el estado en el que haya terminado de ejecutarse la funcion
    % polinome_grade es el grado del polinomio que se desea obtener
    % se requiere que se le de data como parametro, data es el conjunto de puntos de la funcion a aproximar, se suponen que los datos se dan en la primera fila la variable dependiente y en la segunda fila la funcion evaluada
    error_code = 0;
    f = 0;
    [data_rows, data_columns] = size(data);

    % compruebo que los puntos dados tengan la dimension correcta
    if (data_rows == 0 || data_columns == 0 || data_rows > data_columns) 
        error_code = 2;
        disp('ERROR: los datos ingresados no tienen la dimension correcta');
    end

    % con este condicional defino cuantas muestras voy a tomar para hacer la aproximacion
    max_iterations = 0;
    if (data_columns > max_grade)
        max_iterations = max_grade;
    else
        max_iterations = data_columns;
    end

    % genero la matriz V
    v_dimension = max_iterations;
    V = ones(max_iterations);
    for (n = 1:max_iterations)
        for (m = 2:max_iterations)
            exponent = m - 1;
            V(n,m) = (data(1, n))^(exponent);
        end
    end

    % defino el vector con los f(x)
    Y = transpose(data(2, 1:max_iterations));
    % resuelvo la ecuacion V*a = Y donde a es el vector que quiero saber, que contiene los coeficientes de los x
    a = inv(V)*Y;

    % creo la funcion a partir de la suma de los coeficientes y los x
    f = @(x) 0;
    for (i = 1:max_iterations)
        current_coeficient = a(i);
        exponent = i;
        g = @(x) (current_coeficient * (x ^ exponent));
        f = @(x) (f(x) + g(x));
    end

    % grafico para ver como es la aproximacion
    hold off;
    for (it = 10:0.1:15)
       plot(it, f(it), 'r+'); hold on;
    end
    plot(data(1,1:max_iterations), data(2,1:max_iterations), 'b*'); hold on;

end
