# HECHO POR TOMAS VIDAL
# CALCULA LA INTEGRAL DE LA FUNCION F POR APROXIMACION DE TRAPECIOS
clear all;
clc;
format long;

minStep = 0; # PASO CON LA PRECISION QUE CALCULA LA INTEGRAL
maxStep = 8; # VALOR INCIAL DE LA INTEGRAL
loopingStep = 0.01; # VALOR FINAL DE LA INTEGRAL

global totalIntegration = 0;

# ES LA FUNCION QUE SE INTEGRA
function fx = f(x)
  if (x != (-1)) # POR SI ACASO ALGUIEN INGRESA -1 COMO VALOR DE X 
    fx = 20 / (x^3 + 400);
  else 
    fx = "INFINITO"
  endif;
endfunction;

# LOOP PRINCIPAL QUE VA CALCULANDO LOS VALORES DE LOS TRAPECIOS Y LOS SUMA
for step = minStep:loopingStep:maxStep;
  if (step != maxStep)
    # CASO TODOS LOS PUNTOS EXCEPTO EL ULTIMO
    a = step;
    b = step + loopingStep;
    h = b - a;
    fx0 = f(a);
    fx1 = f(b);
    aproximation = (h/2) * (fx0 + fx1);
    totalIntegration = totalIntegration + aproximation;  
  elseif (step == maxStep)
    # CASO PARA EL ULTIMO PUNTO
    # NO HAGO NADA PORQUE NECESITO OTRO PUNTO MAS 
    # RESULTADO
    disp("INTEGRAL: ");
    disp(totalIntegration);
  endif;
endfor;

#hold off;