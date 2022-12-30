local function wiggle_sort(t)
  for i=1, #t-1 do
    if (i % 2 ~= 0) == (t[i] > t[i+1]) then
      t[i],t[i+1] = t[i+1],t[i]
    end
  end
end

local t1,t2 = {1,5,1,1,6,4},{1,3,2,2,3,1}
wiggle_sort(t1)
wiggle_sort(t2)
print(table.concat(t1,' '))
print(table.concat(t2,' '))

