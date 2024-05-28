function y = convolutional_coding(bit_stream, G)
% INPUT:
%   bit_stream = uncoded bit stream vector
%   G = generator matrix
% OUTPUT:
%   y = channel coded bit stream

y = conv2(bit_stream, G);
y = rem(y, 2);
[row, col] = size(y);
% 將 y 拉盛 [1,row*col] 的向量，依照 row 由上到下，col 由左到右
y = reshape (y, 1, row * col);
end