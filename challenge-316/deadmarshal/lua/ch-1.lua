#!/usr/bin/env lua

local function circular(t)
  assert(type(t) == 'table','t must be a table!')
  for i=1,#t-1 do
    if t[i]:sub(#t[i],#t[i]) ~= t[i+1]:sub(1,1) then return false end
  end
  return true
end

print(circular{"perl","loves","scala"})
print(circular{"love","the","programming"})
print(circular{"java","awk","kotlin","node.js"})

