clc;
clear all;
close all;
DRate=1; %data rate or 1 bit in one second
M=18; %no of smples per bit
N=36; %no of bits for simulation [-18:18]
BT=0.5;%Bandwidth*period (cannot change)
T=1/DRate; %data period ,i.e 1 bit in one second
Ts=T/M;
k=[-18:18]; %Chens value more than needed;%only introduces a little more delay
%*******************************************************************************
%********************************************************************************
%COSTRUCTION OF GAUSSIAN FILTER FOLLOWED BY SHAPING OF DATA BITS USING
%GAUSSIAN FILTER
alpha=sqrt(log(2))/(2*pi*BT);
h=exp(-(k*Ts).^2/(2*alpha^2*T^2))/(sqrt(2*pi)*alpha*T);  %Gaussian filter response in time domain
figure(1);
plot(h,'*r')
title('Response of Gaussian filter');
xlabel('Sample at Ts');
ylabel('Normalized Magnitude');
ipbit=[1 1 0 0 0 1 1 1];
m=filter(h,1,ipbit);
m_sig=[];
fc=1
fs=10^3;
w=2*pi*fc;
T=1
%%Weighting function generator
t=-1:1/fs:7; %advanced inphase %length is 8fs+1
t1=0:1/fs:8; %quadrature %length is 8fs+1
cos_w=cos(2*pi*t/2);%Inphase
sin_w=sin(2*pi*t1/2); %quadrature
ai=ipbit(1:2:end);
aq=ipbit(2:2:end);
m1=filter(h,1,ai);
m2=filter(h,1,aq);
ai_c=[];
aq_s=[];
ai_c=kron(m1(1:2:end),ones(1,4000));
aq_s=kron(m2(2:2:end),ones(1,4000));
ai_c=[ai_c zeros(1,1)]; %to make length=8fs+1
aq_s=[zeros(1,1) aq_s];%to make length=8fs+1
aii=ai_c.*cos_w;
aqq=aq_s.*sin_w;
i=aii.*cos(w*t);
q=aqq.*sin(w*t);
m_sig=i+q;
figure(2)
subplot(2,1,1)
plot(i);
subplot(2,1,2)
plot(q);
figure(3)
subplot(2,2,1)
plot(m_sig);

