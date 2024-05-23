% 生成時間軸
t = linspace(0, 1, 1000);

% 生成高頻率、中頻率和低頻率的正弦波
high_freq = sin(2 * pi * 50 * t);
mid_freq = sin(2 * pi * 10 * t);
low_freq = sin(2 * pi * 1 * t);

% 繪製波形圖
figure;
subplot(4, 1, 1);
plot(t, high_freq);
title('高頻率訊號');

subplot(4, 1, 2);
plot(t, mid_freq);
title('中頻率訊號');

subplot(4, 1, 3);
plot(t, low_freq);
title('低頻率訊號');

subplot(4, 1, 4);
plot(t, DataProcess(high_freq));
title('低頻率訊號');
