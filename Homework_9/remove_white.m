function remove_white()
% 讀取花朵影像
flower = imread('flower.jpg');

% 將花朵影像轉換為灰階
flower_gray = rgb2gray(flower);

% 創建一個二值遮罩,用於識別白色背景
mask = flower_gray > 200;

% 將遮罩擴展到三個色彩通道
mask = repmat(mask, [1, 1, 3]);

% 將白色背景像素設置為透明
flower(mask) = 0;

% 儲存去除白色背景的花朵影像
imwrite(flower, 'flower_no_background.png');
end