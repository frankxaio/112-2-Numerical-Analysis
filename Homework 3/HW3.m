% arctan_series_with_errors_plot(pi/23, 100)
% arctan_series_with_errors_plot(pi/7, 100)
% arctan_series_with_errors_plot(pi/13, 100)
% arctan_series_with_total_errors_plot(pi/13, 100)

% mac : maclaurin series 
x = pi/13;
true_value = atan(x);
n = 100;
mac = arctan_series(x, n);
mac_sum = zeros(1, n);
for i = 1:n
    mac_sum(i) = sum(mac(1:i));
end

%% et

et = nan(1, n);
for i = 1:n
    et(i) = abs( (true_value - mac_sum(i))/ true_value ) * 100;
    if et(i) < 0.0001
        nanindex = i; 
        break;
    end
end

%% ea

ea = nan(1, nanindex-1);
for i = 2:nanindex
    if nanindex == 1
        break;
    end
    ea(i-1) = abs(mac_sum(i) - mac_sum(i-1)) / mac_sum(i) * 100;

end


%% Plot 

term_et = 1:n;
figure;
subplot(1, 2, 1);
loglog(term_et(1:i), et(1:i), 'b-o');
xlabel('項次');
ylabel('真實相對誤差 (%)');
title('項次 vs. 真實相對誤差');
grid on;

term_ea = 1:nanindex;
subplot(1, 2, 2);
loglog(term_ea(1:nanindex-1), ea(1:nanindex-1), 'r-o');
xlabel('項次');
ylabel('近似相對誤差 (%)');
title('項次 vs. 近似相對誤差');
grid on;

%% truncation error 

%% roundoff error 

%% plot 