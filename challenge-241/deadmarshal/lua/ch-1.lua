#!/usr/bin/env lua

local function arithmetic_triplets(t,diff)
  local count = 0
  for i=1,#t do
    for j=i+1,#t do
      for k=j+1,#t do
	if t[j] - t[i] == diff and t[k] - t[j] == diff then
	  count = count + 1
	end
      end
    end
  end
  return count
end

print(arithmetic_triplets({0,1,4,6,7,10},3))
print(arithmetic_triplets({4,5,6,7,8,9},2))

