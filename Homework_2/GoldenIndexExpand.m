function expand_arr = ExpandArray(arr)
  expand_arr = repmat(arr, [1, 31]);
  for i = 2:31
    if i<=16
      expand_arr(:, i) = arr(:, i) - (i-1);
    else 
      expand_arr(:, i) = arr(:, i) + (i-16);
    end
  end
end