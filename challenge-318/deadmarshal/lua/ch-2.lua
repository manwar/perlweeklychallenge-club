#!/usr/bin/env lua

local function reverse_equals(src,target)
  assert(type(src) == 'table' and
	 type(target) == 'table',
	 'src and target must be tables!')
  local from,to = -1,-1
  if #src ~= #target then return false end
  for i=1,#src do
    if src[i] ~= target[i] then from = i break end
  end
  if from == -1 then return true end
  for i=#src,from,-1 do
    if src[i] ~= target[i] then to = i break end
  end
  for i=1,to-from do
    if src[from+i] ~= target[to-i] then return false end
  end
  return true
end

print(reverse_equals({3,2,1,4},{1,2,3,4}))
print(reverse_equals({1,3,4},{4,1,3}))
print(reverse_equals({2},{2}))

