classdef MySort
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        arr_size
    end
    

    methods
        function arr_sorted = SelectionSort(obj, arr)
        % selection sort 
        % 掃陣列，遇到最小值就交換
            for i=1:obj.arr_size-1
            min = i;
            for j= (i+1) : obj.arr_size
                % 如果小於 i < j 就將最小值指向 j 
                if (arr(min) > arr(j))
                min = j;
                end
            end
            temp = arr(i);
            arr(i) = arr(min);
            arr(min) = temp;
            end
            arr_sorted = arr;
        end


        
        function arr_sorted = InsertionSort(obj, arr)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            % 先選定第二個數字，將後面比較大的數字往前移一格，重複循環，直將所有的數字都選過為止
            for i = 2:obj.arr_size 
                temp = arr(i);
                j = i - 1;
                % while loop: 先擺在前面的先判斷，matlab 要先將 j >= 1 擺在前面以免碰到 "Array indices must be positive integers or logical values." 的問題
                while  j>=1 && arr(j) >= temp  
                    % 把數字較大的手牌往前推
                    arr(j+1) = arr(j); 
                    j = j - 1;
                end
                arr(j+1) = temp;
            end
            arr_sorted = arr;
        end

        
        function arr_sorted = BubbleSort(obj, arr)
            % bubble sort
            % 重複掃描陣列，每次都將最大的數字往後推
            for i = 1:obj.arr_size-1
                for j = 1:obj.arr_size-i
                    if arr(j) > arr(j+1)
                        temp = arr(j);
                        arr(j) = arr(j+1);
                        arr(j+1) = temp;
                    end
                end
            end
            arr_sorted = arr;
        end

        function arr = MergeSort(obj, arr)
            % Merge sort 
            size = int32(length(arr));
            if size > 1
                leftArray = arr(1 : size/2);
                rightArray = arr(size/2+1 : end);
                % disp(["arr:", arr]);
                % disp(["leftArray:", leftArray]);
                % disp(["rightArray", rightArray]);
                % fprintf("======================================================\n");
                arr = obj.Merge(obj.MergeSort(leftArray), obj.MergeSort(rightArray));
                % disp(["arr_merge:", arr]);
            end

        end

        function arr_merge = Merge(~, leftArray, rightArray)
            arr_merge = [];
            while ~isempty(leftArray) && ~isempty(rightArray)
                if leftArray(1) <= rightArray(1)
                    arr_merge(end+1) = leftArray(1);
                    leftArray(1) = [];
                else
                    arr_merge(end+1) = rightArray(1);
                    rightArray(1) = [];
                end
            end
            arr_merge = [arr_merge,leftArray,rightArray];
        end

    end


end

