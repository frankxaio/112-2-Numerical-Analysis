%% Linear System
A = [8 -2 -1 0 0; -2 9 -4 -1 0; -1 -3 7 -1 -2; 0 -4 -2 12 -5; 0 0 -7 -3 15];
b = [5; 2; 1; 1; 5];
%% mldivide()
tic
ans_mldivide = A \ b;
mldivide_time = toc;
disp(ans_mldivide);

%% LU 分解
tic
[L,U] = lu(A);
y = L\b;
ans_LU = U\y;
LU_time = toc;
disp(ans_LU);

%% QR 分解
[Q,R] = qr(A);
y = Q'*b;
ans_QR = R\y;
QR_time = toc;
disp(ans_QR);

%% SVD 
tic;
[U,S,V] = svd(A);
S_inv = diag(1./diag(S));
ans_SVD = V * S_inv * U' * b;
SVD_time = toc;
disp(ans_SVD);