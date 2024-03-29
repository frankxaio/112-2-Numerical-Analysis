        function sx = BucketSort(x)
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
        alpha = 10; % alpha = n / m

        % Find min and max elements of x
        n = length(x);
        minx = min(x);
        maxx = max(x);

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
                x = insertionsort(x,prev,next,head(j));
                
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

        function x = insertionsort(x,prev,next,head)
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