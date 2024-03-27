function [approximation, details] = ECGWavlet(ecg_filtered)

% 假設 ecg_filtered 是預處理後的心電圖信號

% 選擇小波基函數和分解級別
wavelet_name = 'db4'; % 使用 Daubechies 4 小波基函數
level = 5; % 設置分解級別

% 進行小波變換
[C, L] = wavedec(ecg_filtered, level, wavelet_name);

% 獲取逼近係數和細節係數
approximation = appcoef(C, L, wavelet_name);
details = detcoef(C, L, level);

% 顯示原始信號和小波分解結果
% figure;
% subplot(6,1,1);
% plot(ecg_filtered);
% title('原始心電圖信號');
% xlabel('採樣點');
% ylabel('幅值');

% plot(details)


% for i = 1:level
%     subplot(6,1,i+1);
%     plot(details{i});
%     title(['細節係數 D', num2str(i)]);
%     xlabel('採樣點');
%     ylabel('幅值');
% end

% subplot(6,1,level+2);
% plot(approximation);
% title('逼近係數 A');
% xlabel('採樣點');
% ylabel('幅值');

end
