function P = parametros_protocolo(Mmax)

%função para obter todos os parâmetros possíveis de um protocolo de
%detecção a partir de um Mmax de entrada 

%entrada: Mmax 

%saída: Matriz P onde: 
        %cada linha indica um parâmetro. 
        %Coluna [ Min, Mstep, Mmax]; 

%%Código ------------------------------------------------

P = []; 
 
for M_step = 1:(Mmax-1)
    for Mmin = 2:(Mmax-1)%MMentrada                 
         k = (Mmax -Mmin)/M_step;
         if (ceil(k) == floor(k) & k>=0) %verificar se o valor de k é um número real    
             P = [P;Mmin,M_step,Mmax];             
         end       
       end
end

%Incluir o teste único também 
P = [P;Mmax 1 Mmax]; 




