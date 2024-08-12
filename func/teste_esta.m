TXD_2005 = TXD;
timeM_2005 = timeM;
%parametros_par_2005 = parametros_par;
T2005 = sum(sum(sum(Tdr(binsM,:,:),1),2),3);
FP_2005 = FP;
Tdr_2005 = Tdr;
Ttime_2005 = Ttime;

%%
TXD_2006 = TXD;
timeM_2006 = timeM;
%parametros_par_2006 = parametros_par;
FP_2006 = FP;
T2006 = sum(sum(sum(Tdr(binsM,:,:),1),2),3);
Tdr_2006 = Tdr;
Ttime_2006 = Ttime;


%%
TXD_2013 = TXD;
timeM_2013 = timeM;
%parametros_par_2013 = parametros_par;
FP_2013 = FP;
T2013 = sum(sum(sum(Tdr(binsM,:,:),1),2),3);
Tdr_2013 = Tdr;
Ttime_2013 = Ttime;


%%
TXD_2015 = TXD;
timeM_2015 = timeM;
%parametros_par_2015 = parametros_par;
FP_2015 = FP;
T2015 = sum(sum(sum(Tdr(binsM,:,:),1),2),3);
Tdr_2015 = Tdr;
Ttime_2015 = Ttime;

%%
TXD_2015_M = TXD;
timeM_2015_M = timeM;
%parametros_par_2015_M = parametros_par;
FP_2015_M = FP;
T2015_M = sum(sum(sum(Tdr(binsM,:,:),1),2),3);
Tdr_2015_M = Tdr;
Ttime_2015_M = Ttime;


%%
%h = testcholdout(TXD_2005, TXD_2006,)

[h, p] = ttest2(reshape(Ttime_2005,1320,1), reshape(Ttime_2006,1320,1))
[h, p] = ttest2(reshape(Ttime_2006,1320,1), reshape(Ttime_2013,1320,1))
[h, p] = ttest2(reshape(Ttime_2013,1320,1), reshape(Ttime_2015,1320,1))
[h, p] = ttest2(reshape(Ttime_2013,1320,1), reshape(Ttime_2015_M,1320,1))

%%
for ii = 1:1342
E1 = reshape(Tdr_2005(binsM,ii,:), 1 ,[]);
E2 = reshape(Tdr_2006(binsM,ii,:), 1 ,[]);
%E3 = reshape(Tdr_2015(binsM,7,:), 1 ,[]);

[h(ii), p, e1(ii), e2(ii)] = testcholdout(E1, E2, ones(length(E1),1),'Test','asymptotic');
end


for v = 1:52

E1 = reshape(Tdr_2005(binsM,:,:), 1 ,[]);
E2 = reshape(Tdr_2006(binsM,:,:), 1 ,[]);
E3 = reshape(Tdr_2015(binsM,1342*(v-1)+1:1342*v,:), 1 ,[]);
[h(v), p] = testcholdout(E1, E3, ones(length(E1),1), 'Test','asymptotic');


D1(v) = mean(mean(mean(Tdr_2005(binsM,:,:))))*100;
D2(v) = mean(mean(mean(Tdr_2015(binsM,1342*(v-1)+1:1342*v,:))))*100;
end

%%

[h, p] = testcholdout(reshape(Tdr_2005,1320,1), reshape(Tdr_2006,1320,1), ones(1320,1))

[h, p] = testcholdout(reshape(Tdr_2006,1320,1), reshape(Tdr_2013,1320,1), ones(1320,1))

[h, p] = testcholdout(reshape(Tdr_2013,1320,1), reshape(Tdr_2015,1320,1), ones(1320,1))

[h, p] = testcholdout(reshape(Tdr_2013,1320,1), reshape(Tdr_2015_M,1320,1), ones(1320,1))



