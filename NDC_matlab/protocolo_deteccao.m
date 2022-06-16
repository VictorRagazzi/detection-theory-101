function [dr,time] = protocolo_deteccao(x, parametros)


binsM = 120; 
%cálcular o valor do detector 
%aplicar o detector a cada janela ------------------
xfft = fft(x); %aplico uma ´única vez a FFT.  

for M = 1:binsM %fazer para cada acrescimo de uma janela       
   %ord(:,M) = msc_fft(xfft(bin,1:M),M);    
   %ord(:,M) = msc_fft(xfft(1:binsM,1:M),M);
   for N = 1:size(x,2)
       Y = sort(xfft(M,1:N));%,'ComparisonMethod','abs'); % Colocar em ordem crescente em relação ao módulo
       Y = (Y./abs(Y).*(1:N)); % Trocando o módulo pelo rank
       Cm = mean(real(Y));
       Sm = mean(imag(Y));
       ord(M,N) = (sqrt(Cm.*Cm + Sm.*Sm))/sqrt(N);
   end 
end




for ii = 1:size(parametros,1)

    %parametros 
    Mmin = parametros(ii,1);
    Mstep = parametros(ii,2);
    Mmax = parametros(ii,3);
    NDC = parametros(ii,4);
    alfa = parametros(ii,5);
    L = parametros(ii,6);
    % protocolo
    MM = Mmin:Mstep:Mmax;
    
    for ll = 1:size(ord,1) 
        
        [dr(ll,ii),time(ll,ii)] = ETS(ord(ll,:)',MM',alfa,NDC, L);
    end
    
end
    
%     det = ord(:,MM);
%     
%     valor_critico = VC_MSC(MM,alfa);
%     det = det>repmat(valor_critico,size(det,1),1);
% 
% 
%     %dr = double(sum(det,2)>1);
%     for ll = 1:size(ord,1) 
%         
%         dr(ll,ii) = double(sum(det(ll,:),2)>0);
%         if dr(ll,ii) ==0     
%             time(ll,ii) = -1;
%         else 
%             aux = find(det(ll,:)==1);
%             time(ll,ii) = MM(aux(1)); 
%         end
%     
%     end
    






