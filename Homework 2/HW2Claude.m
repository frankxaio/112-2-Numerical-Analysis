% 載入 ECG 訊號和採樣率
clc;
clear;
load('QRS.mat');  % 假設 ECG 訊號資料儲存在名為 'ecg_signal.mat' 的檔案中

%% 100
% 去除噪聲與趨勢漂移
ecg_signal = DataProcess(ecg100);
min_diff = min(abs(diff(Goldindex100)));
r_peak_indices = DetectPeaks(ecg_signal, min_diff);
% 評估檢測結果
[sensitivity100, postive_detection100, detection_error100, test100] = Evaluation(Goldindex100, r_peak_indices, ecg_signal);

fprintf("========================================\n");
fprintf("sensitivity100: %f\n", sensitivity100);
fprintf("positive_detection100: %f\n", postive_detection100);
fprintf("detection_error100: %f\n", detection_error100);
fprintf("test100: %f\n", test100);
fprintf("========================================\n");

%%  繪製結果
figure;
plot(ecg100);
% plot(ecg_signal);
hold on;
plot(r_peak_indices, ecg100(r_peak_indices), 'ro', 'MarkerSize', 10);
xlabel('Samples');
ylabel('Amplitude');
xlim([1,10000]);
title('ECG Signal with Detected R Peaks');

%% 102 
% 去除噪聲與趨勢漂移
ecg_signal = DataProcess(ecg102);
min_diff = min(abs(diff(Goldindex102)));
r_peak_indices = DetectPeaks(ecg_signal, min_diff);
% 評估檢測結果
[sensitivity102, postive_detection102, detection_error102, test102] = Evaluation(Goldindex102, r_peak_indices, ecg_signal);

fprintf("========================================\n");
fprintf("sensitivity102: %f\n", sensitivity102);
fprintf("positive_detection102: %f\n", postive_detection102);
fprintf("detection_error102: %f\n", detection_error102);
fprintf("test102: %f\n", test102);
fprintf("========================================\n");

%% 繪製結果
figure;
plot(ecg102);
% plot(ecg_signal);
hold on;
plot(r_peak_indices, ecg102(r_peak_indices), 'ro', 'MarkerSize', 10);
xlabel('Samples');
ylabel('Amplitude');
title('ECG Signal with Detected R Peaks');