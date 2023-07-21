#!/usr/bin/env lua

local function deduplicate_and_remove_zeros(t)
  assert(type(t) == 'table','t must be a table')
  local res,hash = {},{}
  for i=1,#t do
    if t[i] == 0 then goto continue end
    if not hash[t[i]] then res[#res+1] = t[i] end
    hash[t[i]] = true
    ::continue::
  end
  return res
end

local function zero_array(t)
  assert(type(t) == 'table','t must be a table')
  local dedup = deduplicate_and_remove_zeros(t)
  return #dedup
end

print(zero_array({1,5,0,3,5}))
print(zero_array({0}))
print(zero_array({2,1,4,0,3}))

