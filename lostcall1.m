%Data and voice traffic analysis in Lost call System
clc;
clear all;
close all;
N=input('Enter the number of trunks');
A=input('Enter the value of ''A');
kk=1;
%GOS will be used for performance analysis
for n=1:N  %For N trunks we will have N grade of service
    num=power(A,n)/factorial(n);
    den=0;
    for k=0:n
        den=den+power(A,k)/factorial(k);
    end
    final(kk)=num/den;
    kk=kk+1;
end
disp(final);
 n=1:N
    stem(n,final());
    xlabel('Number of trunks');
    ylabel('gos');
    hold on;  %for plotting all values together

plot(n,final);
hold on;