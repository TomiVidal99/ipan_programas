clc;

draw_type = 2;
do
  draw_type = input("Linea[0] o punto[1]?: ");
until (draw_type == 1 | draw_type == 0);

steps = input("Cantidad de pasos por vector: ");
t =[ 0:(1/steps):(2*pi) ];

if (draw_type == 0)
  n = 0;
  while (n < columns(t))
    x = 2 * cos (t(n+1));
    y = 5 * sin (t(n+1));
    
    figure 1; stem(t(n+1), x); hold on;
  ##  figure 1; subplot(t(n+1), x); hold on;
  ##  figure 1; plot(t(n+1), y);
    
    n++;
  endwhile 
endif;

if (draw_type == 1)
  n = 0;
  while (n < columns(t))
    x = 2 * cos (t(n+1));
    y = 5 * sin (t(n+1));
    
    figure 1; plot(t(n+1), x); hold on;
  ##  figure 1; subplot(t(n+1), x); hold on;
  ##  figure 1; plot(t(n+1), y);
    
    n++;
  endwhile 
endif;


