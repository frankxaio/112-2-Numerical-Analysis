function mac = arctan_series(x, n)
    % 用級數求 arctan(x) 的近似值
    % 輸入: 
    %   x: 要計算的 arctan 值的輸入 
    %   n: 級數的項數
    % 輸出:
    %   y: arctan(x) 的近似值

    mac = zeros(1, n);
    for i = 0:n-1
        next = ((-1)^(i) * x^(2*i+1)) / (2*i + 1);
        mac(i+1) = next;
    end

end