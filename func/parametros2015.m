%%
%Geral três aplicações
p = 1;
v = 2:2:234;
for mstep = 2:2:118
    for inicio_ultimo_mstep = 240:-(mstep+4):(2+mstep*2+2)
        for po = 1:length(v) % Variar Mmin
            first_ap = v(po);
            num_apl_6 = ceil((inicio_ultimo_mstep-first_ap)/mstep);
            for procura = (num_apl_6-1):-1:1
                if rem(inicio_ultimo_mstep-(first_ap +  procura*mstep),mstep+2)  == 0
                    num_apl_6 = procura;
                    break
                end
            end
            minimo_multiplo = lcm(mstep,mstep+2);
            for jj = 1:length(first_ap:mstep:inicio_ultimo_mstep)
            last_6 = first_ap + (num_apl_6 - (jj-1)*minimo_multiplo/mstep)*mstep; 
            if last_6 <= first_ap | (last_6 > inicio_ultimo_mstep-(mstep+2))
                break
            end
            vetor = [first_ap:mstep:last_6 (last_6+mstep+2):(mstep+2):inicio_ultimo_mstep (inicio_ultimo_mstep+mstep+4):(mstep+4):240];
            parametros_2015_otim(p,:) = [vetor zeros(1,120 - length(vetor))];
            p = p + 1;
            end
        end
    end
end

%%

% Cálculo dos valores críticos com estatégia de 2013
a = 0.05;
for ii = 1:length(parametros_2015_otim)
    if ii == 1 | parametros_2015_otim(ii,1) ~= parametros_2015_otim(ii-1,1)
        stop = find(parametros_2015_otim(ii,:) == 0);
        for jj = 1:(stop(1)-1)    
            MM = parametros_2015_otim(ii,1:jj);
            limiares_2015_otim(ii,jj) = quantile(max(Rm(:,MM),[],2), 1-a);
        end
        
    else
        stop = find(parametros_2015_otim(ii,:) == 0);
        igual = find(parametros_2015_otim(ii,:) ~= parametros_2015_otim(ii-1,:));
        limiares_2015_otim(ii,1:(igual(1)-1)) = limiares_2015_otim(ii-1,1:(igual(1)-1));
        for jj = igual(1):(stop(1)-1)
            MM = parametros_2015_otim(ii,1:jj);
            limiares_2015_otim(ii,jj) = quantile(max(Rm(:,MM),[],2), 1-a);
        end
    end 
    ii
end

%%

% Cálculo dos valores críticos SEM 2013
parametros_2015_otim_no2013 = parametros_2015_otim;
a = 0.05;
for ii = 1:length(parametros_2015_otim)
    MM = parametros_2015_otim_no2013(ii,:);
    stop = find(MM == 0);
    MM = MM(1:stop-1);
    parametros_2015_otim_no2013(ii,121) = quantile(max(Rm(:,MM),[],2), 1-a);
    ii
end















