function mac = arctan_series_symbolic(x, n)
% 用級數求 arctan(x) 的近似值的符號版本
% 輸入:
%   x: 符號變量
%   n: 級數的項數
% 輸出:
%   mac: arctan(x) 的符號級數近似

% 檢查輸入是否為符號變量
if ~isa(x, 'sym')
    x = sym(x);
end

% 初始化符號級數
mac = sym(0);

% 生成級數項
for i = 0:n-1
    next = (-1)^i * x^(2*i+1) / (2*i + 1);
    mac = mac + next;
end

% 簡化符號表達式
mac = simplify(mac);
end