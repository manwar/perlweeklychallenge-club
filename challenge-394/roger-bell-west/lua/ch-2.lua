#! /usr/bin/lua

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
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

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function common_substring(a0)
   local a = deepcopy(a0)
   table.sort(a, function (i, j) return #i < #j end)
   local results = {}
   for l = #a[1], 1, -1 do
      for offset = 1, #a[1] - l - 1 do
         local m = true
         local sample = string.sub(a[1], offset, offset + l - 1)
         for axi = 2, #a do
            if string.find(a[axi], sample, 1, true) == nil then
               m = false
               break
            end
         end
         if m then
            table.insert(results, sample)
         end
      end
      -- for _longest_, break on non-empty return
   end
   return results
end

function is_avc(a)
   local valid = true
   local laststate = false
   for i, c in ipairs(split(a)) do
      local thisstate = false
      if c == "a" or c == "e" or c == "i" or c == "o" or c == "u" then
         thisstate = true
      end
      if i > 1 and thisstate == laststate then
         valid = false
         break
      end
      laststate = thisstate
   end
   return valid
end

function alternatingvowelsconsonants(a)
   local c2 = filter(common_substring(a),
                     function(w)
                        return is_avc(w)
                     end
   )
   if #c2 > 0 then
      local l = #c2[1]
      return filter(c2,
                        function(w)
                           return #w == l
                        end
      )
   else
      return {}
   end
end

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

if recursive_compare(alternatingvowelsconsonants({"relocate", "delocate", "allocate"}), {"locate"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(alternatingvowelsconsonants({"apple", "banana", "cherry"}), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(alternatingvowelsconsonants({"navigate", "cavity", "gravity"}), {"avi"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(alternatingvowelsconsonants({"pedalgia", "pedalboard", "pedantic"}), {"peda"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(alternatingvowelsconsonants({"schoolmaster", "schoolhouse", "schooling"}), {"ho", "ol"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

