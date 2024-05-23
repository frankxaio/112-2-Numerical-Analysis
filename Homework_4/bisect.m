function [root, ea, r_list, l_list] = bisect(func, l, u, es, maxit)
% bisect: 使用二分法求解非線性方程的根
% root = bisect(func, l, u, tol):
% 輸入:
%   func = 函數名
%   l, u = 區間下界和上界
%   es = 所需相對誤差 (預設值 = 0.0001%)
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

iter = 0;
ea = [];
r_list = [];
l_list = [];

while (1)
    iter = iter + 1;

    r = (l + u) / 2;
    fr = func(r);

    % ea 
    if iter > 1
        ea(iter-1) = abs((r - r_old) / r) * 100;
        if ea(iter-1) < es
            root = r;
            break;
        end
    end


    r_old = r;

    if fr == 0
        root = r;
        return;
    elseif fl * fr < 0
        % 有根在左半邊
        u = r;
        fu = fr;
        r_list = [r_list, r];
        l_list = [l_list, l];
    else
        l = r;
        fl = fr;
        r_list = [r_list, r];
        l_list = [l_list, l];
    end

    
    if(maxit == iter)
        root = r;
        break;
    end

end

root = (l + u) / 2;

end