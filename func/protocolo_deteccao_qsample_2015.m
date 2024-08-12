function [dr,time] = protocolo_deteccao_qsample_2015(x, parametros,lim)

binsM = 120;
xfft = fft(x);

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

    alfa = 0.05;
    % protocolo
    MM = parametros(ii,:);
    stop = find(MM == 0);
    MM = MM(1:(stop(1)-1));
    
    
    % -------------------------------------------------- %
    %             Com variação de valor crítico          %
    %L = lim(ii,:);
    %stop_lim = find(L == 0);
    %L = L(1:(stop_lim(1)-1));
    %for ll = 1:size(ord,1)  
    %    
    %    [dr(ll,ii),time(ll,ii)] = ETS_2013(ord(ll,:)',MM',alfa,1, L);
    %end
    % -------------------------------------------------- %

    
    % -------------------------------------------------- %
    %             Sem variação de valor crítico          %
    L = lim(ii,:);
    stop_lim = find(L == 0);
    L = L((stop_lim(1)-1));
    for ll = 1:size(ord,1)      
        [dr(ll,ii),time(ll,ii)] = ETS(ord(ll,:)',MM',alfa,1, L);
    end
    
    % -------------------------------------------------- %
    
    
    
end
    
