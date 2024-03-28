% 測試包圍法的腳本

% 定義要求解的非線性函數
func = @(x) x^3 - 2*x - 5;
% func = @(x) (x^3 + 3*x^2 - 6*x - 8)/4;
% func = @(x) (x^3 - 6*x^2 + 9*x - 4);

% 給定區間端點
l = 2;
u = 3;
% l = -100;
% u = 100;

% 設置所需的相對誤差和最大迭代次數
es = 0.0001;
maxit = 50;

% 調用包圍法函數求解根
[root, ea] = falsepos(func, l, u, es, maxit);
gold_root = solve(func, x);

% 顯示結果
fprintf('Gold: %f\n', gold_root);
fprintf('包圍法找到的根: %f\n', root);
fprintf('根處的函數值: %f\n', func(root));
fprintf('True percent relative error: %f%%\n', ea);

% 繪製函數圖像和找到的根
fplot(func, [l, u], 'LineWidth', 1.5);
hold on;
plot(root, 0, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title('包圍法求解非線性方程的根');
legend('f(x)', '找到的根');
grid on;