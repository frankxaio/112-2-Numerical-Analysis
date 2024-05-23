function [root, ea, r_list, l_list] = secant(func, x0, x1, es, maxit)
% secant: 使用割線法求解非線性方程的根
% [root, ea] = secant(func, x0, x1, es, maxit):
% 輸入:
%   func = 函數名
%   x0, x1 = 兩個初始點
%   es = 所需相對誤差 (預設值 = 0.0001%)
%   maxit = 最大允許迭代次數 (預設值 = 50)
% 輸出:
%   root = 找到的根
%   ea = true percent relative error

if nargin < 3, error('至少需要3個輸入參數'), end
if nargin < 4 || isempty(es), es = 0.0001; end
if nargin < 5 || isempty(maxit), maxit = 50; end

f0 = func(x0); f1 = func(x1);

if f0 == 0, root = x0; ea = 0; return, end
if f1 == 0, root = x1; ea = 0; return, end

iter = 0;
xr_old = 0;
ea = [];
l_list = [];
r_list = [];

while (1)
    iter = iter + 1;
    
    xr = x1 - f1*(x1 - x0)/(f1 - f0);  % 用割線估計根的位置
    fxr = func(xr);
    
    if iter > 1
        ea(iter-1) = abs((xr - xr_old) / xr) * 100;
        if ea(iter-1) < es, root = xr; break; end
    end
    
    xr_old = xr;
    
    x0 = x1; f0 = f1;  % 更新割線的兩個端點
    x1 = xr; f1 = fxr;
    
    r_list(iter) = xr;
    l_list(iter) = x0;
    
    if iter >= maxit
        root = xr; warning('已達到最大迭代次數'); break;
    end
end
end