% 定義要求解的非線性函數
% func = @(x) (x-1).*(x-2).*(x-3);
func = @(x) (x-2).*(x-5).*(x-7).*(x-9).*x;

% 定義包含根的區間列表
% intervals = [0, 1.5; 1.5, 2.5; 2.5, 3.5];
l = -100;
u = 100;
intervals = [];

% 設置容許誤差
tol = 1e-6;
  
% 調用 bisect_multiple 函數求解多個根
roots = bisect_multiple(func, intervals, tol);
gold_roots = solve(func, x);

% 顯示找到的根
fprintf('找到的根：\n');
disp(roots);

fprintf('gold roots：\n');
disp(gold_roots);