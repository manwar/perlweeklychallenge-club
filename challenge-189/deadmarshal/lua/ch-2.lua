local function array_degree(t)
  local left,count = {},{}
  local index,max,min = 0,0,0
  for i=1, #t do
    if not count[t[i]] then
      left[t[i]] = i
      count[t[i]] = 1
    else
      count[t[i]] = count[t[i]] + 1
    end
    if count[t[i]] > max then
      max = count[t[i]]
      min = i - left[t[i]]
      index = left[t[i]]
    elseif(count[t[i]] == max) and (i - left[t[i]] < min) then
      min = i - left[t[i]]
      index = left[t[i]]
    end
  end
  for i=index, index+min do
    io.write(t[i], ' ')
  end
  print()
end

array_degree({1,3,3,2})
array_degree({1,2,1,3})
array_degree({1,3,2,1,2})
array_degree({1,1,2,3,2})
array_degree({2,1,2,1,1})

