%% Testando q-sample %%
% Teste sequencial
clc, clear all
Mmax = 180;    % Número de janelas
Mmin = 20;  % Número mínimo de janelas para realizar o primeiro teste
Mstep = 2;  % Quantidade de janelas a ser acrescentada para realizar outro teste
MM = Mmin:Mstep:Mmax;  % Quantidades de janelas que ocorrerão os testes
QT = length(MM);    % Quantidade de testes
a = 0.05;   % Nível de significância
nRuns = 5000;
Rm = zeros(nRuns,QT);
t = tic();
%L = 1000;
q = 3;
parfor k = 1:nRuns
    % Modified Rayleigh Test
    YY = randn(q,Mmax) + 1j*randn(q,Mmax);       % Simulando as componenetes espectrais de cada janela na frequência de interesse.
    for j = 1:QT
        Y = YY(:,1:MM(j));
        [~,Rank] = sort(Y(:),'ComparisonMethod','abs');
        [~,Rank] = sort(Rank);
        Rank = reshape(Rank,size(Y));
        %thetas = angle(Y);
        %[~,RankAng] = sort(thetas(:),'ComparisonMethod','abs');
        %[~,RankAng] = sort(RankAng);
        %RankAng = reshape(RankAng,size(Y));
        %RankAng = RankAng*2*pi/(MM(j)*q);
        Y = (Y./abs(Y)).*Rank;
        Cm = sum(real(Y),2)/MM(j);
        Sm = sum(imag(Y),2)/MM(j);
        %Cm = sum(Rank.*cos(RankAng),2)/MM(j);
        %Sm = sum(Rank.*sin(RankAng),2)/MM(j);
        %Cm = sum(abs(Y).*cos(RankAng),2)/MM(j);
        %Sm = sum(abs(Y).*sin(RankAng),2)/MM(j);
        %Cm = sum(abs(Y).*cos(angle(Y)),2)/MM(j);
        %Sm = sum(abs(Y).*sin(angle(Y)),2)/MM(j);
        
        Rm(k,j) = sum((Cm.^2 + Sm.^2))/(MM(j));
        
    end
end
%Rm = 8*Rm/(q*q*(q+1)*(q+1));

for ii = 1:QT
    l(ii) = quantile(max(Rm(:,1:ii),[],2),1-a);
end
ray = Rm;
plot(l*17.3/19)
disp(toc(t))
beep()
%%
% Replica 2005%
a = 0.05;
Mmax = 240;
parametros2005 = [10     1   240    %Regra de 3%
    60     2   240
    150     1   240    %Regra de 3%
    60     2   240
   225     1   240
   210     2   240
   195     3   240
   180     4   240
   165     5   240
   150     6   240
   135     7   240
   120     8   240
   105     9   240
    90    10   240
    75    11   240
    60    12   240
    45    13   240
    30    14   240
    15    15   240
    240    1   240]

for ii = 1:length(parametros2005)
    Mmin = parametros2005(ii,1);
    Mstep = parametros2005(ii,2);
    MM = Mmin:Mstep:Mmax;
    parametros2005(ii,4)= quantile(max(ray(:,MM),[],2), 1-a);
        %p = quantile(max(Rm(:,MM(1:apl)),[],2), 1-a)
end

%%
%Otimizacao 2005
Mmax = 240;
a = 0.05;
parametros2005otim = parametros(:,1:3);
for ii = 1:length(parametros2005otim)
    Mmin = parametros2005otim(ii,1);
    Mstep = parametros2005otim(ii,2);
    MM = Mmin:Mstep:Mmax;
    parametros2005otim(ii,4)= quantile(max(ray(:,MM),[],2), 1-a);
end

%%
% Replica 2006
% Gerar limiares para parametros 2006%
a = 0.05;
Mmax = 240;
parametros2006 = [10     1   240  %Regra de 3%
    60     2   240
    150     1   240
   225     1   240
   210     2   240
   195     3   240
   180     4   240
   165     5   240
   150     6   240
   135     7   240
   120     8   240
   105     9   240
    90    10   240
    75    11   240
    60    12   240
    45    13   240
    30    14   240
    15    15   240
    240    1   240];

for ii = 1:length(parametros2006)
    Mmin = parametros2006(ii,1);
    Mstep = parametros2006(ii,2);
    MM = Mmin:Mstep:Mmax;
    parametros2006(ii,4)= quantile(max(Rm(:,MM),[],2), 1-a);
        %p = quantile(max(Rm(:,MM(1:apl)),[],2), 1-a)
end
%%
% Replica 2013
% Obter limiares 2013 %
Mmax = 240;
a = 0.05;
parametros2013 = [20  2 240]; %Regra de 3%
    26  2 240
    80  2 240
    240 1 240];
for ii = 1:size(parametros2013,1)
    Mmin = parametros2013(ii,1);
    Mstep = parametros2013(ii,2);
    MM = Mmin:Mstep:Mmax;
    for apl = 1:length(MM)
        limiares2013(ii,apl)= quantile(max(Rm(:,MM(1:apl)),[],2), 1-a);
        %p = quantile(max(Rm(:,MM(1:apl)),[],2), 1-a)
    end
end


%%
% Obter os limiares do método 2015 %
a = 0.05;

%Mmin = 24;
%Mmax = 24;
%Mstep = 4;
%inter = 1:13;
%MM = Mmin:Mstep:Mmax;


%Mmin = 72;
%Mstep = 6;
%Mmax = 72;
%inter = 14:25;
%MM = [24:4:72 Mmin:Mstep:Mmax];

Mmin = 144;
Mstep = 8;
Mmax = 144;
inter = 26:37;
%MM = [24:4:72 78:6:144 Mmin:Mstep:Mmax];

for ii = inter
    MM = [24:4:72 78:6:144 Mmin:Mstep:Mmax];
    limiares2015(1,ii) = quantile(max(Rm(:,MM),[],2), 1-a);
    Mmax = Mmax + Mstep;
end

parametros2015(1,:) = [24 4 240];

%%
% 2015 pt 2

a = 0.05;

%Mmin = 80;
%Mmax = 80;
%Mstep = 4;
%inter = 1:11;
%MM = Mmin:Mstep:Mmax;


%Mmin = 126;
%Mstep = 6;
%Mmax = 126;
%inter = 12:20;
%MM = [80:4:120 Mmin:Mstep:Mmax];

Mmin = 176;
Mstep = 8;
Mmax = 176;
inter = 21:28;
%MM = [80:4:120 126:6:168 Mmin:Mstep:Mmax];

for ii = inter
    MM = [80:4:120 126:6:168 Mmin:Mstep:Mmax];
    limiares2015(1,ii) = quantile(max(Rm(:,MM),[],2), 1-a);
    Mmax = Mmax + Mstep;
end

parametros2015(1,:) = [80 4 240];


%%
% Réplica 2015 sem 2013

a = 0.05;
parametros2015M(1,:) = [24:4:72 78:6:144 152:8:240 0];
parametros2015M(1,:) = [80:4:120 126:6:168 176:8:240 zeros(1,10)];
parametros2015M(1,39) = quantile(max(Rm(:,parametros2015M(1,1:37)),[],2), 1-a);
parametros2015M(1,39) = quantile(max(Rm(:,parametros2015M(1,1:28)),[],2), 1-a);







