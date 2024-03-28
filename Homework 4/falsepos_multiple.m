function [roots, ea] = falsepos_multiple(func, intervals, es, maxit)
% falsepos_multiple: 使用包圍法求解非線性方程的多個根
% roots = falsepos_multiple(func, intervals, es, maxit):
% 輸入:
%   func = 函數名
%   intervals = 包含根的區間列表，每行表示一個區間 [l, u]
%   es = 所需相對誤差 (預設值 = 0.0001%)
%   maxit = 最大允許迭代次數 (預設值 = 50)
% 輸出:
%   roots = 找到的根列表

if nargin < 2, error('至少需要2個輸入參數'), end
if nargin < 3 || isempty(es), es = 0.0001; end
if nargin < 4 || isempty(maxit), maxit = 50; end

roots = [];
ea = [];

for i = 1:size(intervals, 1)
    l = intervals(i, 1);
    u = intervals(i, 2);
    
    [root, ea] = falsepos(func, l, u, es, maxit);
    
    roots = [roots; root];
end