#!/usr/bin/env lua

local function max_gap(t)
  local temp,count,max = 0,0,0
  if #t < 2 then return 0 end
  table.sort(t)
  for i=1,#t,2 do
    temp = math.abs(t[i] - t[i+1])
    if temp > max then max = temp end
  end
  for i=1, #t-1 do
    if math.abs(t[i] - t[i+1]) == max then count = count + 1 end
  end
  return count
end

print(max_gap({2,5,8,1}))
print(max_gap({3}))

