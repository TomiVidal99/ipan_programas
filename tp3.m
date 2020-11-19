## Hecho por tomas vidal
clc; ## limpiar pantalla


figure; axis([-3 4 -4 4]); hold on;
for t = 0:0.01:30 ## defino la variable t que voy a usar para recorrer
  x = cos(t)*( e^(cos(t)) - 2*cos(4*t) - (sin(t/12))^5) ## Defino x
  y = sin(t)*( e^(cos(t)) - 2*cos(4*t) - (sin(t/12))^5) ## Defino y
  axis equal ## Defino los ejes del grafico para que sean iguales
  plot(x,y); hold on; ## Grafico
  pause(0.1);
endfor

hold off; ## Esto es para que se reinicie el grafico la proxima vez que se ejecute el script
