function [root, ea, r_list, l_list] = falsepos(func, l, u, es, maxit)
% falsepos: 使用包圍法求解非線性方程的根
% [root, ea] = falsepos(func, l, u, es, maxit):
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

fl = func(l);
fu = func(u);

if fl == 0, root = l; ea = 0; return, end
if fu == 0, root = u; ea = 0; return, end
if fl*fu > 0, error('在給定區間內函數值無符號變化'), end

iter = 0;
r_old = 0;
ea = [];
l_list = [];
r_list = [];

while (1)
    iter = iter + 1;
    
    r = u - fu*(u-l)/(fu-fl);
    fr = func(r);
    
    if iter > 1
        ea(iter-1) = abs((r - r_old) / r) * 100;
        if ea(iter-1) < es
            root = r;
            break;
        end
    end
    
    r_old = r;
    
    if fl*fr < 0
        u = r;  fu = fr;
        r_list = [r_list, r];
        l_list = [l_list, l];
    else
        l = r;  fl = fr;
        r_list = [r_list, r];
        l_list = [l_list, l];
    end
    
    if iter >= maxit
        root = r;
        warning('已達到最大迭代次數');
        break;
    end
end