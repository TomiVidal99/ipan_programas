% Euler(x,y,f), x=vector de la forma x=a:h:b; y=solucion analitica del
% sistema; f= funcion de la giualdad y'=f(x,y); it=iteraciones, h=paso;
% f1=derivada

function [w,El,Ea]= Taylor_o2(h,x,y,f,f1,it)

n=length(x);

w=zeros(n,1);

w(1)=y(x(1))

for i=1:it
    
    w(i+1)=(w(i)+h*f(x(i),w(i))+((h^2)/2)*f1(x(i),w(i)));
    
end

fprintf('x\n');

disp(x)

fprintf('w\n');

disp(w)

%graficas

u=x(1):10e-6:x(n);

 subplot(2,1,1)
plot(x,w,'c*',u,y(u),'r');
grid minor
xlabel('Abcisas')
ylabel('Ordenadas')
title('Aproximación con Taylor de orden 2')

%errores

%local

El(1)=0;

for i=1:it
    
    El(i+1)=abs(y(x(i+1))-(y(x(i))+h*f(x(i),y(x(i)))+((h^2)/2)*f1(x(i),y(x(i)))));

end

%Acumulado

Ea(1)=0

for i=1:it+1
    
    Ea(i)=abs(y(x(i))-w(i));
    
end

subplot(2,1,2)
semilogy(x,Ea,'sr',x,El,'k*')
grid minor
legend('Error acumulado','Error local')
xlabel('Abcisas')
ylabel('Ordenadas')
title('Errores')
end





