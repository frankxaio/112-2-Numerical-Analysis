clc;
clear;

load("QRS.mat");

% goldindex100_expand = ExpandArray(Goldindex100);
% goldindex102_expand = ExpandArray(Goldindex102);

ecg_filtered = DataProcess(ecg100);

% % 顯示原始訊號
% figure;
% subplot(2,1,1);
% plot(ecg100);
% title('原始心電圖訊號');
% xlabel('Sample');
% ylabel('Amplitude');
% 
% % 顯示處理後訊號
% subplot(2,1,2);
% plot(ecg_filtered);
% title('處理後心電圖訊號');
% xlabel('Sample');
% ylabel('Amplitude');







