# HECHO POR TOMAS VIDAL
# CALCULA LA INTEGRAL DE LA FUNCION F POR APROXIMACION DE SIMPSON 1/3
clear all;
clc;
format long;

minStep = 0; # PASO CON LA PRECISION QUE CALCULA LA INTEGRAL
maxStep = 1.5; # VALOR INCIAL DE LA INTEGRAL
loopingStep = 0.5; # VALOR FINAL DE LA INTEGRAL
n = maxStep/loopingStep;

global totalIntegration = 0;

# ES LA FUNCION QUE SE INTEGRA
function fx = f(x)
  if (x != (-1)) # POR SI ACASO ALGUIEN INGRESA -1 COMO VALOR DE X 
    fx = 1 / (x + 1);
  else 
    fx = "INFINITO"
    disp("ERROR 1");
  endif;
endfunction;

if (mod(maxStep, loopingStep) != 0)
  # si el paso elegido para hacer el loop no divide al maximo el partes enteras
  # es necesario definir otro paso
  loopingStep = loopingStep/0.1;
  if (mod(maxStep, loopingStep) != 0)
    # ESTO ES POR SI TODAVIA BAJANDO UN GRADO EL LOOPINGSTEP SIGUE DANDO IMPAR
    loopingStep = loopingStep/0.1;
  endif;
endif;

# LOOP PRINCIPAL QUE VA CALCULANDO LOS VALORES DE LOS TRAPECIOS Y LOS SUMA
for step = minStep:loopingStep:(maxStep-loopingStep);
  if (mod(step, 2) != 0)
    # CASO PARA CUANDO NO ES EL PUNTO
    a = step - loopingStep;
    b = step + loopingStep;
    h = (b - a)/n;
    fx0 = f(b);
    fx1 = f(a);   
    fx2 = f(step);
    aproximation = (h/3) * (fx0 + 4*fx2 + fx1);
    totalIntegration = totalIntegration + aproximation;  
    plot(a, fx1, 'b'); hold on;
    plot(b, fx0, 'b'); hold on;
    plot(step, fx2, 'b'); hold on;
    plot(step, f(step), '*r');
  endif;
endfor;

disp("INTEGRAL: ");
disp(totalIntegration);

#hold off;