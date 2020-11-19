## Copyright (C) 2020 tomii
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
## @deftypefn {} {@var{retval} =} biseccion (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: TOMAS VIDAL
## Created: 2020-10-09

# EL PROPOSITO DE ESTA FUNCION ES APROXIMAR UNA RAIZ A UNA FUNCION, EN LO POSIBLE POLINOMICA
# LOS PARAMETROS SON f, QUE ES LA FUNCION A LA QUE SE LE QUIERE ENCONTRAR LA RAIZ, a Y b QUE SON LOS 
# EXTREMOS DEL INTERVALO EN EL QUE SE ENCUENTRA LA RAIZ, INFERIOR Y SUPERIOR RESPECTIVAMENTE,
# Y POR ULTIMO max_error ES EL ERROR MAXIMO QUE SE LE DA DE TOLERANCIA AL RESULTADO DEVUELTO, 
# QUE ESTA CALCULADO EN PORCENTAJE, ADEMAS SI PARA 5000 ITERACIONES NO SE HALLA UN RESULTADO ACORDE A LA 
# TOLERANCIA SE VA A CANCELAR EL PROGRAMA Y DEVOLVER QUE LA PRECISION REQUERIDA ES DEMASIADO GRANDE

function [roots, iterations] = biseccion (f, a, b, max_error)
  
  k = 3;
  roots(1) = a;
  roots(2) = b; 
  roots(3) = (a+b)/2;
      
  do  
    current_root = roots(k);
    left_interval = roots(k-2);
    right_interval = roots(k-1);
    
    if (current_root*left_interval < 0)
      roots(k+1) = (current_root+left_interval)/2;
    elseif (current_root*left_interval > 0)
      if (k == 3) 
        disp("NO HAY RAICES EN EL INTERVALO DADO");
        disp("ERROR 1");
      else
        roots(k+1) = (current_root+right_interval)/2;
      endif;
    endif;    
    error = (current_root-right_interval)*(100/right_interval);    
    k = k + 1;
  until (error <= max_error || k == 5000)
    
  iterations = k - 2;
endfunction;
