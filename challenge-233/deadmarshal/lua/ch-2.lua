#!/usr/bin/env lua

local function frequency_sort(t)
  local h = {}
  for i=1,#t do h[t[i]] = (h[t[i]] or 0) + 1 end
  table.sort(t,function(a,b)
	       return h[a] == h[b] and b < a or h[a] < h[b]
  end)
  return table.concat(t,',')
end

print(string.format("(%s)",frequency_sort{1,1,2,2,2,3}))
print(string.format("(%s)",frequency_sort{2,3,1,3,2}))
print(string.format("(%s)",frequency_sort{-1,1,-6,4,5,-6,1,4,1}))

