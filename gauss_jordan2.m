## Copyright (C) 2020 
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} gauss-jordan (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  TOMAS VIDAL
## Created: 2020-11-04

function [result, error_code] = gauss_jordan2(A, v)
    error_code = 0;
    row = rows(A);
    column = columns(A);
    len = rows(v);
    b = transpose(v);
    
    if (column != row)
        # la matriz no es cuadrada
        error_code = 1;
        disp("Error: la matriz no es cuadrada");
    elseif (column != len)
        # el vector b tiene diferente cantidad de filas que la matriz A
        error_code = 2;
        disp("Error: el vector resultado no tiene la dimension correcta");
    else
        # ahora se aplica el algoritmo
        k = 1;
        i = k + 1;
        do
          
            pivot = A(k,k); # defino el pivote

            if (pivot == 0)
                # si el pivote es cero debo permutar las filas
                permutated_matrix = A([1:(k-1), (k+1), k ,k+2:row], :); # defino la matriz permutada
                disp(A);
                disp("-----");
                disp(permutated_matrix);
                disp(".     .       .");
                A = permutated_matrix; # intercambio las matrices
                
            else 
                disp("test");
                c = A(i,k) / A(k,k); # coeficiente por el que se resta la fila 
            
                deleting_row = c*A(k, 1:end); # fila que resta de A
                current_row = A(i, 1:end); # fila a restar de A
                A(i, 1:end) = current_row - deleting_row; # hago la resta de la fila de A
                
                current_value = b(i); # el resultado al que se le va a restar de b
                deleting_value = c*b(k); # valor de b por el coeficiente que resta
                b(i) = current_value - deleting_value; # resta del valor de b
                
                k = k + 1;
            endif
 
        until((i = row))
    endif
    result = transpose(b);
endfunction
