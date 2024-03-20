# Numberical Analysis Homework 1 

網頁閱讀: https://hackmd.io/@Xaio/ByPdjig06

## 簡介

從 bubble sort 開始探索排序演算法，發現 bucket sort 有最佳的效果，並改良 bucket Sort，加速 Matlab 內建 sort() 針對 randperm(N) 排序的排序法。

## Bucket Sort

假設要排序 n個元素的陣列，這些元素的值平均散落在某個已知的預期範圍內，例如 1 到 100。

```ascii
Original array
+-------------------------------------------------+
|  6 | 28 | 96 | 14 | 74 | 37 |  9 | 71 | 91 | 36 |
+-------------------------------------------------+
```


Step1: Create buckets：建立 k 個桶子（bucket）的陣列。每個桶子對應預期範圍的某區間，如第一個桶子放 1 到 10，第二個放 11 到 20。

```ascii
Bucket array

+-------------------------------------------------+
|    |    |    |    |    |    |    |    |    |    |
+-------------------------------------------------+
  ^    ^
  |    |
  |    |
  |    holds values in range 11 to 20
  holds values in range 1 to 10
```

Step2: Scatter：將每個元素依照該值放入對應的桶子中。

```ascii
Bucket array

  6,9  14   28   37,36               74,71     96,91
  |    |    |    |                   |         |
+-v----v----v----v-------------------v---------v--+
|    |    |    |    |    |    |    |    |    |    |
+-------------------------------------------------+
```


Step3: Inner sort：排序所有非空的桶子。

```ascii
Bucket array

  sort sort sort sort                sort      sort
  ---  --   --   -----               -----     -----
  6,9  14   28   36,37               71,74     91,96
  |    |    |    |                   |         |
+-v----v----v----v-------------------v---------v--+
|    |    |    |    |    |    |    |    |    |    |
+-------------------------------------------------+
```

Step4: Gather：依序走訪所有桶子，將桶內的元素放回原本的陣列中

```ascii
Sorted array
+-------------------------------------------------+
|  6 |  9 | 14 | 28 | 36 | 37 | 71 | 74 | 91 | 96 |
+-------------------------------------------------+
```

## Mysort

> din = randperm(N) returns a row vector containing a random permutation of the integers from 1 to n without repeating elements.

只使用 bucket sort 的第一步與第二步，創建 N 個桶子，使用寬度為 1 的桶子做排序。達到最快速排序 din 的效果，即 O(n)。

```matlab
function x = Homework(x)
    n = length(x);
    minx = min(x);
    dw = 1;
    s = ones(size(x)); 
    for i = 1:n
        j = min(floor((x(i) - minx) / dw) + 1, n); 
    end
end
```

## 結論

使用 bucket sort 排序 $5*10^7$ 筆資料，bucket sort 比內建 `sort()` 多了 12.8413 倍。特別為 `randperm(N)` 產生的排序法為內建 `sort()` 的 0.5270 倍
```ascii
===================================
T_sort is 1.031 sec.
T_BucketSort is 13.234 sec.
T_Homework is 0.543 sec.
The time speedup is 12.8413
The time speedup is 0.5270
Bucket Sort is correct!!
===================================
Homework Sort is correct!!
===================================
```