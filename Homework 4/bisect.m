function root = bisect(func, l, u, tol)
% bisect: 使用二分法求解非線性方程的根
% root = bisect(func, l, u, tol):
% 輸入:
%   func = 函數名
%   l, u = 區間下界和上界
%   tol = 容許誤差
% 輸出:
%   root = 找到的根

fl = func(l);
fu = func(u);

if fl == 0
    root = l;
    return;
elseif fu == 0
    root = u;
    return;
elseif fl * fu > 0
    error('在給定區間內函數值無符號變化');
end

while abs(u - l) > tol
    r = (l + u) / 2;
    fr = func(r);

    if fr == 0
        root = r;
        return;
    elseif fl * fr < 0
        u = r;
        fu = fr;
    else
        l = r;
        fl = fr;
    end
end

root = (l + u) / 2;
end