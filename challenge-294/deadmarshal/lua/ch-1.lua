#!/usr/bin/env lua

local function consecutive_sequence(t)
  assert(type(t) == 'table','t must be a table!')
  local s,res = {},0
  for i=1,#t do s[t[i]] = 1 end
  for i=1,#t do
    if not s[t[i]-1] then
      local j = t[i]
      while s[j] do j = j + 1 end
      res = math.max(res,j - t[i])
    end
  end
  return res == 1 and -1 or res
end

print(consecutive_sequence{10,4,20,1,3,2})
print(consecutive_sequence{0,6,1,8,5,2,4,3,0,7})
print(consecutive_sequence{10,30,20})

