function [et, ea, nanindex] = etea(x,n)
    true_value = atan(x);
    mac = arctan_series(x, n);
    mac_sum = zeros(1, n);
    for i = 1:n
        mac_sum(i) = sum(mac(1:i));
    end

    %% et

    et = nan(1, n);
    for i = 1:n
        et(i) = abs( (true_value - mac_sum(i))/ true_value ) * 100;
        if et(i) < 0.0001
            nanindex = i; 
            break;
        end
    end

    %% ea

    ea = nan(1, nanindex-1);
    for i = 2:nanindex
        if nanindex == 1
            break;
        end
        ea(i-1) = abs(mac_sum(i) - mac_sum(i-1)) / mac_sum(i) * 100;

    end
end