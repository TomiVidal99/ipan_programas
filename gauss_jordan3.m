function [x0] = gauss_jordan3(A,b)

b = transpose(b);

if ((size(A,1)~=size(A,2)) || det(A)==0)
    display('no se puede calcular soluci�n');
    x0=NaN;

else

    N=length(A);
    Ab=[A b];

    for n=1:N
        %Pivoteo parcial
        for k = (n+1):N
            f_pivot=Ab(n,n);
            if abs(Ab(k,n))>abs(f_pivot)
                aux=Ab(n,:);
                Ab(n,:)=Ab(k,:);
                Ab(k,:)=aux;
            end
        end

        %Eliminaci�n hacia adelante
        for m = (n+1):N
            Ab(m,:)=Ab(m,:)-Ab(m,n)/Ab(n,n)*Ab(n,:);
        end
    end

    for n = N:-1:1
        %Eliminaci�n hacia atr�s
        for m=(n-1):-1:1
            Ab(m,:)=Ab(m,:)-Ab(m,n)/Ab(n,n)*Ab(n,:);
        end
    end

    for n=1:N
        %Normalizaci�n
        
        Ab(n,:) = Ab(n,:)/Ab(n,n);

    end

    disp(Ab);
    
    x0=Ab(:,N+1);

end
