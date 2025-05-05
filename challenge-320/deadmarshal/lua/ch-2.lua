#!/usr/bin/env lua

local function sum_digits(n)
  assert(type(n) == 'number','n must be a number!')
  local sum = 0
  while n ~= 0 do
    sum = sum + n % 10
    n = n // 10
  end
  return sum
end

local function sum_difference(t)
  assert(type(t) == 'table','t must be a table!')
  local sum1,sum2 = 0,0
  for i=1,#t do
    sum1 = sum1 + t[i]
    sum2 = sum2 + sum_digits(t[i])
  end
  return math.abs(sum1 - sum2)
end

print(sum_difference{1,23,4,5})
print(sum_difference{1,2,3,4,5})
print(sum_difference{1,2,34})

