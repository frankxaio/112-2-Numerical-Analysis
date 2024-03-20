function ecg_filtered = DataProcess(ecg_signal)
  % 去除趨勢上升或下降
  baseline_drift_removed = detrend(ecg_signal);

  % 帶通濾波器去除高頻噪聲
  fs = 360; % 假設採樣頻率为 1000Hz
  fcutlow = 0.3; % 低通截止頻率為 0.5Hz
  fcuthigh = 100; % 高通截止頻率為 100Hz
  order = 4; % 濾波器階數
  [b, a] = butter(order, [fcutlow/(fs/2), fcuthigh/(fs/2)], 'bandpass');
  ecg_filtered = filtfilt(b, a, baseline_drift_removed);


