#!/usr/bin/env lua

local function divisible_average(t)
  assert(type(t) == 'table','t must be a table!')
  local sum,count = 0,0
  for _,x in ipairs(t) do
    if x % 2 == 0 and x % 3 == 0 then
      sum = sum + x
      count = count + 1
    end
  end
  if count == 0 then return 0 end
  local avg = sum / count
  return avg >= 0 and math.floor(avg) or math.ceil(avg)
end

print(divisible_average({18,5,7,11}))
print(divisible_average({6,12,18,24,30,40}))
print(divisible_average({3,9,15,21,27}))
print(divisible_average({6,12,14,20}))
print(divisible_average({6,6,6,12,12}))

