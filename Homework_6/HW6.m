clc 
clear
%% Linear System
A = [8 -2 -1 0 0; -2 9 -4 -1 0; -1 -3 7 -1 -2; 0 -4 -2 12 -5; 0 0 -7 -3 15];
b = [5; 2; 1; 1; 5];
disp("==========Linear System==========");
disp("A = ");
disp(A);
disp("b = ");
disp(b);

%% mldivide()
disp("==========Method 1: mldivide()==========");
tic
ans_mldivide = A \ b;
mldivide_time = toc;
fprintf("mldivide() time: %f\n", mldivide_time);
fprintf("ans_mldivide =\n");
disp(ans_mldivide);

%% LU 分解
disp("==========Method 2: LU()==========");
tic
[L,U] = lu(A);
y = L\b;
ans_LU = U\y;
LU_time = toc;
fprintf("LU() time: %f\n", LU_time);
fprintf("ans_LU =\n");
disp(ans_LU);

%% QR 分解
disp("==========Method 3: QR()==========");
[Q,R] = qr(A);
y = Q'*b;
ans_QR = R\y;
QR_time = toc;
fprintf("QR() time: %f\n", QR_time);
fprintf("ans_QR =\n");
disp(ans_QR);

%% SVD 
disp("==========Method 4: SVD()==========");
tic;
[U,S,V] = svd(A);
S_inv = diag(1./diag(S));
ans_SVD = V * S_inv * U' * b;
SVD_time = toc;
fprintf("SVD() time: %f\n", SVD_time);
fprintf("ans_SVD =\n");
disp(ans_SVD);