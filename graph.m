function [points] = graph(f, interval, step, color)
    k = 1;
    for (x = interval(1):step:interval(2))
        plot(x, f(x), color);
        X(k) = x;
        Y(k) = f(x);
        k = k + 1;
    end
    points = [X;Y];
end
