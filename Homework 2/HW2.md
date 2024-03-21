# Numerical Analysis Homework 2

網頁版: https://hackmd.io/@Xaio/rkzojneR6

## 資料處理

### 0. 觀察資料

Goldindex 漏圈或是錯誤標註 R-peak。


#### Goldindex100, 與 Goldindex102 均出現 648000 之後的 R-peak 無標註的問題

![image](https://hackmd.io/_uploads/ByCKJLF0a.png)

#### Goldindex102 出現大量資料錯誤標註 R-peak:

出現錯誤的 index: 1,38, ..., 2172

:::spoiler Goldindex102 第 1 筆出現錯誤的情形
![image](https://hackmd.io/_uploads/HJ5paQFCp.png)
:::

:::spoiler Goldindex102 第 38 筆出現錯誤的情形
![image](https://hackmd.io/_uploads/Hk-rRmKC6.png)
:::

:::spoiler Goldindex102 第 2172 筆出現錯誤的情形
![image](https://hackmd.io/_uploads/BkjaeEFRT.png)
:::

### 1. 去除線性趨勢
去除趨勢上升或下降: 使 `detrend()` 函數去除輸入信號的線性趨勢，去除信號中的緩慢上升或下降的趨勢。

:::spoiler Detrend 前與 Detend 後
![image](https://hackmd.io/_uploads/ryRPhVdAT.png)
:::

### 2. 帶通濾波去除高頻噪聲

使用 6 階的 Butterworth filter，其截止頻率為 [0.3Hz, 100Hz]。
| Butterworth filter    | spec  |
| --------------------- | :---- |
| 採樣頻率 fs           | 360Hz |
| 低通截止頻率 fcutlow  | 0.3Hz |
| 高通截止頻率 fcuthigh | 100Hz |
| 濾波器階數 order      | 6     |

### 3. 使用 Zero-phasing filter
filtfilt() 進行正向和反向的濾波，達到零相位濾波的效果

> 靈敏度（Sensitivity，也稱為真陽性率、召回率（Recall） ）是指實際為陽性的樣本中，判斷為陽性的比例（例如真正有生病的人中，被判斷為有生病者的比例），計算方式是真陽性除以真陽性+假陰性（實際為陽性，但判斷為陰性）的比值。


## 偵測 R-peak

使用小波轉換對心電圖訊號進行處理

1. 選擇 Daubechies 4 (db4) 小波基函數並設定分解尺度為 5 進行分解。
2. 重構 QRS 波尺度的小波係數
3. 對重構的小波係數平方，突出 R 波的能量
4. 滑動窗口進行平滑處裡
5. 設定閾值與峰值的間隔


## 檢測答案

1. 擴展答案成正負15個點的誤差範圍 Goldindex -> Gold_expand
2. 找出真陽性 (TP) 的數量:
    - 使用` ismember()` 檢查 Gold_expand 中的元素是否在 r_peak_indices 中得到一個陣列 isCorrect。
    - 使用 `any()` 檢查 isCorrect 的每一行是否包含邏輯 1，得到一個陣列 isCorrect_num。
    - 使用 `sum()` 計算 isCorrect_num 中的邏輯 1 的數量，得到真陽性 (TP) 的數量 tp。

2. 找出假陽性 (FP) 的數量:
    - 建立一個從 1 到 ecg100 長度的整數陣列 one2len。
    - 使用 `intersect()` 找到 one2len 和 Gold_expand 的共同值,存儲在 common_values 中。
    - 使用 `setdiff()` 從 one2len 中移除 common_values，得到 Gold_expand_ 陣列，除了標準答案（含誤差範圍）以外的值。
    - 使用 `ismember()` 函數檢查 Gold_expand_ 中的元素是否在 r_peak_indices 中，若存在，則代表發生假陽性，統計假陽性數量存到 fp

3. 計算假陰性 (FN) 的數量: 加總 isCoorect 中出現 0 的次數。
5. 帶入公式計算 sensitivity, positive detection, detection error 和 test。


## 結果

![image](https://hackmd.io/_uploads/SJ3r48tAT.png)


```ASCII
ECG100: tp=2261.000000, fn=4.000000, fp=9.000000
========================================
sensitivity100: 0.998234
positive_detection100: 0.996035
detection_error100: 0.005740
test100: 0.994283
========================================
ECG102: tp=2109.000000, fn=71.000000, fp=70.000000
========================================
sensitivity102: 0.967431
positive_detection102: 0.967875
detection_error102: 0.064679
test102: 0.937333
========================================
```
