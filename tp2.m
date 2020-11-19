## Hecho por tomas vidal
clc; ## limpiar pantalla

## Defino constantes
a = 10;
b = 1;


## Defino x e y dependiendtes de las constantes
## y las dibujo en el grafico

for (theta = 0:0.1:(2*pi))
axis equal
x = a*cos(theta);
y = b*sin(theta);

plot(x, y); hold on;
endfor;