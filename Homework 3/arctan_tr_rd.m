function arctan_tr_rd(x, n)
    % 用級數求 arctan(x) 的近似值,計算每次加入新項後的截斷誤差,舍入誤差和總誤差,並繪製對數步長與誤差關係圖
    % 輸入: 
    %   x: 要計算的 arctan 值的輸入 
    %   n: truncation error 的項數
    % 輸出:
    %   依次印出每次加入新項後的近似值、截斷誤差、舍入誤差和總誤差,並繪製對數步長與誤差關係圖
    
    %% Truncation error
    % 找出被近似的精確函數表達式。
    % 將精確函數利用泰勒級數展開,得到有限多項式近似。
    % 計算剩餘項(remainder term),即被忽略的無窮級數項之和,這就是截斷誤差。
    % 評估截斷誤差在給定點或區間內的上界或下界。

    true_value = atan(x);
    level = 100;
    approx_value = 0;
    truncation_errors = zeros(1, n+1);
    roundoff_errors = zeros(1, n+1);
    terms = 1:n+1;
    
    for i = 1:level
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