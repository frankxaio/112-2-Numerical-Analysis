# Final 

| 系級     | 學號     | 姓名   |
| -------- | -------- | ------ |
| 電子三乙 | B1027234 | 林永濬 |
| 電子三乙 | B1027236 | 蕭銘宏 |

## Introduction

完整的數位通訊系統的模擬。數位通訊系統由多個模組組成,每個模組在這裡都是以MATLAB函式的形式實現的,而'main_code.m'檔案將它們組合在一起,構建出完整的系統。該系統從Data資料夾中讀取文字檔案'source_data.txt',並相應地處理文字資料,然後將接收到的文字寫入Data資料夾中名為'received.txt'的另一個文字檔案。下面的方塊圖以順序的方式顯示了系統的所有模組。

![](https://user-images.githubusercontent.com/37298971/52767116-acbd0b80-3053-11e9-9998-4dd80c8a2825.png)

## Theory

### Source Coding: Huffman encoding 

Huffman編碼廣泛應用於各種資料壓縮領域,如文字壓縮、圖像壓縮、音訊壓縮等。它是一種理論上最優的前綴碼,能夠在無失真的情況下實現資料的壓縮。

Huffman編碼的特點是,出現頻率高的符號被分配了較短的編碼,出現頻率低的符號被分配了較長的編碼。**這樣可以有效地減少編碼後資料的總長度,達到壓縮的目的**。

> [!NOTE]
>
> Huffman編碼的步驟如下:
>
> 1. 統計資料中各個符號的出現頻率。
>
> 2. 根據頻率建立一個符號表,並按照頻率從小到大排序。
>
> 3. 選擇頻率最小的兩個符號,建立一個新的節點,該節點的頻率為兩個子節點頻率之和。
>
> 4. 將新建立的節點加入符號表中,並重複步驟3,直到符號表中只剩下一個節點為止。
>
> 5. 從根節點開始,為左子樹分配二元碼0,為右子樹分配二元碼1,直到所有的葉子節點都被分配了編碼。
>
> 6. 根據建立的編碼表,將原始資料轉換為二元編碼序列。
>

> reference: [Huffman Coding](https://medium.com/@vanijain112/huffman-coding-5c321e769179)

### Channel encoding: Convolutional encoding

Channel Coding(信道編碼)是數位通訊系統中的一種重要技術,其目的是在資料傳輸過程中增加一定的冗餘資訊,以提高資料傳輸的可靠性。我們採用的 Convolutional encoding(卷積編碼) 實現 channel encoding。卷積編碼的基本原理是將輸入資料序列與一個或多個生成多項式進行卷積運算,產生編碼後的輸出序列。

> [!NOTE]
>
> **卷積編碼步驟:**
>
> 1. 定義一個或多個生成多項式,表示為二進位序列。
>
> 2. 將輸入資料序列分組,每組長度為k個位元。
>
> 3. 對每個輸入資料組,使用生成多項式進行卷積運算,產生n個位元的輸出(n > k)。
>
> 4. 將所有輸出位元組合成編碼後的序列。
>
>
> **卷積編碼的特點是:**
>
> 1. 編碼後的輸出序列不僅與當前輸入資料有關,還與之前的輸入資料有關,因此具有一定的記憶性。
>
> 2. 編碼率(k/n)可以根據需要進行調整,以平衡資料傳輸速率和可靠性。
>
> 3. 卷積編碼可以使用維特比演算法(Viterbi Algorithm)進行最大似然解碼,在接收端恢復原始資料。

> reference: [Intro to Convolutional Coding — Part I](https://medium.com/nerd-for-tech/into-to-convolutional-coding-part-i-d63decab56a0)

### Modulation: ASK, FSK, PSK,  

> [!NOTE]
>
> | Analog                             | Digital                                   |
> | ---------------------------------- | ----------------------------------------- |
> | 振幅調變(Amplitude Modulation, AM) | 振幅偏移鍵制(Amplitude Shift Keying, ASK) |
> | 頻率調變(Frequency Modulation, FM) | 頻率偏移鍵制(Frequency Shift Keying, FSK) |
> | 相位調變(Phase Modulation, PM)     | 相位偏移鍵制(Phase Shift Keying, PSK)。   |
>
> 正交振幅調變(Quadrature Amplitude Modulation, QAM)，結合了PSK、ASK，同時控制振幅與相位，一個訊號能代表更多的資料。

比較對象: BASK, BPSK, QAM16, QAM64, QPSK, FSK 

比較指標: 信噪比(EB/N0)-位元錯誤率(BER)

### Channel: Additive White Gaussian Noise Channel

### Demodulation: ASK and PSK demodulation

### Channel Decoding: Viterbi decoding

### Source Decoding: Huffman decoding
