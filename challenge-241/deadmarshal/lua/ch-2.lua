#!/usr/bin/env lua

local function count_factors(n)
  local c,count = 2,0
  while n > 1 do
    if n % c == 0 then n = n // c count = count + 1 else c = c + 1 end
  end
  return count
end

local function prime_order(t)
  assert(type(t) == 'table','t must be a table!')
  table.sort(t,function(a,b)
	       local fa,fb = count_factors(a),count_factors(b)
	       return fa == fb and a < b or fa < fb
  end)
  return table.concat(t,',')
end

print(prime_order{11,8,27,4})

