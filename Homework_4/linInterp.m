function [root, ea, r_list, l_list] = linInterp(func, l, u, es, maxit)
% linInterp: 使用雙線性插值法求解非線性方程的根
% [root, ea] = linInterp(func, l, u, es, maxit):
% 輸入:
%   func = 函數名
%   l, u = 區間下界和上界
%   es = 所需相對誤差 (預設值 = 0.0001%)
%   maxit = 最大允許迭代次數 (預設值 = 50)
% 輸出:
%   root = 找到的根
%   ea = true percent relative error

if nargin < 3, error('至少需要3個輸入參數'), end
if nargin < 4 || isempty(es), es = 0.0001; end
if nargin < 5 || isempty(maxit), maxit = 50; end

fl = func(l); fu = func(u);
if fl == 0, root = l; ea = 0; return, end
if fu == 0, root = u; ea = 0; return, end
if fl*fu > 0, error('在給定區間內函數值無符號變化'), end

iter = 0;
xr_old = 0;
ea = [];
l_list = [];
r_list = [];

while (1)
    iter = iter + 1;
    
    xr = u - fu*(u - l)/(fu - fl);  % 用線性內插估計根的位置
    fxr = func(xr);
    
    if iter > 1
        ea(iter-1) = abs((xr - xr_old) / xr) * 100;
        if ea(iter-1) < es, root = xr; break; end
    end
    
    xr_old = xr;
    
    if fl*fxr < 0  % 根在左半邊
        u = xr; fu = fxr;
    else  % 根在右半邊
        l = xr; fl = fxr;
    end
    
    r_list(iter) = xr;
    l_list(iter) = l;
    
    if iter >= maxit
        root = xr; warning('已達到最大迭代次數'); break;
    end
end
end