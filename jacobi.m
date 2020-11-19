# HECHO POR TOMAS VIDAL
# METODO ITERATIVO DE JACOBI PARA LA RESOLUCION DE ECUACIONES Ax=b

function [result, error_code] = jacobi(A, b, starting_value, total_iterations)
    error_code = 0;
    result = 0;
    [rows_a, columns_a] = size(A);
    [rows_b, columns_b] = size(b);

    if (rows_a != columns_a)
        error_code = 1;
        disp("ERROR: la matriz ingresada no es cuadrada");
    elseif (rows_b != rows_a)
        error_code = 1;
        disp("ERROR: el vector resultado no tiene las dimensiones correctas");
    else

        x(1:rows_a) = starting_value;
        x = transpose(x);

        for (m = 1:total_iterations)          
            for (n = 1:rows_a)
                row_A = A(n, 1:end) - A(n, n);
                row_x = x(1:end) - x(n);
                new_val = (b(n)-(row_A*row_x))/(A(n,n));
                x(n) = new_val;
            endfor
        endfor

    endif

    result = x;

endfunction