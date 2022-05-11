% GMSK PSD
pi = 3.141592;
sqrpi = pi^2;
MSK = [];
xaxis = [];
for i=1:1000
f = i/100;
% f is frequency normalized to to 1/(bit duration)
xaxis = [xaxis, f ];
ymsk = 16/sqrpi * (cos(6.2832 * f))^2/ (1- 16 * f^2)^2;
MSK = [MSK, 10 * log10(ymsk)];
end
plot(xaxis,MSK, 'r-');
axis([0 10 -60 10]);
ylabel('Spectral Power Level in dB');
xlabel('Frequency Offset / Bit Rate');
