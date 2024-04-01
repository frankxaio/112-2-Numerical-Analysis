function [root, ea, r_list, l_list] = invQuadInterp(func, x0, x1, x2, es, maxit)
% invQuadInterp: 使用逆二次插值法求解非線性方程的根
% [root, ea] = invQuadInterp(func, x0, x1, x2, es, maxit):
% 輸入:
%   func = 函數名
%   x0, x1, x2 = 三個初始點
%   es = 所需相對誤差 (預設值 = 0.0001%)
%   maxit = 最大允許迭代次數 (預設值 = 50)
% 輸出:
%   root = 找到的根
%   ea = true percent relative error

if nargin < 4, error('至少需要4個輸入參數'), end
if nargin < 5 || isempty(es), es = 0.0001; end
if nargin < 6 || isempty(maxit), maxit = 50; end

f0 = func(x0); f1 = func(x1); f2 = func(x2);

if f0 == 0, root = x0; ea = 0; return, end
if f1 == 0, root = x1; ea = 0; return, end
if f2 == 0, root = x2; ea = 0; return, end

iter = 0;
xr_old = 0;
ea = [];
l_list = [];
r_list = [];

while (1)
    iter = iter + 1;

    q0 = (x1 - x0) / (f1 - f0);
    q1 = (x2 - x1) / (f2 - f1);
    d = q1 - q0;
    q2 = d / (f2 - f0);
    
    xr = x2 - (1 / q2) * (f2 / ((1 / q0) * f1 - (1 / q1) * f2));  % 用逆二次插值估計根的位置
    fxr = func(xr);
    
    if iter > 1
        ea(iter-1) = abs((xr - xr_old) / xr) * 100;
        if ea(iter-1) < es, root = xr; break; end
    end
    
    xr_old = xr;
    
    x0 = x1; f0 = f1;  % 更新三個點
    x1 = x2; f1 = f2;
    x2 = xr; f2 = fxr;
    
    r_list(iter) = xr;
    l_list(iter) = x0;
    
    if iter >= maxit
        root = xr; warning('已達到最大迭代次數'); break;
    end
end
end