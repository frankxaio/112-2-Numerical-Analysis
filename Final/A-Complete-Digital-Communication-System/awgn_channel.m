function [received, modulated] = awgn_channel(modulated, snr)
% INPUT:
% modulated: transmitted modulated signal
% snr: value of the signal to noise ratio
% OUTPUT:
% received: noise added modulated signal that appears at the receiver
% modulated: original modulated signal before passing through the channel

% Plot the modulated signal before passing through the AWGN channel
figure;
subplot(2, 1, 1);
plot(real(modulated));
title('Modulated Signal Before AWGN Channel');
xlabel('Samples');
ylabel('Amplitude');

% Pass the modulated signal through the AWGN channel
received = awgn(modulated, snr, 'measured');

% Plot the received signal after passing through the AWGN channel
subplot(2, 1, 2);
plot(real(received));
title('Received Signal After AWGN Channel');
xlabel('Samples');
ylabel('Amplitude');

end