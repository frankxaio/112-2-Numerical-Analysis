A = [10 2 -1; -3 -6 2; 1 1 5];
b = [27; -61.5; -21.5];

ans_gold = A\b;

es = 0.05; % 停止條件:相對誤差小於5%
maxit = 50; % 最大迭代次數

[ans_GS, iter_GS] = GaussSeidel(A, b, es, maxit);

lambda = 1.2;
[ans_GSR, iter_GSR] = GaussSeidelRelax(A, b, es, maxit, lambda);

[ans_Jac, iter_Jac] = Jacobi(A, b, es, maxit);