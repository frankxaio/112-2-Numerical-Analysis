function ReadData(filename)
    fprintf('%s:\n', filename);
    A = dlmread(filename, '\t');

    % 提取第三列到第八列數據
    columnData = cell(1, 6);
    for i = 3:8
        columnData{i-2} = A(:, i);
    end

    % 創建圖形窗口並設置子圖
    figure;

    % 根據檔案名稱設置變數名稱
    if strcmp(filename, 'T12_hit_00.1.prn')
        variableNames = {'ch1', 'ch2', 'ch3', 'ch1Cal', 'ch2Cal', 'ch3Cal'};
    elseif strcmp(filename, 'T12_hit_01.1.prn')
        variableNames = {'ch4', 'ch5', 'ch6', 'ch4Cal', 'ch5Cal', 'ch6Cal'};
    elseif strcmp(filename, 'T12_hit_10.1.prn')
        variableNames = {'ch7', 'ch8', 'ch9', 'ch7Cal', 'ch8Cal', 'ch9Cal'};
    elseif strcmp(filename, 'T12_hit_11.1.prn')
        variableNames = {'ch10', 'ch11', 'ch12', 'ch10Cal', 'ch11Cal', 'ch12Cal'};
    else
        variableNames = cell(1, 6);
        for i = 1:6
            variableNames{i} = sprintf('Variable %d', i);
        end
    end

    % 繪製各列數據的長條圖和分布曲線
    for i = 1:6
        subplot(2, 3, i);
        data = columnData{i};
        histogram(data, 'Normalization', 'pdf');
        hold on;
        pd = fitdist(data, 'Normal');
        x_values = linspace(min(data), max(data), 100);
        y_values = pdf(pd, x_values);
        plot(x_values, y_values, 'r-', 'LineWidth', 2);
        title(variableNames{i});
        xlabel('數值');
        ylabel('概率密度');
        grid on;
        hold off;
    end

    % 計算並顯示各列數據的平均值和標準差
    fprintf('=======================================\n');
    fprintf('Ch\tMean\t\tStd dev\n');
    fprintf('=======================================\n');
    for i = 1:3
        data = columnData{i};
        mean_value = mean(data(:));
        std_value = std(data(:));
        fprintf('%s\t%.2f\t\t%.2f\n', variableNames{i}, mean_value, std_value);
    end
    fprintf('=======================================\n');
    fprintf('ChCal\tMean\t\tStd dev\n');
    fprintf('=======================================\n');
    for i = 4:6
        data = columnData{i};
        mean_value = mean(data(:));
        std_value = std(data(:));
        fprintf('%s\t%.2f\t\t%.2f\n', variableNames{i}, mean_value, std_value);
    end
    fprintf('=======================================\n');
end
