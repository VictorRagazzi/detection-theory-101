%função da estratégia para testes sequenciais 
function [dr,time] = ETS(ord,MM,alfa,NDC,L)

%parametros: 
% MM = Mmin:Mstep:Mmax; %parametros aonde vai aplicar o teste


%% 

NDC = ceil(NDC);
if size(MM,2)>1
    MM = MM';
end

if size(ord,2)>1
    ord = ord';
end


%VALOR CRÍTICO - MUDA PARA CADA DETECTOR--------
%valor_critico = VC_MSC(MM,alfa);  
%valor_critico = L;
valor_critico = 1.000867997394554;
det = ord(MM)>=valor_critico; 
%-----------------------------------------------------

%avaliar se atende o NDC 
cont = 0; 
dr =0; 
for ii = 1:size(MM,1) 
   
    cont = det(ii)+cont*det(ii); %conta o número de detecções consecutivas 
    
    if cont == NDC
        dr = 1;
        time = MM(ii);
        break
    end
end

if dr == 0 
    time = MM(ii);
end

 