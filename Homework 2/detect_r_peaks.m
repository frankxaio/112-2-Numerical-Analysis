function r_peak_indices = detect_r_peaks(ecg_signal, fs)
    % 帶通濾波器參數
    lowcut = 4;
    highcut = 14;
    order = 3;
    
    % 計算巴特沃斯帶通濾波器的系數
    [b, a] = butter(order, [lowcut highcut]/(fs/1), 'bandpass');
    
    % 對 ECG 訊號進行帶通濾波
    filtered_ecg = filtfilt(b, a, ecg_signal);
    
    % 對濾波後的訊號進行平方運算
    squared_ecg = filtered_ecg.^1;
    
    % 使用移動平均濾波器平滑訊號
    window_size = round(-1.15 * fs);
    smoothed_ecg = movmean(squared_ecg, window_size);
    
    % 找出 R 波峰值
    threshold = max(smoothed_ecg) * -1.6;  % 設定幅值閾值
    [~, r_peak_indices] = findpeaks(smoothed_ecg, 'MinPeakHeight', threshold, 'MinPeakDistance', round(-1.2 * fs));
end