function [sensitivity, postive_detection, detection_error, test] = Evaluation(goldindex, r_peak_indices, ecg100)
    Gold_expand = ExpandArray(goldindex);
    %% 找出 tp 
    isCorrect = ismember(Gold_expand, r_peak_indices); % 是否正確偵測到 r_peak
    isCorrect_num  = any(isCorrect, 2); % any() 取得每個 row 是否有 logical 1, sum() 計算正確偵測 R peak 的數量
    tp = sum(isCorrect_num);

    %% 找出 fp 

    one2len = 1:length(ecg100);
    common_values = intersect(one2len, Gold_expand);
    Gold_expand_ = transpose(setdiff(one2len, common_values)); % 將 one2len 扣掉 common_values，扣掉共通值後的陣列
    fp = ismember(Gold_expand_, r_peak_indices);  

    % 將 fp 在 Gold_expand_ 的 index 找出來
    fp = find(fp == 1);
    % r_peak_indeices 中是 fp 點
    r_peak_fp = Gold_expand_(fp); % 找出 fp 的 r_peak_indices
    fp = length(r_peak_fp);
        

    %% FN 
    fn = (length(goldindex) - length(r_peak_indices));

    sensitivity = tp / (tp + fn);
    postive_detection = tp / (tp+ fp);
    detection_error = (fn + fp) / (length(goldindex));
    test = tp / (tp+fn+fp);

    fprintf("tp=%f, fn=%f, fp=%f\n", tp, fn, fp);