arr = [8 3 2 1 7 4 6 5];
my_sort  = MySort();
my_sort.arr_size = size(arr, 2);
% arr_sorted = my_sort.SelectionSort(arr);
% arr_sorted = my_sort.InsertionSort(arr);
% arr_sorted = my_sort.BubbleSort(arr);
% arr_sorted = my_sort.MergeSort(arr);
% arr_sorted = my_sort.QuickSort(arr);
arr_sorted = my_sort.BucketSort(arr);
% arr_sorted = my_sort.TimSort(arr);


disp(arr_sorted);