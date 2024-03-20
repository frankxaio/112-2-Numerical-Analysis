function r_peak_indices = DetectPeaks(ecg_signal, fs)
    % 選擇小波基函數和分解尺度
    wavelet_name = 'db4';  % 使用 Daubechies 4 小波基函數
    decomposition_level = 5;  % 分解尺度為 5
    
    % 對 ECG 訊號進行小波分解
    [coefficients, levels] = wavedec(ecg_signal, decomposition_level, wavelet_name);
    
    % 重構對應於 QRS 複合波尺度的小波係數
    qrs_scale = 3;  % 假設 QRS 複合波主要能量集中在第 3 尺度
    reconstructed_coefficients = wrcoef('d', coefficients, levels, wavelet_name, qrs_scale);
    
    % 對重構的小波係數進行平方運算
    squared_coefficients = reconstructed_coefficients.^2;
    
    % 使用移動平均濾波器平滑訊號
    window_size = round(0.01 * fs);
    smoothed_signal = movmean(squared_coefficients, window_size);
    
    % 找出 R 波峰值
    threshold = max(smoothed_signal) * 0.015;  % 設定幅值閾值
    [~, r_peak_indices] = findpeaks(smoothed_signal, 'MinPeakHeight', threshold, 'MinPeakDistance', fs);

    % figure
    % plot(ecg_signal);
    % hold on;
    % % plot(reconstructed_coefficients);
    % plot(smoothed_signal);
    % xlabel('Samples');
    % ylabel('Amplitude');
    % legend('ECG', 'Squared')
    % title('ECG Signal with Detected R Peaks');
    % hold off;
end