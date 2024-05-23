function [et, ea, nanindex] = etea(x,n)
    true_value = atan(x);
    mac = arctan_series(x, n);
    mac_sum = zeros(1, n);
    for i = 1:n
        mac_sum(i) = sum(mac(1:i));
    end
    
    %% ea 
    ea = [];
    for i = 2:n
        ea(i-1) = abs(mac_sum(i) - mac_sum(i-1)) / mac_sum(i) * 100;
        if ea(i-1) < 0.0001
            nanindex = i;
            break;
        end
    end
    
    %% et
    et = [];
    for i = 1:nanindex
        et(i) = abs( (true_value - mac_sum(i))/ true_value ) * 100;
    end

end