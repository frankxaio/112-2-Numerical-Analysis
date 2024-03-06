function arr_sorted = SelectionSort(arr)
% selection sort 
% 掃陣列，遇到最小值就交換
	for i=1:(size(arr, 2)-1)
		min = i;
		for j= (i+1) : size(arr,2)
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

