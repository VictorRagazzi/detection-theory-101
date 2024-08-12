function [dr,time] = protocolo_deteccao_qsample_2013(x, parametros,lim)

binsM = 120;
%binsM = 120; 
%cálcular o valor do detector 
%aplicar o detector a cada janela ------------------
xfft = fft(x); %aplico uma ´única vez a FFT.  

for M = 1:binsM %fazer para cada acrescimo de uma janela       
   %ord(:,M) = msc_fft(xfft(bin,1:M),M);    
   %ord(:,M) = msc_fft(xfft(1:binsM,1:M),M);
   for N = 1:size(x,2)
       Y = xfft([M 2*M 3*M],1:N);%,2,'ComparisonMethod','abs'); % Colocar em ordem crescente em relação ao módulo
       [~,Rank] = sort(Y(:)); % Trocando o módulo pelo rank
       [~,Rank] = sort(Rank);
       Rank = reshape(Rank,size(Y));
       Y = (Y./abs(Y)).*Rank;
       Cm = sum(real(Y),2)/N;
       Sm = sum(imag(Y),2)/N;
       ord(M,N) = (sum(Cm.*Cm + Sm.*Sm))/(N);
   end 
end 

for ii = 1:size(parametros,1)

    %parametros 
    Mmin = parametros(ii,1);
    Mstep = parametros(ii,2);
    Mmax = parametros(ii,3);
    %NDC = parametros(ii,4);
    NDC = 1;
    alfa = 0.05;
    L = lim(ii,:);
    % protocolo
    if ii == 1
        MM = [24:4:72 78:6:144 152:8:240];
    else
        MM = [80:4:120 126:6:168 176:8:240];
    end

    for ll = 1:size(ord,1) 
        
        [dr(ll,ii),time(ll,ii)] = ETS_2013(ord(ll,:)',MM',alfa,NDC, L);
    end
    
end
    






