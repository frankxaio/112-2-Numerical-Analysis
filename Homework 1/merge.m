function y = merge(L,R)
y = [];
while ~isempty(L) && ~isempty(R)
if L(1) <= R(1)
y(end+1) = L(1);
L(1) = [];
else
y(end+1) = R(1);
R(1) = [];
end
end
y = [y,L,R];
end