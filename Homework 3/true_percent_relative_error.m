function ea = true_percent_relative_error(approx_value, previous_approx_value)
% 計算真實相對誤差
% 輸入:
%   approx_value: 目前的近似值
%   previous_approx_value: 前一次的近似值
% 輸出:
%   ea: 真實相對誤差 (百分比)

ea = (approx_value - previous_approx_value) / approx_value * 100;
end