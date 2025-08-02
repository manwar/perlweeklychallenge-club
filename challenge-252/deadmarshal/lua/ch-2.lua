#!usr/bin/env lua

local function unique_sum_zero(n)
  local ret = {}
  for i=1,n//2 do 
    ret[#ret+1] = i
    ret[#ret+1] = -i
  end
  if n % 2 == 1 then ret[#ret+1] = 0 end
  return ret
end

print(table.unpack(unique_sum_zero(5)))
print(table.unpack(unique_sum_zero(3)))
print(table.unpack(unique_sum_zero(1)))
