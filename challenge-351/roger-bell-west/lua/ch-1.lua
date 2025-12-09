#! /usr/bin/lua

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function reduce(seq, func)
   local out = seq[1]
   for i = 2, #seq do
      out = func(out, seq[i])
   end
   return out
end

function specialaverage(a0)
   local a = a0
   table.sort(a)
   local min = a[1]
   local max = a[#a]
   local b = filter(a, function(x) return x ~= min and x ~= max end)
   if #b == 0 then
      return 0
   end
   return reduce(b, function(a, b) return a + b end) / #b
end                    

if specialaverage({8000, 5000, 6000, 2000, 3000, 7000}) == 5250 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialaverage({100000, 80000, 110000, 90000}) == 95000 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialaverage({2500, 2500, 2500, 2500}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialaverage({2000}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialaverage({1000, 2000, 3000, 4000, 5000, 6000}) == 3500 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

