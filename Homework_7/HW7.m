A = [10 2 -1; -3 -6 2; 1 1 5];
b = [27; -61.5; -21.5];
ans_gold = A\b;

es = 0.05; 
maxit = 50; 

[ans_GS, iter_GS] = GaussSeidel(A, b, es, maxit);
lambda = 1.2;
[ans_GSR, iter_GSR] = GaussSeidelRelax(A, b, es, maxit, lambda);
[ans_Jac, iter_Jac] = Jacobi(A, b, es, maxit);

fprintf('Gold standard solution:\n');
fprintf('  x1 = %8.4f\n  x2 = %8.4f\n  x3 = %8.4f\n', ans_gold);

fprintf('\nGauss-Seidel method:\n');
fprintf('  Solution:\n    x1 = %8.4f\n    x2 = %8.4f\n    x3 = %8.4f\n', ans_GS);
fprintf('  Iterations: %d\n', iter_GS);

fprintf('\nGauss-Seidel method with relaxation (lambda = %.1f):\n', lambda);
fprintf('  Solution:\n    x1 = %8.4f\n    x2 = %8.4f\n    x3 = %8.4f\n', ans_GSR);
fprintf('  Iterations: %d\n', iter_GSR);

fprintf('\nJacobi method:\n');
fprintf('  Solution:\n    x1 = %8.4f\n    x2 = %8.4f\n    x3 = %8.4f\n', ans_Jac);
fprintf('  Iterations: %d\n', iter_Jac);