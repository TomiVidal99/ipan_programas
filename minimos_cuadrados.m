# HECHO POR TOMAS VIDAL
# el objectivo es aproximar una funcion dado un conjunto de puntos como datos

function [f, error_code] = minimos_cuadrados(data, grade, apply_log)

    # data es el conjunto de puntos a los que se les quiere aproximar la funcion
    # se presumen que es de la forma de dos filas y n columnas

    # grade es el grado del polinomio que se quiere usar como aproximacion

    # apply_log es 0 o 1, donde es desactivado o activado respectivamente, y es para aplicar logaritmo a todos los valores de data
    
    error_code = 0;
    coeficients_a = 0;
    aproximation_function = 0;

    [data_rows, data_columns] = size(data); # defino las variables de dimension de la matriz dada

    # aplicar logaritmo a data
    if (apply_log == 1)
        for (n = 1:data_rows)
            for (m = 1:data_columns)
                new_val = log(data(n,m));
                data(n,m) = new_val;
            endfor
        endfor
    endif

    # defino la matriz H
    H = ones(data_columns, grade);
    for (m = 1:grade)
        for (n = 1:data_columns)
            H(n, m+1) = ((data(1, n))^(m));
        endfor
    endfor
    HT = transpose(H); 

    # defino el vector de coeficientes del polinomio
    coeficients_a = ((inv(HT * H)) * (HT) * (transpose(data(2, 1:end))));

    # defino la funcion de orden "grade"
    f = @(x) 0;
    for (ite = 1:(grade+1))
        a = coeficients_a(ite);
        exponent = ite-1;
        g = @(x) (a * x.^exponent);
        f = @(x) f(x) + g(x);
    endfor  

    hold off;
    for (n = 0:0.0001:2)
        plot(n, f(n), 'r*'); hold on;
    endfor

    for (n = 1:data_columns)
        plot(data(1, n), data(2, n), 'b+');
    endfor

endfunction