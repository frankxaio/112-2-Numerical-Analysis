function et = true_error(true_value, approx_value)
% 計算真實值誤差
% 輸入:
%   true_value: 真實值
%   approx_value: 近似值
% 輸出:
%   et: 真實值誤差 (百分比)

et = (true_value - approx_value) / true_value * 100;
end
