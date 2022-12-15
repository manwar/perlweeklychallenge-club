#!/usr/bin/env lua

local function has_dups(n)
  assert(type(n) == 'number','n must be a number!')
  if n > 9999999999 then return true end
  local hash = {}
  while n ~= 0 do
    if(hash[n%10] ~= nil) then return true end
    hash[n%10] = 1
    n = n // 10
  end
  return false
end

local function special_integers(n)
  assert(type(n) == 'number','n must be a number!')
  local count = 0
  for i=1, n do
    if not has_dups(i) then count = count + 1 end
  end
  return count
end

print(special_integers(15))
print(special_integers(35))

