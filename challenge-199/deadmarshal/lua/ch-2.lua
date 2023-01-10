#!/usr/bin/env lua

local function good_triplets(t,x,y,z)
  local count = 0
  for i=1,#t do
    for j=1,#t do
      for k=1,#t do
	if math.abs(t[i] - t[j]) <= x and
	  math.abs(t[j] - t[k]) <= y and
	  math.abs(t[i] - t[k]) <= z and
	  0 <= i and i < j and j < k and k <= #t then
	  count = count + 1
	end
      end
    end
  end
  return count
end

print(good_triplets({3,0,1,1,9,7},7,2,3))
print(good_triplets({1,1,2,2,3},0,0,1))

