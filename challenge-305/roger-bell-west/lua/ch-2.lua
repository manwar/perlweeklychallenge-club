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

function aliendictionary(a, dc)
   local mxl = 0
   for _, w in ipairs(a) do
      mxl = math.max(mxl, #w)
   end
   local dh = {}
   for i, c in ipairs(dc) do
      dh[c] = i
   end
   local b = a
   local numerics = {}
   for _, w in ipairs(a) do
      local n = 0
      local cc = split(w)
      for i = 1, mxl do
         n = n * 27
         if i <= #w then
            n = n + dh[cc[i]]
         end
      end
      numerics[w] = n
   end
   table.sort(b,
              function(i, j)
                 return numerics[i] < numerics[j]
              end
   )
   return b
end

if recursive_compare(aliendictionary({"perl", "python", "raku"}, {"h", "l", "a", "b", "y", "d", "e", "f", "g", "i", "r", "k", "m", "n", "o", "p", "q", "j", "s", "t", "u", "v", "w", "x", "c", "z"}), {"raku", "python", "perl"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(aliendictionary({"the", "weekly", "challenge"}, {"c", "o", "r", "l", "d", "a", "b", "t", "e", "f", "g", "h", "i", "j", "k", "m", "n", "p", "q", "s", "w", "u", "v", "x", "y", "z"}), {"challenge", "the", "weekly"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

