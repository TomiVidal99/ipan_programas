function [W] = PI_Adams_Bashforth_Explicitos_G(f,h,a,b,Y,G,tol)
%f es mi y'
%h es mi paso
%a es mi punto inicial y el valor con el que se obtiene la CI y(a)
%b es mi punto final, del cual quiero obtener el valor y(b)
%CI es el resultado de la CI, es decir, y(a)
%Y es la solucion analítica
%G es mi grado, debe ser menor o igual a 4


N=((b-a)/h)+1; %N es la cantidad de puntos con lo que trabajo
Xn(1)=a;
Xn(N)=b;

  for n=2:(N-1)
    Xn(n)=Xn(n-1)+h;
  end
  
W(1)=Y(0);
W(2)=Y(0.5);
W(3)=Y(1);
W(4)=Y(1.5);
W(5)=Y(2);


  if G==3

      for n=6:N
          W(n)=W(n-1)+(h/12)*(23*(f(Xn(n-1),W(n-1)))-16*(f(Xn(n-2),W(n-2)))+5*(f(Xn(n-3),W(n-3))));
          for i=1:1000
                        E=(Y(Xn(n))-W(n))/Y(Xn(n));
                        if abs(E)>tol
                            W(n)=W(n-1)+h*(5*f(Xn(n),W(n))+8*f(Xn(n-1),W(n-1))-f(Xn(n-2),W(n-2)))*(1/12);
                        else
                            break
                        end
          end
      end
  elseif G==5

      for n=6:N
          W(n)=W(n-1)+(h/720)*(1901*(f(Xn(n-1),W(n-1)))-2774*(f(Xn(n-2),W(n-2)))+2616*(f(Xn(n-3),W(n-3)))-1274*(f(Xn(n-4),W(n-4)))+251*f(Xn(n-5),W(n-5)));
          for i=1:1000
                        E=(Y(Xn(n))-W(n))/Y(Xn(n));
                        if abs(E)>tol
                            W(n)=W(n-1)+(h/720)*(251*f(Xn(n),W(n))+646*f(Xn(n-1),W(n-1))-264*f(Xn(n-2),W(n-2))+106*f(Xn(n-3),W(n-3))-19*f(Xn(n-4),W(n-4)));
                        else
                            break
                        end
          end
      end
  else 
  end
  

plot(Xn,W,'r');
hold on;
plot(Xn,Y(Xn),'b');
hold on;

end

