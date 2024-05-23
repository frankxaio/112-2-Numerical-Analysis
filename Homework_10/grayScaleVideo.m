function grayScaleVideo(inputVideo, outputVideo)
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
        grayFrame = rgb2gray(frame);
        writeVideo(videoWriter, grayFrame);
    end
    
    % 關閉 VideoWriter 物件
    close(videoWriter);
    
    % 從工作區中移除 VideoReader 物件
    clear videoReader;
    
    disp('影片灰階化完成。');
end