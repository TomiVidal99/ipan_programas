% HECHO POR TOMAS VIDAL
% la idea es un programa que dada una funcion, un intervalo en la que es continua y un paso
% se grafica la funcion

function graph_function(f, a, b, step)
    for (x = a:step:b)
        plot(x, f(x), 'cd'); hold on;
    end
end
