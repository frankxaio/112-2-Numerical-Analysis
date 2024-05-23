function edgeDetectionVideo(inputVideo, outputVideo, method, threshold)
    % 檢查輸入參數
    if nargin < 3
        method = 'Canny'; % 預設使用 Canny 邊緣檢測方法
    end
    if nargin < 4
        threshold = []; % 預設使用自動閾值
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
    
    % 逐幀處理影片
    while hasFrame(videoReader)
        frame = readFrame(videoReader);
        
        % 將影像轉換為灰階
        grayFrame = rgb2gray(frame);
        
        % 應用邊緣檢測
        edgeFrame = edge(grayFrame, method, threshold);
        
        % 將邊緣影像轉換為 uint8 類型
        edgeFrame = uint8(edgeFrame * 255);
        
        % 將單通道邊緣影像轉換為三通道影像
        edgeFrame = repmat(edgeFrame, [1, 1, 3]);
        
        writeVideo(videoWriter, edgeFrame);
    end
    
    % 關閉 VideoWriter 物件
    close(videoWriter);
    
    % 從工作區中移除 VideoReader 物件
    clear videoReader;
    
    disp('影片邊緣處理完成。');
end