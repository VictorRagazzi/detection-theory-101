%clc, clear all
t = 0:0.001:0.239;
s = (cos(2*pi*1000*t)+cos(2*pi*240*t));
r = 0.5*randn(1,size(t,2));
sinal = s + r;
plot(abs(fft(sinal)))
%xlim([0,0.1])

%%
Y = fft(x(1:120,120));
L = 120;
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Fs = 1000;                    % Sampling frequency
f = Fs/2*linspace(0,1,NFFT/2+1);
plot(2*abs(Y(1:NFFT/2+1)))
%%


a = sum(Tdr([90 92],:,:));




