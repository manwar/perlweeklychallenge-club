#! /usr/bin/lua

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

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function all(tab, func)
   for _, v in ipairs(tab) do
      if not func(v) then
         return false
      end
   end
   return true
end

function equalgroup(a)
   local s = counterify(a)
   local vv = {}
   for _, sv in pairs(s) do
      vv[sv] = true
   end
   local v = keys(vv)
   table.sort(v)
   local l = v[1]
   if l < 2 then
      return false
   end
   for t = 2, l do
      if all(v, function(c)
                  return c % t == 0
                end) then
         return true
      end
   end
   return false
end

if equalgroup({1, 1, 2, 2, 2, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not equalgroup({1, 1, 1, 2, 2, 2, 3, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if equalgroup({5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not equalgroup({1, 2, 3, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if equalgroup({8, 8, 9, 9, 10, 10, 11, 11}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

