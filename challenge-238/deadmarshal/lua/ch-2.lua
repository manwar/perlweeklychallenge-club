#!/usr/bin/env lua

local function product(n)
  assert(type(n) == 'number','n must be a number!')
  local prod = 1
  while n > 0 do
    prod = prod * (n % 10)
    n = n // 10
  end
  return prod
end

local function helper(n)
  assert(type(n) == 'number','n must be a number!')
  local sum = 0
  repeat
    sum = sum + 1
    n = product(n)
  until n < 10
  return sum
end

local function persistence_sort(t)
  assert(type(t) == 'table','t must be a table!')
  table.sort(t,function(a,b) return helper(a) < helper(b) or
		 a < b end)
  print(table.unpack(t))
end

persistence_sort{15,99,1,34}
persistence_sort{50,25,33,22}

