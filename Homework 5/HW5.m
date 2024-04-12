%% 1.a) 圖形法
% x_lin = linspace(-1000, 1000, 1000000);
% y = x.^3 - 6*x.^2 + 11*x - 6.1;
syms x;
f = @(x) x^3 - 6*x^2 + 11*x - 6.1;
roots_gold = double(solve(f,x));
hold on;
fplot(f, 'LineWidth', 1.5);
plot(roots_gold, 0, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
legend('f(x)', 'roots');
hold off;
grid on; xlabel('x'); ylabel('f(x)');

%% 1.b) 牛頓-拉夫森法
syms x 
f = @(x) x^3 - 6*x^2 + 11*x - 6.1;
df = diff(f, x);
xi = 3.5;
disp("Newton-Raphson method");
for i = 1:3
    xi1 = xi - subs(f,xi)/subs(df, xi);
    xi = double(xi1); % symbolic to value
    fprintf('Iteration %d, x = %.6f\n', i, xi);
end
error = abs(xi-roots_gold(3))/roots_gold(3)*100;
fprintf("Error: %f%%\n", error);

%% 1.c) 割線法 
syms x
f = @(x) x^3 - 6*x^2 + 11*x - 6.1;
x0 = 2.5; x1 = 3.5;  
disp("Secant method");
for i = 1:3
    x_new = x1 - subs(f, x1)*(x0-x1)/(subs(f, x0)-subs(f, x1));
    x_new = double(x_new); % symbolic to value
    fprintf('Iteration %d, x = %.6f\n', i, x_new);
    x0 = x1; x1 = x_new; 
end
error = abs(x_new-roots_gold(3))/roots_gold(3)*100;
fprintf("Error: %f%%\n", error);

%% 1.d) 修正割線法
syms x
f = @(x) x^3 - 6*x^2 + 11*x - 6.1;
xi = 3.5; delta = 0.01;
disp("Modified secant method");
for i = 1:3 
    x = xi - delta*xi*subs(f, xi)/(subs(f, xi+delta*xi)-subs(f, xi));  
    x = double(x); % symbolic to value
    fprintf('Iteration %d, x = %.6f\n', i, x);
    xi = x;
end
error = abs(x-roots_gold(3))/roots_gold(3)*100;
fprintf("Error: %f%%\n", error);

%% 1.e) 用 roots 函數求所有根
disp(roots_gold);

%% 2.a) 圖形法
syms x;
f = @(x) 7*sin(x)*exp(-x) - 1;

% roots_gold = double(solve(f,x));
% roots_gold = (solve(f,x));
% roots_gold = (fsolve(f,-6));

% 用 fsolve 求無限解中的 15 個根
roots_gold = zeros(1,15);
for i = 1:16
    roots_gold(i) = (fsolve(f,(i-1)*(-1*pi)));
    if i>= 16
        roots_gold(i) = (fsolve(f,2));
    end
end


hold on;
fplot(f, 'LineWidth', 1.5);
plot(roots_gold, 0, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold off;
legend('f(x)', 'roots');
grid on; xlabel('x'); ylabel('f(x)');

%% 2.b) 牛頓-拉夫森法
syms x 
f = @(x) 7*sin(x)*exp(-x) - 1;
df = diff(f, x);
xi = 0.3;
disp("Newton-Raphson method");
for i = 1:3
    xi1 = xi - subs(f,xi)/subs(df, xi);
    xi = double(xi1); % symbolic to value
    fprintf('Iteration %d, x = %.6f\n', i, xi);
end

error = abs(xi-roots_gold(1))/roots_gold(1)*100;
fprintf("Error: %f%%\n", error);

%% 2.c) 割線法 
syms x
f = @(x) 7*sin(x)*exp(-x) - 1;
x0 = 0.5; x1 = 0.4;  
disp("Secant method");
for i = 1:3
    x_new = x1 - subs(f, x1)*(x0-x1)/(subs(f, x0)-subs(f, x1));
    x_new = double(x_new); % symbolic to value
    fprintf('Iteration %d, x = %.6f\n', i, x_new);
    x0 = x1; x1 = x_new; 
end

error = abs(x_new-roots_gold(1))/roots_gold(1)*100;
fprintf("Error: %f%%\n", error);

%% 2.d) 修正割線法
syms x
f = @(x) 7*sin(x)*exp(-x) - 1;
xi = 3.5; delta = 0.01;
disp("Modified secant method");
for i = 1:5 
    x = xi - delta*xi*subs(f, xi)/(subs(f, xi+delta*xi)-subs(f, xi));  
    x = double(x); % symbolic to value
    fprintf('Iteration %d, x = %.6f\n', i, x);
    xi = x;
end

error = abs(x-roots_gold(1))/roots_gold(1)*100;
fprintf("Error: %f%%\n", error);

%% 2.e) 用 roots 函數求所有根
disp(roots_gold);
