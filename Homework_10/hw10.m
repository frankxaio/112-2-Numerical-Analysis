% 轉灰階
grayScaleVideo('work.mp4', 'work_grey');

% 高斯模糊
gaussianBlurVideo('work_grey.avi', 'work_grey_blur', 5, 10);

% 邊緣處理
edgeDetectionVideo('work_grey_blur.avi', 'work_grey_blur_edge', 'Canny', 0.1);

% 銳利化
% sharpenVideo('work.mp4', 'work_sharp', 0.5, 0.5);

% 運動物體追蹤
trackMovingObjects('work_grey_blur_edge.avi', 'work_grey_blur_edge_track');