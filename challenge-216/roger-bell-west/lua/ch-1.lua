#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
-- modified by Roger
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end
  -- Build list of all keys
  local kk = {}
  for k1, _ in pairs(t1) do
     kk[k1] = true
  end
  for k2, _ in pairs(t2) do
     kk[k2] = true
  end
  -- Check each key that exists in at least one table
  for _, k in ipairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
  end
  return true
end

function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function word2set(word)
   local s = {}
   for c in string.gmatch(string.lower(word), "%a") do
      s[c] = true
   end
   return s
end

function registrationnumber(words, reg)
   local s = word2set(reg)
   local out = {}
   for _, w in ipairs(words) do
      local ss = deepcopy(s)
      for c, _ in pairs(word2set(w)) do
         if s[c] ~= nil then
            s[c] = nil
            if propersize(s) == 0 then
               table.insert(out, w)
               break
            end
         end
      end
   end
   return out
end

if recursive_compare(registrationnumber({"abc", "abcd", "bcd"}, "AB1 2CD"), {"abcd"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(registrationnumber({"job", "james", "bjorg"}, "007 JB"), {"job", "bjorg"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(registrationnumber({"crack", "road", "rac"}, "C7 RA2"), {"crack", "rac"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

