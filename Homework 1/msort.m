function x = msort(x)
n = int32(length(x));
if n > 1
L = x(1:n/2);
R = x(n/2+1:end);
x = merge(msort(L) , msort(R));
end
end