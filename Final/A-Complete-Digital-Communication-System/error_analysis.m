clc; clear; close all;
% 設定參數
modulation_names = {'BASK', 'BPSK', 'QPSK'};
samples_per_bit = 40;
Rb = 1000;
amp = [1 0];
freq = 1000;
snr_values = -40:1:5;
Generator = [1 1 1; 1 0 1];
shift = 1;
file_path = 'Data/source_data_error.txt';

% 初始化結果矩陣
num_snr = length(snr_values);
results = zeros(length(modulation_names), num_snr);
times = zeros(length(modulation_names), num_snr);

% 測試不同調製方法和 SNR 值
parfor i = 1:length(modulation_names)
    modulation_name = modulation_names{i};
    for j = 1:num_snr
        snr = snr_values(j);
        [total_time, BER] = communication_system(modulation_name, samples_per_bit, Rb, amp, freq, snr, Generator, shift, file_path);
        results(i, j) = BER;
        times(i, j) = total_time;
    end
end

% 繪製 BER 與 SNR 的關係圖
figure;
plot(snr_values, results(1,:), 'r', 'LineWidth', 1.5);
hold on;
plot(snr_values, results(2,:), 'g', 'LineWidth', 1.5);
plot(snr_values, results(3,:), 'b', 'LineWidth', 1.5);
grid on;
xlabel('SNR (dB)');
ylabel('BER');
title('BER vs. SNR for Different Modulation Schemes');
legend('BASK', 'BPSK', 'QPSK');

% 繪製執行時間與 SNR 的關係圖
figure;
plot(snr_values, times(1,:), 'r', 'LineWidth', 1.5);
hold on;
plot(snr_values, times(2,:), 'g', 'LineWidth', 1.5);
plot(snr_values, times(3,:), 'b', 'LineWidth', 1.5);
grid on;
xlabel('SNR (dB)');
ylabel('Execution Time (seconds)');
title('Execution Time vs. SNR for Different Modulation Schemes');
legend('BASK', 'BPSK', 'QPSK');