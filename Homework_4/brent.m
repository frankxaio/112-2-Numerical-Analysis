function [root, ea, r_list, l_list] = brent(func, l, u, es, maxit)
% brent: 使用 Brent 法求解非線性方程的根
% [root, ea] = brent(func, l, u, es, maxit):
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

a = l; b = u; fa = func(a); fb = func(b);
c = a; fc = fa; d = b - a; e = d;

iter = 0; 
ea = [];
l_list = [];
r_list = [];

while (1)
    iter = iter + 1;
    
    if fb == 0, root = b; ea = 0; return, end
    if sign(fa) == sign(fb), a = c; fa = fc; d = b - c; e = d; end
    
    if abs(fa) < abs(fb)
        c = b; b = a; a = c;
        fc = fb; fb = fa; fa = fc;        
    end
    
    tol = 2 * eps * abs(b) + es/2; m = (a-b)/2;
    % if (abs(m) <= tol) || (fb == 0)
    %     root = b; break; 
    % end
    
    if (abs(e) < tol) || (abs(fc) <= abs(fb))
        d = m; e = m;
    else
        s = fb/fc;
        if (a == c)
            p = 2 * m * s; q = 1 - s;
        else
            q = fc/fa; r = fb/fa;
            p = s * (2 * m * q * (q - r) - (b - c) * (r - 1));
            q = (q - 1) * (r - 1) * (s - 1);
        end
        if p > 0, q = -q; else p = -p; end
        if (2*p < 3*m*q-abs(tol*q)) && (p < abs(e*q/2))
            e = d; d = p/q;
        else
            d = m; e = m;
        end
    end
    
    c = b; fc = fb;
    if abs(d) > tol, b = b + d;
    else if b > c, b = b - tol; else b = b + tol; end
    end
    fb = func(b);
    
    r_list(iter) = b;
    l_list(iter) = a;
    
    if iter > 1
        ea(iter-1) = abs((b - r_list(iter-1)) / b) * 100;
        if ea(iter-1) < es, root = b; 
            % disp('已達到所需誤差');
            break; 
        end
    end
    
    if iter >= maxit, root = b; warning('已達到最大迭代次數'); break; end
end
end