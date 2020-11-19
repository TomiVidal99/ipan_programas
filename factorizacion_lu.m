# HECHO POR TOMAS VIDAL

function [L, U, error_code] = factorizacion_lu(A)
    error_code = 0;
    r = rows(A);
    c = columns(A);
    L = eye(r);
    U = A;
    if (c != r)
        # la matriz no es cuadrada
        error_code = 1;
        disp("Error: la matriz no es cuadrada");
    else
        # ahora se aplica el algoritmo
        for (k = 1:r)

            pivot = A(k,k); # defino el pivote

            if (pivot == 0)
                # si el pivote es cero debo permutar las filas
                permutated_matrix = A([1:(k-1), (k+1), k ,k+2:r], :); # defino la matriz permutada
                A = permutated_matrix; # intercambio las matrices
            else 
                for (i = k:r)
                    if (i != k)
                        # calculo el coeficiente para la columna del pivote actual
                        c = A(i,k) / A(k,k); # coeficiente por el que se resta la fila 

                        L(i,k) = c; # asigno el coeficiente calculado a la matriz inferior L
                    
                        deleting_row = c*A(k, 1:end); # fila que resta de A
                        current_row = A(i, 1:end); # fila a restar de A
                        A(i, 1:end) = current_row - deleting_row; # hago la resta de la fila de A
                        
                    endif
                endfor
            endif
        endfor
    endif
    U = A;
endfunction
