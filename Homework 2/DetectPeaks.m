function r_peak_indices = DetectPeaks(ecg_signal, fs)

% 選擇小波基函數和分解尺度
wavelet_name = 'sym4'; % 使用 Symlets 4 小波基函數
decomposition_level = 5; % 分解尺度為 5

% 對 ECG 訊號進行小波分解
[coefficients, levels] = wavedec(ecg_signal, decomposition_level, wavelet_name);

% 重構對應於 QRS 複合波尺度的小波係數
qrs_scale = 3; % 假設 QRS 複合波主要能量集中在第 3 尺度
reconstructed_coefficients = wrcoef('d', coefficients, levels, wavelet_name, qrs_scale);

% 對重構的小波係數進行平方運算
squared_coefficients = reconstructed_coefficients.^2;

% 使用移動平均濾波器平滑訊號
window_size = round(0.03 * fs); % 調整窗口大小為 0.15 秒
smoothed_signal = movmean(squared_coefficients, window_size);

% 找出候選的 R 波峰值
threshold = max(smoothed_signal) * 0.01; % 調整幅值閾值為最大值的 20%
min_peak_distance = round(0.8 * fs); % 設定最小峰值間距為 0.3 秒
[~, candidate_peaks] = findpeaks(smoothed_signal, 'MinPeakHeight', threshold, 'MinPeakDistance', min_peak_distance);

% 對找到的候選 R 波峰值進行後處理，也就是檢查是否為真正的最大值 R-peak
r_peak_indices = PostProcessPeaks(ecg_signal, candidate_peaks, fs);
% r_peak_indices = candidate_peaks;

% 檢查是否有漏抓的 R 波峰值
missed_peaks = FindMissedPeaks(ecg_signal, r_peak_indices, fs);
r_peak_indices = sort([r_peak_indices; missed_peaks]);

end

function processed_peaks = PostProcessPeaks(ecg_signal, candidate_peaks, fs)
    % 設定搜索範圍為候選 R 波峰值前後的 0.1 秒
    search_window = round(0.9 * fs);

    % 在原始 ECG 訊號中搜索真正的 R 波峰值
    processed_peaks = zeros(size(candidate_peaks));
    for i = 1:length(candidate_peaks)
        start_idx = max(1, candidate_peaks(i) - search_window);
        end_idx = min(length(ecg_signal), candidate_peaks(i) + search_window);
        [~, peak_idx] = max(ecg_signal(start_idx:end_idx));
        processed_peaks(i) = peak_idx + start_idx - 1;
    end
end

function missed_peaks = FindMissedPeaks(ecg_signal, r_peak_indices, fs)
    % 設定最小 R-R 間期為 0.4 秒
    min_rr_interval = round(0.01 * fs);

    % 找出漏抓的 R 波峰值
    missed_peaks = [];
    for i = 1:length(r_peak_indices)-1
        rr_interval = r_peak_indices(i+1) - r_peak_indices(i);
        if rr_interval > min_rr_interval
            start_idx = r_peak_indices(i);
            end_idx = r_peak_indices(i+1);
            [peak_val, peak_idx] = max(ecg_signal(start_idx:end_idx));
            if peak_val > 0.05 * (ecg_signal(r_peak_indices(i)) + ecg_signal(r_peak_indices(i+1)))
                missed_peaks = [missed_peaks; peak_idx + start_idx - 1];
            end
        end
    end
end



