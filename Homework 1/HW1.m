% ===================================== %
%       Numerical Method HW-1           %
%   1. sorting algorithm.               %
%   2. calculate the speedup            %
% ===================================== %

clear;
clc;

% load data;
N = 5*10^7;
din = randperm(N);

tic;
s1 = sort(din);
ts = toc;
fprintf('===================================\n');
fprintf('T_sort is %.3f sec.\n', ts);


tic;
% =========================== %
% input your code here and replace the sort function.
mysort = MySort();
s2 = mysort.BucketSort(din);

% =========================== %
ty = toc;
fprintf('T_yours is %.3f sec.\n', ty);
speedup = ts/ty;
fprintf('The time speedup is %.4f percent\n', speedup*100);

corr = sum(s1~=s2); % ~= 左右兩邊不等於回傳 1
if corr==0
    fprintf('Answer is correct!!\n');
else
    fprintf('Answer is NOT correct!!\n');
end
fprintf('===================================\n');

