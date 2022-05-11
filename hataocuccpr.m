%Matlab code to simulate Hata-Okumura Models
clc;
clear all;
%-----------Input section-----------
Hbts=50 ; %Height measured from the base of the BTS tower to the radiation centerline
Tbts=350; %Terrain elevation at the location of the BTS
Htav=300; %Height of the average terrain (from 3 km to 15 km distance from the BTS)
Hm=3;%Height of the mobile antenna in meters
f=900;%100:100:3000;%Range of frequencies in MHz
d=0.5:0.5:15;%Range of Tx-Rx separation distance in Kilometers
Pt=0.020;%Power transmitted by the BTS antenna in watts
Gt=10;%BTS antenna gain in dBi
%-------------------------------------------------------------------------------------------
Hb=Hbts+Tbts-Htav;%Effective Height of the BTS antenna in meters
%Cell array to store various model names
models={'Big City(Urban model)';'Small & Medium City (Urban model)';'Sub-urban environment';'Open Rural environment'};
display('Hata-Okumura Model');
display(['1' models{1,1}]);
display(['2' models{2,1}]);
display(['3' models{3,1}]);
display(['4' models{4,1}]);
replay=input('Select Your Choice of environment:','S');
if 0<str2num(replay)<4
    modelName=models{str2num(replay),1};
    display(['Chosen Model:''modelName']);
else
    error('Invalid Selection');
end
switch replay
    case '1',
        C=0;
        if f<=200
            aHm=8.29*(log10(1.54*Hm))^2-1.1;
        else
            aHm=3.2*(log10(11.75*Hm))^2-4.97;
        end
    case '2',
        C=0;
        aHm=(1.1*log10(f)-0.7)*Hm-(1.56*log10(f)-0.8);
    case '3',
        aHm=(1.1*log10(f)-0.7)*Hm-(1.56*log10(f)-0.8);
        C=-2*(log10(f/28))^2+18.33*log10(f)-40.98;
    otherwise,
        error('Invalid model selection');
end
A=69.55+26.16*log10(f)-13.82*log10(Hb)-aHm;
B=44.9-6.55*log10(Hb);
PL=A+B*log10(d)+C;
subplot(2,1,1)
plot(d,PL,'r','LineWidth',2);
title(['Hata-Okumura Path Loss Model for:''modelName']);
xlabel('Distance-Kilometers');
ylabel('Path Loss(db)');
Pr=10*log10(Pt*1000)+Gt-PL
subplot(2,1,2)
plot(d,Pr,'r','LineWidth',2);
title(['Hata-Okumura Model for :''modelName']);
xlabel('Distance-Kilometers');
ylabel('Received Signal Level (dBm)');
        
        
