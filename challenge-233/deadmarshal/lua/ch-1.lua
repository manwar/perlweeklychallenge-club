#!/usr/bin/env lua

local function values(t)
  local vals = {}
  for _,v in pairs(t) do vals[#vals+1] = v end
  return vals
end

local function deduplicate(t)
  local res,hash = {},{}
  for i=1,#t do
    if not hash[t[i]] then res[#res+1] = t[i] end
    hash[t[i]] = true
  end
  return res
end

local function similar_words(t)
  local count,h = 0,{}
  for i=1,#t do
    local chars = {}
    for c in t[i]:gmatch("(.)") do chars[#chars+1] = c end
    chars = deduplicate(chars)
    table.sort(chars)
    local s = table.concat(chars)
    h[s] = (h[s] or 0) + 1
  end
  for k,v in pairs(h) do count = count + (v * (v-1)) // 2 end
  return count
end

print(similar_words{"aba","aabb","abcd","bac","aabc"})
print(similar_words{"aabb","ab","ba"})
print(similar_words{"nba","cba","dba"})

