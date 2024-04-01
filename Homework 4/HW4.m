% 測試包圍法的腳本

% 定義要求解的非線性函數
% func = @(x) x^3 - 2*x - 5;
syms x;
func = @(x) x^10 -1;

% 給定區間端點
l = 0;
u = 1.3;
% l = -100;
% u = 100;

% 設置所需的相對誤差和最大迭代次數
es = 0.0001;
maxit = 1000;
r_list = [];
l_list = [];

disp("func: ");
disp(func);
gold_root = solve(func, x);
fprintf('Gold:');
fprintf('%f, ', gold_root);
fprintf('\n');

disp('====================');
disp("Use My_Solve");
disp('1: False position method');
disp('2: Bisection method');
disp('3: Linear Interpolation method');
disp('4: Secant Method');
disp('5: Inverse Quadratic Interpolation');
disp('6: Brent-Dekker method');

mode = input('Select mode: ');

% 調用包圍法函數求解根
switch mode
    case 1
        % false position method
        func_name = "False position method";
        [root, ea, r_list, l_list] = falsepos(func, l, u, es, maxit);
    case 2
        % bisection method
        func_name = "Bisection method";
        [root, ea, r_list, l_list] = bisect(func, l, u, es, maxit);
    case 3
        % Linear Interpolation method
        func_name = "Linear Interpolation method";
        [root, ea, r_list, l_list] = linInterp(func, l, u, es, maxit);
    case 4
        % Secant Method
        func_name = "Secant Method";
        [root, ea, r_list, l_list] = secant(func, l, u, es, maxit);
    case 5
        % Inverse Quadratic Interpolation
        func_name = "Inverse Quadratic Interpolation";
        [root, ea, r_list, l_list] = invQuadInterp(func, l, u, es, maxit);
    case 6
        % Brent-Dekker method
        func_name = "Brent-Dekker method";
        [root, ea, r_list, l_list] = brent(func, l, u, es, maxit);
    otherwise
        disp('Input mode select');
        mode = input('Select mode: ');
end

%% 畫圖與顯示結果

disp('====================');
fprintf('The root found by %s: %f\n', func_name ,root);
fprintf('func(root): %f\n', func(root));
lastea = size(ea,2);
fprintf('iteration: %d\n', lastea);
fprintf('True percent relative error: %f%%\n', ea(lastea));

% 繪製函數圖像和找到的根
figure;
fplot(func, [l, u], 'LineWidth', 1.5);
hold on;
plot(root, 0, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title(func_name);
legend('f(x)', '找到的根');
grid on;

%% 畫出函數 func(x)

% figure;
% fplot(func, [l, u], 'LineWidth', 1.5);
% hold on;
% xlabel('x');
% ylabel('f(x)');
% title('func(x) = x^{10} -1');
% legend('f(x)');
% grid on;

