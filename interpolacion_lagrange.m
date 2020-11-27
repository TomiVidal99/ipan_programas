% HECHO POR TOMAS VIDAL
% METODO DE INTERPOLACION PARA APROXIMAR UNA FUNCION CON POLINOMIOS DE LAGRANGE

function [f, error_code] = interpolacion_lagrange(A, polinome_grade)
    % la matriz A contiene los datos de la funcion a la que se le quiere encontrar la funcion que la aproxime, estos datos se suponen de dos columnas y n filas, donde la primera columna contiene los datos de la variable independiente y la segunda de los dependiente
    % defino error inicial a cero y las variables que contienen las dimensiones de la matriz A
    error_code = 0;
    [rows_a, cols_a] = size(A);

    % defino el vector X que contiene los datos de la variable independiente
    X = A(1:end, 1);
    % defino el vector Y que contiene los datos de la variable dependiente
    Y = A(1:end, 2);

    % defino el polinomio de aproximacion de grado "polinome_grade"
    Pn = @(x) 0;
    for (n = 1:rows_a)
        for (k = 1:polinome_grade)
            if (k != n)
                product = @(x) ( (x - X(k)) / (X(n) - X(k)) );
            end
        end
        g = @(x) (Y(n) * product);
        Pn = @(x) Pn(x) + g(x);
    end

    f = Pn;

    hold off;
    plot(X, Y, 'b*'); hold on;
    for (n = -5:0.1:5)
        plot(n, f(n), 'r+'); hold on;
    end

end
