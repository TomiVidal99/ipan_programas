
function [data] = test(amount_of_points)
    data = zeros(amount_of_points, 2);
    for (n = 1:amount_of_points)
       data(n, 1) = n;
       data(n, 2) = cos(n); 
       data(n, 3) = (-1)*(sin(n));
    end
end
