clc
clear all
close all
bit_count = 100000; %no. of random bits to be generated for a single shot of BER calculation
SNR = 0: 1: 10; %Range of SNR over which to simulate
for k = 1: 1: length(SNR)
    tote = 0; %total error bits
    totb = 0; %total bits
    while tote < 100 %until you get 100 errors
        rbits  = round(rand(1,bit_count)); %generate random bits
        tx = -2*(rbits-0.5); % BPSK Modulation: Directly to Bipolar NRZ
        N0 = 1/10^(SNR(k)/10); %noise level
        rx = tx + sqrt(N0/2)*(randn(1,length(tx))+i*randn(1,length(tx)));
        rx2 = rx < 0; % BPSK demodulator logic at the Receiver
        diff = rbits - rx2; % Calculate Bit Errors
        tote = tote + sum(abs(diff)); %total errors
        totb = totb + length(rbits); %total bits generated
    end
    BER(k) = tote / totb; % Calculate Bit Error Rate
end
semilogy(SNR,BER,'*r');
hold on;
xlabel('Eb/No (dB)');
ylabel('BER');
title('Eb/No(SNR) Vs BER plot for BPSK Modualtion in AWGN Channel');
thber = 0.5*erfc(sqrt(10.^(SNR/10))); % Theoretical BER
semilogy(SNR,thber);
grid on;
legend('Simulated Curve', 'Theoretical Curve');