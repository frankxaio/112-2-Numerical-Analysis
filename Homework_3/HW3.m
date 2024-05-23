% arctan_series_with_errors_plot(pi/23, 100)
% arctan_series_with_errors_plot(pi/7, 100)
% arctan_series_with_errors_plot(pi/13, 100)
% arctan_series_with_total_errors_plot(pi/13, 100)

%% mac : maclaurin series 
% true_value = atan(x);
% mac = arctan_series(x, n);
% mac_sum = zeros(1, n);
% for i = 1:n
%     mac_sum(i) = sum(mac(1:i));
% end

%% et

% et = nan(1, n);
% for i = 1:n
%     et(i) = abs( (true_value - mac_sum(i))/ true_value ) * 100;
%     if et(i) < 0.0001
%         nanindex = i; 
%         break;
%     end
% end

%% ea

% ea = nan(1, nanindex-1);
% for i = 2:nanindex
%     if nanindex == 1
%         break;
%     end
%     ea(i-1) = abs(mac_sum(i) - mac_sum(i-1)) / mac_sum(i) * 100;

% end


%% Plot 

x = pi/23;
n = 100;
[et, ea, nanindex] = etea(x, n);
term_et = 1:nanindex;
subplot(3, 2, 1);
loglog(term_et(1:nanindex), et(1:nanindex), 'b-o');
xlabel('項次');
ylabel('真實相對誤差 (%)');
title('\pi/23 項次 vs. 真實相對誤差');
grid on;

term_ea = 1:nanindex;
subplot(3, 2, 2);
loglog(term_ea(1:nanindex-1), ea(1:nanindex-1), 'r-o');
xlabel('項次');
ylabel('近似相對誤差 (%)');
title('\pi/23項次 vs. 近似相對誤差');
grid on;

x = pi/7;
n = 100;
[et, ea, nanindex] = etea(x, n);

term_et = 1:nanindex;
subplot(3, 2, 3);
loglog(term_et(1:nanindex), et(1:nanindex), 'b-o');
xlabel('項次');
ylabel('真實相對誤差 (%)');
title('\pi/7項次 vs. 真實相對誤差');
grid on;

term_ea = 1:nanindex;
subplot(3, 2, 4);
loglog(term_ea(1:nanindex-1), ea(1:nanindex-1), 'r-o');
xlabel('項次');
ylabel('近似相對誤差 (%)');
title('\pi/7項次 vs. 近似相對誤差');
grid on;

x = pi/13;
n = 100;
[et, ea, nanindex] = etea(x, n);
term_et = 1:nanindex;
subplot(3, 2, 5);
loglog(term_et(1:nanindex), et(1:nanindex), 'b-o');
xlabel('項次');
ylabel('真實相對誤差 (%)');
title('\pi/13項次 vs. 真實相對誤差');
grid on;

term_ea = 1:nanindex;
subplot(3, 2, 6);
loglog(term_ea(1:nanindex-1), ea(1:nanindex-1), 'r-o');
xlabel('項次');
ylabel('近似相對誤差 (%)');
title('\pi/7項次 vs. 近似相對誤差');
grid on;

%% perspective 1 

% 定義要展開的函數
syms x;
f = atan(x);

% 設定展開點和截斷階數
x0 = 0;
n = 5;

% 計算泰勒級數展開式
arctan_series_sym = arctan_series_symbolic(x0, n);

% 定義評估點
x_eval = 1;

% 設定步長範圍
h_values = logspace(-5, 0, 100);

% 初始化截斷誤差向量
truncation_errors = zeros(size(h_values));

% 計算不同步長下的截斷誤差
for i = 1:length(h_values)
    h = h_values(i);
    xi = x0 + h;
    true_value = subs(f, x, xi);
    approx_value = subs(arctan_series_sym, x, xi);
    truncation_errors(i) = abs(true_value - approx_value);
end

% 繪製截斷誤差與步長的關係圖
figure;
loglog(h_values, truncation_errors, '-o');
xlabel('Step size (h)');
ylabel('Total error');
title('Perspective 1');
grid on;

%% perspective 2 
x2 = pi/7
truncation_errors_2 = [];
n = 100;
mac = arctan_series(x2, n);
mac_sum = zeros(1, n);
for i = 1:n
    mac_sum(i) = sum(mac(1:i));
    truncation_errors_2(i) = abs(atan(x2) - mac_sum(i));
end

term_x = [1:n];
figure;
semilogy(term_x, truncation_errors_2, '-o');
xlabel('n 階數');
ylabel('Total Error ');
title('Perspective 2');
grid on;