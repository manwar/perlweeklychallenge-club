#!/usr/bin/env lua

local function count_words(t,p)
  local count = 0
  for i=1,#t do if t[i]:match("^" .. p) then count = count + 1 end end
  return count
end

print(count_words({'pay', 'attention', 'practice', 'attend'},'at'))
print(count_words({'janet', 'julia', 'java', 'javascript'},'ja'))

