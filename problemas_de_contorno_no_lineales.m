% HECHO POR TOMAS VIDAL
% METODO DE DIFERENCIAS FINITAS PARA ECUACIONES DIFERENCIALES NO LINEALES

function [aprox_points, error_code] = problemas_de_contorno_no_lineales(diff_function, known_points, interval, looping_step, max_iteration)
    % diff_function es f en el caso y'' = f(x,y,y') donde se despeja el orden maximo 
    % known_points son los puntos que ya se conocen con buena o mala precision, se suponen que las condiciones inciales ya estan dadas en estos puntos
    % interval es el intervalo considerado se toma de la forma [a,b]
    % looping_step es el paso de iteracion que se quiere usar
    % max_iteration es la iteracion maxima que va a dictar la precision de los puntos aproximados
    % aprox_points son los puntos que van a tener una mejor precision
    % error_code es el codigo de error del programa, si todo esta correcto deberia ser cero

    aprox_points = NaN;
    error_code = 0;

    X = known_points(1,:);
    Y = known_points(2,:);

    W(1) = Y(1);
    W(length(X)) = Y(length(X));
    % este algoritmo es para O(h^2) usando diferencias finitas y punto fijo
    for (j = 1:max_iteration)
        for (n = 2:(length(X)-1))
            x = interval(1)+n*looping_step;
            W(n) = Y(n-1)/2 + Y(n+1)/2 - ((looping_step^2)/2)*(diff_function(x, Y(n), (Y(n+1)-Y(n-1))/(2*looping_step)));
        end
    end

    aprox_points = [X;W];

end
