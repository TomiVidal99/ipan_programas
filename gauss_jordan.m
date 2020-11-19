# HECHO POR TOMAS VIDAL

function [result, error_code] = gauss_jordan (A, b)
    error_code = 0;
    [rows_a, columns_a] = size(A);
    [rows_b, columns_b] = size(b);    
    determinant = det(A);
    
    if (determinant == 0)
      error_code = 1;
      disp("Error: el sistema no tiene solucion");
    elseif (rows_a != columns_a)
      error_code = 2;
      disp("Error: la matriz A no tiene las dimensiones correctas");
    elseif (rows_b != rows_a || columns_b != 1)
      error_code = 3;
      disp("Error: el vector b no tiene las dimensiones correctas");      
    else
      # procedo a aplicar el algoritmo
      k = 1;
      max_iterations = rows_a + 1000;
      do
        for (i = 1:rows_a)
          if (i != k)
            
            # hasta que no tenga un pivote distinto de cero no paro de permutar
            do 
                
              # defino mi pivote
              pivot = A(k,k);
              
              # si el pivote es cero debo permutar filas
              if (pivot == 0)
                #perm = A([1, 3, 2], :);
                if (k == 1 && rows_a > 3)
                  perm = A([2, 1, 3:rows_a], :);
                  A = perm;
                elseif (k == 1 && rows_a == 3)
                  perm = A([2, 1, 3], :);
                  A = perm;
                elseif (k == 1 && rows_a == 2)
                  perm = A([2, 1], :);
                  A = perm;
                elseif (k+1 <= rows_a)
                  perm = A([1:(k-1), (k+1), k], :);
                  A = perm;
                elseif (k == rows_a)
                  perm = A([k, 2:(k-1), 1], :);
                  A = perm;  
                endif
              endif
            
            # defino una maxima iteracion basada en las dimensiones de A
            # para evitar bucles infinitos
            max_iterations = max_iterations - 1;
            until (pivot != 0 || max_iterations == 0)
          
            # defino el coeficiente por el que voy a restar
            c = A(i,k) / pivot;
            
            # defino las filas que voy a usar para eliminar 
            # y la que voy a eliminar
            deleting_row = c*A(k,1:end);
            current_row = A(i, 1:end);
            A(i,1:end) = current_row - deleting_row;
            
            # defino el valor de b con el que voy a eliminar el otro
            deleting_value = c*b(k);
            current_value = b(i);
            b(i) = current_value - deleting_value;
            
          endif
        endfor
        
        k = k + 1;
      until (k == (rows_a + 1));
      
      # compruebo que no se haya llegado a la maxima iteracion por prevencion de bucle infinito
      if (max_iterations == 0)
        error_code = 8;
        disp("Error: se llego a las maximas iteraciones para permutar filas");
      endif
      
    endif
    
    # divido la el vector b por los coeficientes de la diagonal
    # para quedar con la matriz identidad y resolver la ecuacion
    for (k = 1:rows_a)
      pivot = A(k,k);
      temp = b(k) / pivot;
      temp2 = A(k,k) / pivot;
      A(k,k) = temp2;
      b(k) = temp;  
    endfor
    # devuelvo el resultado b
    result = b;
endfunction
