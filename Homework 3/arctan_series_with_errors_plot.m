function arctan_series_with_errors_plot(x, n)
    % 用級數求 arctan(x) 的近似值,計算每次加入新項後的真實和近似相對誤差百分比,並繪製項次與誤差關係圖
    % 輸入: 
    %   x: 要計算的 arctan 值的輸入 
    %   n: 級數的最大項數
    % 輸出:
    %   依次印出每次加入新項後的近似值和相對誤差百分比,並繪製項次與誤差關係圖
    
    true_value = atan(x);
    approx_value = 0;
    true_errors = zeros(1, n+1);
    approx_errors = zeros(1, n+1);
    terms = 1:n+1;
    
    for i = 0:n
        new_term = ((-1)^i * x^(2*i+1)) / (2*i + 1);
        approx_value_last = approx_value;
        approx_value = approx_value + new_term;
        
        true_errors(i+1) = abs((true_value - approx_value) / true_value);
        approx_errors(i+1) = abs((approx_value - approx_value_last) / approx_value);
        
        fprintf('atan(x) = %.6f 項數 = %d, arctan(%.2f) 的近似值: %.6f, 真實相對誤差: %.2f%%, 近似相對誤差: %.2f%%\n', ...
                true_value, i+1, x, approx_value, true_errors(i+1)*100, approx_errors(i+1)*100);
        
        if true_errors(i+1) < 0.000001
            break;
        end
    end
    
    figure;
    subplot(1, 2, 1);
    loglog(terms(1:i+1), true_errors(1:i+1), 'b-o');
    xlabel('項次');
    ylabel('真實相對誤差 (%)');
    title('項次 vs. 真實相對誤差');
    grid on;
    
    subplot(1, 2, 2);
    loglog(terms(2:i+1), approx_errors(2:i+1), 'r-o');
    xlabel('項次');
    ylabel('近似相對誤差 (%)');
    title('項次 vs. 近似相對誤差');
    grid on;
    
end
    