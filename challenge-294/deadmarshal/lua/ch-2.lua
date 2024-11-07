#!/usr/bin/env lua

local function reverse(t)
  assert(type(t) == 'table','t must be a table!')
  for i=1,#t//2 do
    t[i],t[#t-i+1] = t[#t-i+1],t[i]
  end
  return t
end

local function next_permutation(t)
  assert(type(t) == 'table','t must be a table!')
  local p = -1
  for i=#t-1,1,-1 do
    if t[i] < t[i+1] then p = i break end
  end
  if p == -1 then return reverse(t) end
  for i=#t,p+1,-1 do
    if t[i] > t[p] then
      t[i],t[p] = t[p],t[i]
      break
    end
  end
  return t
end

print(table.unpack(next_permutation{1,2,3}))
print(table.unpack(next_permutation{2,1,3}))
print(table.unpack(next_permutation{3,1,2}))

