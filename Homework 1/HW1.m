% ===================================== %
%       Numerical Method HW-1           %
%   1. sorting algorithm.               %
%   2. calculate the speedup            %
% ===================================== %

clear;
clc;

% load data;
N = 5*10^7;
% N = 5*10;
din = randperm(N); % 產生不重複的整數
% din = rand(N); 
% din = [8 3 2 1 7 4 6 5];

tic;
s1 = sort(din);
ts = toc;
fprintf('===================================\n');
fprintf('T_sort is %.3f sec.\n', ts);

mysort = MySort();
tic;
s2 = mysort.BucketSort(din);
ty1 = toc;

tic
s3 = mysort.Homework(din);
ty2 = toc;

fprintf('T_BucketSort is %.3f sec.\n', ty1);
fprintf('T_Homework is %.3f sec.\n', ty2);
speedup_BucketSort = ty1/ts;
speedup_Homework = ty2/ts;
fprintf('The time speedup is %.4f\n', speedup_BucketSort);
fprintf('The time speedup is %.4f\n', speedup_Homework);

corr = sum(s1~=s2); % ~= 左右兩邊不等於回傳 1
if corr==0
    fprintf('Answer is correct!!\n');
else
    fprintf('Answer is NOT correct!!\n');
end
fprintf('===================================\n');

