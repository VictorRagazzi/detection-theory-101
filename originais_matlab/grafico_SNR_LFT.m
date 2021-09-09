% C�digo adaptado do material de aula de Thiago Zanotelli
clearvars; close all; clc ;

% numero de simula��es:
NRuns = 1e4; 

%parametros do detector ------------------- 
energia_ruido = 1; 
alpha = 0.05;
f = 100; 
fs = 1000; 
L = 20;
N=1e4;
bin = round(f*N/fs +1);
vetor_SNR =-60:2:-20; %vetor da SNR 


%% 
disp('-')
%obter o limiar 
[~,limiar] = VC_LFT(L,alpha,1);

ords = [];
for jj = 1:size(vetor_SNR,2) %fazer para cada SNR 
    nd = 0;
    SNRi = vetor_SNR(jj);
    A = 1/(10^(SNRi/-20));
    
    for ii = 1:NRuns %fazer por experimento 
        s(:,1) = sin(2*pi*f/fs*[0:(N-1)]);
        x = A*s + energia_ruido*randn(N,1); 
     
        ORD = LFT(x,L,bin);
        ords = [ords,ORD];
        if ORD > limiar
            nd = nd+1;
        end
    end %fim de cada experimento
    
    PD(jj,1) = nd/NRuns;
    disp(nd/NRuns)
    disp(vetor_SNR(jj))
    
end

figure 
lw  =2; 
plot(vetor_SNR,PD,'LineWidth',lw) 
xlabel('SNR','fontsize',12)
ylabel('PD','fontsize',12)
legend({num2str(vN')},'edgecolor','none')
grid on 