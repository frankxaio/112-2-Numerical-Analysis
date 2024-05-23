function sharpenVideo(inputVideo, outputVideo, alpha, beta)
    % 檢查輸入參數
    if nargin < 3
        alpha = 0.2; % 預設銳利化強度為 0.2
    end
    if nargin < 4
        beta = 1; % 預設銳利化閾值為 1
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
        
        % 應用銳利化處理
        sharpenedFrame = imsharpen(frame, 'Amount', alpha, 'Threshold', beta);
        
        writeVideo(videoWriter, sharpenedFrame);
    end
    
    % 關閉 VideoWriter 物件
    close(videoWriter);
    
    % 從工作區中移除 VideoReader 物件
    clear videoReader;
    
    disp('影片銳利化處理完成。');
end