%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Opcional: Copiar todo el siguiente código y pegarlo en una hoja de Matlab/Octave.
% Guardarlo en un archivo .m y ejecutarlo llamando a la función animacion(V0),
% siendo V0 el valor de la velocidad inicial hallado mediante la resolución del problema dado.
% Con el parámetro FPS se puede ajustar la velocidad de la animación.

function animacion(V0)

FPS=60; % Puede variar entre 10 y 1000

t=0:1e-3:1.3;    % Intervalo de tiempo

alpha=40; g=9.8; x0=0; y0=2; x=10; y=3.05;    % Parametros

xt=x0+V0*cos(alpha*pi/180)*t;    % Trayectoria de la pelota
yt=y0+V0*sin(alpha*pi/180)*t-1/2*g*t.^2;   % Trayectoria de la pelota

R=0.3; xp=-R:R/100:R; yp=sqrt(R.^2-xp.^2); % Para la cancha
Rc=0.7; xc=-Rc:Rc/100:Rc; yc=sqrt(Rc.^2-xc.^2); % Para la cancha
L=12; % Para la cancha
flag=0; % Control de resultados

figure(1); % Animacion
for i=1:length(t)-1
    if mod(t(i),(round(1000/FPS))/1000)==0
        fill([[0 L] 0.75*[L 0]],[-[1 1] [1 1]],[0.8 0.4 0.1]); %Piso
        hold on; axis equal;
        fill([2*L/3 0.9*L 0.85*L 0.95*2*L/3],[-0.2*[1 1] 0.2*[1 1]],[0.95 0.95 0.95]); % Área
        fill([2*L/3-0.5-xc 2*L/3-0.5+xc],[yc -yc]/2,[0.95 0.95 0.95]); % Área
        fill([0.94*L 0.94*L 0.95*L 0.95*L],[-0.2 4 4 -0.2],[0.2 0.2 0.2]); % Poste
        fill([0.86*L 0.96*L 0.96*L 0.86*L],3.3+[-1+0.2 -1 1+0.2 1],[0.7 0.7 0.7]); %Tablero
        fill([x-xc x-xc],[yc/4+y -yc/4+y],[0.2 0.2 0.2]); %Aro contorno
        fill([x-0.99*xc x-0.99*xc(end:-1:1)],[0.99*yc/4+y -0.99*yc/4+y],[0.95 0.95 0.95]); %Aro cara interna
        fill([xp -xp]+xt(i),[yp -yp]+yt(i),[0.7 0.4 0.2]); fill(0.6*[xp -xp]+xt(i),[yp -yp]+yt(i),[0.7 0.4 0.2]); %Pelota
        pause(1/100000); hold off
    end

    if abs(x-xt(i))/x<0.00005 && abs(y-yt(i))/y<0.00005   %Verificacion
        flag=1;
    end
end

if flag==0   % Sonidos de notificacion
    Fs=44100; tt=0:1/Fs:0.4-1/Fs; s=(sin(2*pi*70*tt)>0.5)+0.5*rand(1,length(tt)); sound(s,Fs);
    text(2,4,'¡No! ¡Intenta otra vez!','fontsize',20);
else
    Fs=44100; tt=0:1/Fs:0.4-1/Fs; s=(sin(2*pi*2000*tt)).*[ones(1,length(tt)/7) zeros(1,length(tt)/7) ones(1,length(tt)/7) zeros(1,length(tt)/7) ones(1,length(tt)/7) zeros(1,length(tt)/7) ones(1,length(tt)/7)]; sound(s,Fs);
    text(2,4,'¡¡TRIPLE!!','fontsize',20);
end