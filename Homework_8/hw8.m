% 定義要分析的檔案列表
files = {
    'T12_hit_00.1.prn', 
    'T12_hit_01.1.prn', 
    'T12_hit_10.1.prn', 
    'T12_hit_11.1.prn'
};

% 遍歷檔案列表並進行分析
for i = 1:length(files)
    filename = files{i};
    ReadData(filename);
    
    % 在每個檔案分析完成後加入分隔線
    fprintf('=========== 分析完成: %s\n\n', filename);
end