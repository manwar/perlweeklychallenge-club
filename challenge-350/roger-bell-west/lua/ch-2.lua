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
  for k, _ in pairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
  end
  return true  
end

function counterify(a)
   local cc = {}
   for _, c in ipairs(a) do
      if cc[c] == nil then
         cc[c] = 0
      end
      cc[c] = cc[c] + 1
   end
   return cc
end

function countdigits(a)
   return counterify(split(tostring(a)))
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

function shufflepairs(low, high, pairs)
   local total = 0
   for candidate = low,high do
      local candidatec = countdigits(candidate)
      local cnt = 0
      for mul = 2,9 do
         local test = candidate * mul
         local testc = countdigits(test)
         if recursive_compare(testc, candidatec) then
            cnt = cnt + 1
            if cnt >= pairs then
               break
            end
         end
      end
      if cnt >= pairs then
         total = total + 1
      end
   end
   return total      
end

if shufflepairs(1, 1000, 1) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if shufflepairs(1500, 2500, 1) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if shufflepairs(1000000, 1500000, 5) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if shufflepairs(13427000, 14100000, 2) == 11 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if shufflepairs(1000, 5000, 1) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

