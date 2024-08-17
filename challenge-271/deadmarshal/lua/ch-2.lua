#!/usr/bin/env lua

local function decimal_to_binary(n)
  assert(type(n) == 'number','n must be a number!')
  local bin = ""
  while n > 0 do
    bin = (n % 2) .. bin
    n = n // 2
  end
  return bin
end

local function pop_count(n)
  assert(type(n) == 'number','n must be a number!')
  local bin, count = decimal_to_binary(n),0
  for pos=1,#bin do
    if bin:sub(pos,pos) == "1" then count = count + 1 end
  end
  return count
end

local function sort_by_one_bits(t)
  assert(type(t) == 'table','t must be a table!')
  table.sort(t,function(a,b)
	       local pa,pb = pop_count(a),pop_count(b)
	       return pa == pb and a < b or pa < pb end)
  return t
end

print(table.unpack(sort_by_one_bits{0,1,2,3,4,5,6,7,8}))
print(table.unpack(sort_by_one_bits{1024,512,256,128,64}))

