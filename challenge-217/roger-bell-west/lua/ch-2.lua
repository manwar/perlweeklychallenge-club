#! /usr/bin/lua

function maxnumber(lst)
   local po = {}
   local pl = 0
   for _, v in ipairs(lst) do
      local ss = tostring(v)
      table.insert(po, ss)
      pl = math.max(pl, #ss)
   end
   local pm = {}
   for _, so in ipairs(po) do
      local sm = so
      local c = string.sub(sm, -1)
      while string.len(sm) < pl do
         sm = sm .. c
      end
      table.insert(pm, sm)
   end
   local pi = {}
   for i = 1, #pm do
      table.insert(pi, i)
   end
   table.sort(pi, function (a, b) return pm[b] < pm[a] end)
   local out = ""
   for _, st in ipairs(pi) do
      out = out .. po[st]
   end
   return tonumber(out)
end

if maxnumber({1, 23}) == 231 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxnumber({10, 3, 2}) == 3210 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxnumber({31, 2, 4, 10}) == 431210 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxnumber({5, 11, 4, 1, 2}) == 542111 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxnumber({1, 10}) == 110 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

