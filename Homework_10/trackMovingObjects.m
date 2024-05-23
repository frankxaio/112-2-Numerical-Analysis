function trackMovingObjects(inputVideo, outputVideo)
    % rev, v2022, https://www.mathworks.com/help/vision/ref/vision.pointtracker-system-object.html

    % 讀取影片檔案
    videoReader = VideoReader(inputVideo);
    
    % 獲取影片的基本資訊
    frameRate = videoReader.FrameRate;
    % totalFrames = videoReader.NumFrames;
    
    % 創建 VideoWriter 物件
    videoWriter = VideoWriter(outputVideo);
    videoWriter.FrameRate = frameRate;
    open(videoWriter);
    
    % 創建 KLT 特徵追蹤器
    tracker = vision.PointTracker('MaxBidirectionalError', 2);
    
    % 讀取第一幀並檢測特徵點
    frame = readFrame(videoReader);
    grayFrame = rgb2gray(frame);
    points = detectMinEigenFeatures(grayFrame, 'MinQuality', 0.01);
    
    % 初始化追蹤器
    initialize(tracker, points.Location, grayFrame);
    
    % 在第一幀上繪製特徵點和綠色方框
    outputFrame = insertMarker(frame, points.Location, '+', 'Color', 'white');
    outputFrame = insertShape(outputFrame, 'Rectangle', bbox(points.Location), 'Color', 'green', 'LineWidth', 2);
    writeVideo(videoWriter, outputFrame);
    
    % 逐幀處理影片
    while hasFrame(videoReader)
        frame = readFrame(videoReader);
        grayFrame = rgb2gray(frame);
        
        % 追蹤特徵點
        [points, validity] = tracker(grayFrame);
        
        % 繪製追蹤結果和綠色方框
        outputFrame = insertMarker(frame, points(validity, :), '+', 'Color', 'white');
        outputFrame = insertShape(outputFrame, 'Rectangle', bbox(points(validity, :)), 'Color', 'green', 'LineWidth', 2);
        
        % 如果特徵點數量過少,重新檢測特徵點
        if sum(validity) < 5
            % 釋放追蹤器資源
            release(tracker);
            
            % 重新檢測特徵點並初始化追蹤器
            points = detectMinEigenFeatures(grayFrame, 'MinQuality', 0.01);
            initialize(tracker, points.Location, grayFrame);
            outputFrame = insertMarker(outputFrame, points.Location, '+', 'Color', 'white');
            outputFrame = insertShape(outputFrame, 'Rectangle', bbox(points.Location), 'Color', 'green', 'LineWidth', 2);
        end
        
        writeVideo(videoWriter, outputFrame);

    end
    
    % 關閉 VideoWriter 物件
    close(videoWriter);
    
    % 從工作區中移除 VideoReader 物件
    clear videoReader;
    
    disp('運動物體追蹤完成。');
end

function bb = bbox(points)
    x1 = min(points(:, 1));
    y1 = min(points(:, 2));
    x2 = max(points(:, 1));
    y2 = max(points(:, 2));
    bb = [x1, y1, x2-x1+1, y2-y1+1];
end