function [modulated, line_code, carrier] = modulation(modulation_name, bit_stream, Rb, k, amp, freq)
% INPUT:
% modulation_name = can be 'BASK', 'BPSK', 'QPSK'
% bit_stream = string of bits
% Rb = bit rate
% k = samples per bit
% amp = amplitude of the modulated signal
%       scaler for BPSK and QPSK, vector ([max min]) for BASK
% freq = carrier frequency of the modulated signal
% OUTPUT:
% modulated = modulated signal of the bit stream
% line_code = line-coded signal before modulation
% carrier = carrier signal

modulated = [];
carrier = [];

% converting string to vector
N = length(bit_stream);

% line coding
line_code = repelem(bit_stream, k);

Tb = 1/Rb; % bit duration
Fs = k * Rb; % sampling frequency
Ts = 1 / Fs;
time = 0 : Ts : N*Tb-Ts;

switch modulation_name
    case 'BASK'
        carrier = sin(2*pi*freq*time);
        a1 = amp(1);
        a0 = amp(2);
        line_code = a1 * line_code + a0 .* (line_code==0);
        modulated = line_code .* carrier;
    case 'BPSK'
        a = amp(1);
        carrier = sin(2*pi*freq*time);
        line_code = a .* (line_code == 1) + (-a) .* (line_code == 0);
        modulated = line_code .* carrier;
        
    case 'QPSK'
        M = 4;
        bn = log2(M);
        t = 0 : Ts : bn*Tb-Ts;
        carrier = sin(2*pi*freq*t);
        
        % Gray code generation
        gray_code = zeros(M, bn);
        gray_code(:, 1) = bitget(0:M-1, 1)';
        for i = 2:bn
            gray_code(:, i) = bitxor(gray_code(:, i-1), bitget(0:M-1, i)');
        end
        
        % Calculate the number of symbols
        num_symbols = length(bit_stream) / bn;
        
        % Preallocate modulated array
        modulated = zeros(1, num_symbols * length(t));
        
        % Modulate each symbol
        for i = 1:bn:length(bit_stream)
            sym = bit_stream(i:i+bn-1);
            index = find(ismember(gray_code, sym, 'rows'), 1);
            val = bi2de(gray_code(index, :));
            phi = 2 * pi * val / M;
            
            % Calculate the start and end indexes for the current symbol in the modulated array
            start_idx = (i - 1) / bn * length(t) + 1;
            end_idx = start_idx + length(t) - 1;
            
            % Assign the modulated signal for the current symbol to the corresponding portion of the modulated array
            modulated(start_idx:end_idx) = amp(1) * sin(2*pi*freq*t + phi);
        end
        
        % Upsample line_code to match the length of modulated signal
        line_code = repelem(line_code, length(t));
        
        % Plot the QPSK constellation diagram
        % figure;
        % phi_vals = 2 * pi * (0:M-1) / M;
        % x = cos(phi_vals);
        % y = sin(phi_vals);
        % compass(x, y, 'r');  % 使用紅色繪製相位點
        % hold on;
        % plot(x, y, 'ro', 'MarkerFaceColor', 'r');  % 在相位點上繪製紅色圓圈
        % title('QPSK Constellation Diagram');
        % xlabel('In-phase');
        % ylabel('Quadrature  ');
        
        
        % Upsample line_code to match the length of modulated signal
        line_code = repelem(line_code, length(t));
    otherwise
        fprintf('\n');
        warning(['"', modulation_name, '" Modulation is not supported! ONLY BASK, BPSK, QPSK are supported.']);
        return;
end

% % Plot the signals
% figure;
% subplot(3,1,1);
% plot(line_code);
% title('Line-Coded Signal (Line Code(channel coded signal))', 'Interpreter', 'latex');
% xlabel('Samples');
% ylabel('Amplitude');

% subplot(3,1,2);
% plot(carrier);
% title('Carrier Signal $c(t)$', 'Interpreter', 'latex');
% xlabel('Samples');
% ylabel('Amplitude');

% subplot(3,1,3);
% plot(modulated);
% title('Modulated Signal $s(t)$', 'Interpreter', 'latex');
% xlabel('Samples');
% ylabel('Amplitude');

% % Plot the power spectrum for each modulation scheme
% figure;
% subplot(3,1,1);
% plot_power_spectrum(modulated, Fs, 'BASK');
% title('Power Spectrum of BASK Modulated Signal');

% subplot(3,1,2);
% plot_power_spectrum(modulated, Fs, 'BPSK');
% title('Power Spectrum of BPSK Modulated Signal');

% subplot(3,1,3);
% plot_power_spectrum(modulated, Fs, 'QPSK');
% title('Power Spectrum of QPSK Modulated Signal');





end