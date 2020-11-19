clc;

max_iterations = input("Introducir las maximas iteracions: ");


tot = 0;
for n = 1:1:max_iterations
  x(n) = (0.5)^n;
  tot = tot + x(n);
  plot(n, tot, "+"); hold on;
  plot(n, x(n), "*"); hold on;
endfor;

hold off;

disp(tot);