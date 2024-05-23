# Numerical Analysis Homework 3 

網頁版: https://hackmd.io/@Xaio/rk7eT1G1A

## 計算誤差與真實相對誤差
ea 相對誤差的第一項為 (馬克勞林級數 $n=2$ - 馬克勞林級數 $n=1$) / (第一項為馬克勞林級數 $n=2$) $\times 100\%$

![image](https://hackmd.io/_uploads/SJtImN7JR.png)


## 嘗試畫出 Totall error 的關係
![image](https://hackmd.io/_uploads/ryXs2EXJC.png)

round-off error 受到浮點數的精度、計算順序的影響。現代電腦的精確足夠高，round-off error 影響不大，故在此不列入討論範圍。

### Perspective 1 

![圖1](https://hackmd.io/_uploads/rJ-b9Emy0.png)

想法一，參考 PPT 上圖，Step size h 為 [0,1] 數列的微小間隔，若固定馬克勞林級數 n = 5，微小間隔取 `logspace(-5, 0, 100)` ，可以得出 step size 與 Error 呈正相關的關係。

![image](https://hackmd.io/_uploads/S11waN7yC.png)


### Perspective 2

想法二，參考老師上課的說明，此圖的 truncation error 應該是遞減的。也就是 truncation error 的定義，實際值 - 剩餘估計項。按照此想法畫出來的 Total Error 如下

![image](https://hackmd.io/_uploads/SJxITV7JA.png)


