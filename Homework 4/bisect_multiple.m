function roots = bisect_multiple(func, intervals, tol)
% bisect_multiple: 使用二分法求解非線性方程的多個根
% roots = bisect_multiple(func, intervals, tol):
% 輸入:
%   func = 函數名
%   intervals = 包含根的區間列表，每行表示一個區間 [l, u]
%   tol = 容許誤差
% 輸出:
%   roots = 找到的根列表

roots = [];

for i = 1:size(intervals, 1)
    l = intervals(i, 1);
    u = intervals(i, 2);
    
    fl = func(l);
    fu = func(u);
    
    if fl * fu < 0
        root = bisect(func, l, u, tol);
        roots = [roots; root];
    end
end
end