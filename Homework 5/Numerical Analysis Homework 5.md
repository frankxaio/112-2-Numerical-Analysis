# Numerical Analysis Homework 5

網頁版: https://hackmd.io/@Xaio/HkA8utfyA

## 找根的方法
- 定義 symbolic variable `sys(x)`, `sys x`
- `solve()` 可以只到 symbolic 的解，`fsolve()` 可以找到 numerical 的解。
- `fzero()` 與 `fsolve()` 相同，但是 `fzero()` 找不到平滑經過的點，但是 `fsolve()` 可以
    ![image](https://hackmd.io/_uploads/SJEs0KMkC.png)
- `roots()` 專門找 polynomials 的解


:::spoiler 補充
- 使用 `diff(y)` 直接對 syms 算微分。積分同理，使用 `int()`。
:::


## 1. Determine the highest real root of $f(x)$

$$f(x) = x^3 -6x^2+11x-6.1$$

### 1.a) Graphically 

![image](https://hackmd.io/_uploads/r1fRrxty0.png)

Highest real root: $3.0467$

### 1.b) Using the Newton-Raphson method (three iterations, $x_i= 3.5$)

```
Newton-Raphson method
Iteration 1, x = 3.191304
Iteration 2, x = 3.068699
Iteration 3, x = 3.047317
Error: 0.020882%
```

Newton-Raphson method 成功找到解


### 1.c) Using the secant method (three iterations, $x_{i-1}=2.5$ and $x_i=3.5$).

```
Secant method
Iteration 1, x = 2.711111
Iteration 2, x = 2.871091
Iteration 3, x = 3.221923
Error: 5.751930%
```

成功找到解，誤差為 5.76%

### 1.d) Using the modified secant method (five iterations, $x_i = 3.5$ ,$\delta= 0.01$ ).

```
Modified secant method
Iteration 1, x = 3.199597
Iteration 2, x = 3.075324
Iteration 3, x = 3.048818
Error: 0.070165%
```

Modified secant method 成功找到解


### 1.e) Determine all the roots with MATLAB.

```
    1.0544
    1.8990
    3.0467
```


## 2. Determine the lowest real root of $g(x)$

$$g(x) : 7\sin(x)e^{-x}-1$$

$x < 0$ 有無窮多解，在此的 lowest real root 只討論 $x>0$ 的情形


### 1.a) Graphically 

![image](https://hackmd.io/_uploads/BkuNdeFkA.png)

### 2.b) Using the Newton-Raphson method (three iterations, $x_i= 0.3$)

```
Newton-Raphson method
Iteration 1, x = 0.144376
Iteration 2, x = 0.169409
Iteration 3, x = 0.170179
Error: 0.000422%
```

Newton-Raphson method 成功找到解

### 2.c) Using the secant method (three iterations, $x_{i-1}=0.5$ and $x_i=0.4$).


```
Secant method
Iteration 1, x = 0.002782
Iteration 2, x = 0.218237
Iteration 3, x = 0.178989
Error: 5.176219%
```

Secant method 找到非負最小的解 $0.178989$，與此解的誤差為 $5.2\%$


### 2.d) Using the modified secant method (five iterations, $x_i = 3.5$ ,$\delta= 0.01$ ).

```
Modified secant method
Iteration 1, x = -5.682098
Iteration 2, x = -7.519326
Iteration 3, x = -6.790712
Iteration 4, x = -6.448305
Iteration 5, x = -6.312891
Error: 3809.537717%
```

Modified secant method 找到 $x<0$ 次大的解 $-6.312891$，與此解的誤差為 $8.083\%$

### 2.e) Determine all the roots with MATLAB.

有無窮多解，x 在 [-45, 2] 的範圍內有下列這些解

| roots             | roots             | roots             | roots             |
| :---------------- | :---------------- | :---------------- | :---------------- |
| 0.170179993752879 | -3.14772834675799 | -6.28291845844458 | -9.42478948913899 |
| -12.5663701161672 | -15.7079632894778 | -18.8495559206084 | -21.9911485751688 |
| -25.1327412287166 | -28.2743338823082 | -31.4159265358979 | -34.5575191894877 |
| -37.6991118430775 | -40.8407044966673 | -43.9822971502571 | 1.89305902941322  |

|      |      |      |      |
| :--- | :--- | :--- | :--- |
|      |      |      |      |
|      |      |      |      |
|      |      |      |      |
|      |      |      |      |
