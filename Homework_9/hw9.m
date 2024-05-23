% 讀取 barbara_gray.bmp 影像到矩陣變數
barbara = imread('barbara_gray.bmp');
[rows, cols] = size(barbara);

% 呼叫 remove_white 函數,去除白色背景
remove_white();

% 讀取 flower_no_background.png 影像
flower = imread('flower_no_background.png');

% 將 flower 影像調整為較大的尺寸,例如調整為 100x100
small_flower = imresize(flower, [65, 65]);

% 提取花朵的 alpha 通道
alpha = small_flower(:,:,1); % 假設是 RGBA 圖像,alpha 通道在第四個維度

% 將 alpha 通道應用到灰階影像上
small_flower_gray = rgb2gray(small_flower(:,:,1:3));
small_flower_gray = uint8(double(small_flower_gray) .* (double(alpha) / 255));

% 使用迴圈將小花影像加到 barbara 影像的多個隨機位置
num_flowers = 10; % 要加入的花朵數量
for i = 1:num_flowers
    % 隨機生成放置花朵的行和列
    row = randi([1, rows - size(small_flower_gray,1)]);
    col = randi([1, cols - size(small_flower_gray,2)]);
    
    % 將小花影像加到 barbara 影像上
    barbara(row:row+size(small_flower_gray,1)-1, col:col+size(small_flower_gray,2)-1) = ...
        barbara(row:row+size(small_flower_gray,1)-1, col:col+size(small_flower_gray,2)-1) .* uint8(~small_flower_gray) + ...
        small_flower_gray;
end

% 顯示最終的影像
imshow(barbara);

% 將最終的影像存儲為一個新的圖檔
imwrite(barbara, 'barbara_with_flowers.bmp');