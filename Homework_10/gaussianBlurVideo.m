function gaussianBlurVideo(inputVideo, outputVideo, kernelSize, sigma)
    % 檢查輸入參數
    if nargin < 3
        kernelSize = 5; % 預設核大小為 5x5
    end
    if nargin < 4
        sigma = 1; % 預設標準差為 1
    end
    
    % 讀取影片檔案
    videoReader = VideoReader(inputVideo);
    
    % 獲取影片的基本資訊
    frameRate = videoReader.FrameRate;
    % totalFrames = videoReader.NumFrames;
    
    % 創建 VideoWriter 物件
    videoWriter = VideoWriter(outputVideo);
    videoWriter.FrameRate = frameRate;
    open(videoWriter);
    
    % 建立高斯核
    gaussianKernel = fspecial('gaussian', kernelSize, sigma);
    
    % 逐幀處理影片
    while hasFrame(videoReader)
        frame = readFrame(videoReader);
        
        % 對每個色彩通道應用高斯模糊
        blurredFrame = zeros(size(frame), 'like', frame);
        for c = 1:3
            blurredFrame(:,:,c) = imfilter(frame(:,:,c), gaussianKernel, 'replicate');
        end
        
        writeVideo(videoWriter, blurredFrame);
    end
    
    % 關閉 VideoWriter 物件
    close(videoWriter);
    
    % 從工作區中移除 VideoReader 物件
    clear videoReader;
    
    disp('影片高斯模糊完成。');
end