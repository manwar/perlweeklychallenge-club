#!/usr/bin/env lua

local function string_difference(t)
  assert(type(t) == 'table','t must be a table!')
  local keys,h = {},{}
  for i,w in ipairs(t) do
    local diffs = {}
    for j = 1,#w-1 do
      diffs[#diffs+1] = w:byte(j+1) - w:byte(j)
    end
    local key = table.concat(diffs,",")
    keys[i] = key
    h[key] = (h[key] or 0) + 1
  end
  for i,w in ipairs(t) do
    if h[keys[i]] == 1 then return w end
  end
  return -1
end

print(string_difference({'ab','bc','cd','zy'}))
print(string_difference({'cba','fed','azy'}))
print(string_difference({'pop','ada','beb','cfc'}))
print(string_difference({'aaaa','zzzz','mmmm','aaba'}))
print(string_difference({'aceg','bdfh','cegi','azbz'}))

