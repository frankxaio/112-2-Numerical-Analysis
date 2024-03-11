classdef MySort
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        arr_size
        MIN_MERGE = 32
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

        function arr = QuickSort(obj, arr)
            if numel(arr) > 1 % numel 返回 arr 的元素數量，使用 length() 返回最大 dimension 的長度
                left = arr(arr < arr(1));
                middle = arr(arr == arr(1));
                right = arr(arr > arr(1));
                arr = [obj.QuickSort(left), middle, obj.QuickSort(right)];
            end
        end

        function sx = BucketSort(obj, x)
            %--------------------------------------------------------------------------
            % Syntax:       sx = bucketsort(x);
            %               
            % Inputs:       x is a vector of length n
            %               
            % Outputs:      sx is the sorted (ascending) version of x
            %               
            % Description:  This function sorts the input array x in ascending order
            %               using the bucket sort algorithm
            %               
            % Complexity:   O(n)      best-case performance
            %               O(n)      average-case performance (if x is uniform)
            %               O(n^2)    worst-case performance
            %               O(n)      auxiliary space
            %               
            % Author:       Brian Moore
            %               brimoor@umich.edu
            %               
            % Date:         January 5, 2014
            %--------------------------------------------------------------------------
    
            % Default load factor
            alpha = 0.75; % alpha = n / m
    
            % Find min and max elements of x
            n = length(x);
            [minx, maxx] = obj.minmax(x,n);
    
            % Insert elements into m equal width buckets, each containing a doubly
            % linked list
            m = round(n / alpha);
            dw = (maxx - minx) / m;
            head = nan(1,m); % pointers to heads of bucket lists
            prev = nan(1,n); % previous element pointers
            next = nan(1,n); % next element pointers
            last = nan(1,m); % temporary storage
            for i = 1:n
                j = min(floor((x(i) - minx) / dw) + 1,m); % hack to make max(x) fall in last bucket
                if isnan(head(j))
                    head(j) = i;
                else
                    prev(i) = last(j);
                    next(last(j)) = i;
                end
                last(j) = i;
            end
    
            % Bucket sort
            sx = zeros(size(x)); % sorted array
            kk = 0;
            for j = 1:m
                % Check if jth bucket is nonempty
                if ~isnan(head(j))
                    % Sort jth bucket
                    x = obj.insertionsort(x,prev,next,head(j));
                    
                    % Insert sorted elements into sorted array
                    jj = head(j);
                    while ~isnan(jj)
                        kk = kk + 1;
                        sx(kk) = x(jj);
                        jj = next(jj);
                    end
                end
            end
    
            end
    
            function x = insertionsort(obj, x,prev,next,head)
            % Insertion sort for doubly-linked lists
            % Note: In practice, x xhould be passed by reference
    
            j = next(head); % start at second element
            while ~isnan(j)
                pivot = x(j);
                i = j;
                while (~isnan(prev(i)) && (x(prev(i)) > pivot))
                    x(i) = x(prev(i));
                    i = prev(i);
                end
                x(i) = pivot;
                j = next(j);
            end
    
            end
    
            function [min, max] = minmax(obj, x,n)
            % Efficient algorithm for finding the min AND max elements of an array
    
            % Initialize
            if ~mod(n,2)
                % n is even
                if (x(2) > x(1))
                    min = x(1);
                    max = x(2);
                else
                    min = x(2);
                    max = x(1);
                end
                i = 3;
            else
                % n is odd
                min = x(1);
                max = x(1);
                i = 2;
            end
    
            % Process elements in pairs
            while (i < n)
                if (x(i + 1) > x(i))
                    mini = x(i);
                    maxi = x(i + 1);
                else
                    mini = x(i + 1);
                    maxi = x(i);
                end
                if (mini < min)
                    min = mini;
                end
                if (maxi > max)
                    max = maxi;
                end
                i = i + 2;
            end
    
            end
    

        function sx = Homework(obj, x)
            n = length(x);
            minx = min(x);
            dw = 1;
            sx = ones(size(x)); % sorted array
            for i = 1:n
                j = min(floor((x(i) - minx) / dw) + 1, n); % hack to make max(x) fall in last bucket 返回 x(i) 在第幾個桶子
                sx(j) = x(i);
            end
        end
end

    

    methods
        function arr = Merge_TimeSort(arr, l, m, r)
            % 將原始陣列分為兩個部分：左半部分和右半部分
            len1 = m - l + 1;
            len2 = r - m;
            
            % 提取左半部分和右半部分的陣列
            left = arr(l : l + len1 - 1);
            right = arr(m + 1 : m + 1 + len2 - 1);
            
            i = 1;
            j = 1;
            k = l;

            % 比較左右陣列的元素，將其合併到較大的子陣列中
            while i <= len1 && j <= len2
                if left(i) <= right(j)
                    arr(k) = left(i);
                    i = i + 1;
                else
                    arr(k) = right(j);
                    j = j + 1;
                end
                k = k + 1;
            end

            % 將左半部分的剩餘元素複製到原始陣列
            while i <= len1
                arr(k) = left(i);
                k = k + 1;
                i = i + 1;
            end

            % 將右半部分的剩餘元素複製到原始陣列
            while j <= len2
                arr(k) = right(j);
                k = k + 1;
                j = j + 1;
            end
        end

        function n = CalcMinRun(obj, n)
            r = 0;
            while n >= obj.MIN_MERGE
                
                r = bitor(r , bitand(n, 1));
                n = n / 2;
            end
            n = n + r;
        end

        function arr = TimSort(obj, arr)
            n = length(arr);
            minRun = obj.CalcMinRun(n);

            for start=1:n:minRun
                ending = min(start + minRun, n);
                obj.InsertionSort(arr(start:ending));
            end

            size = minRun;
            disp([n, size]);
            while size < n

                for left=1:n:2*size
                    mid = min(n, left+size);
                    right = min(left + 2*size, n);
                    if mid < right
                        arr = obj.Merge(arr, left, mid, right);
                    end
                end

                size = 2*size;
            end
            
        end 
    end

end

