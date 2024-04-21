#! /usr/bin/lua

function thirtythreepercentappearance(a)
   local c = {}
   for _, n in ipairs(a) do
      if c[n] == nil then
         c[n] = 1
      else
         c[n] = c[n] + 1
      end
   end
   local threshold = math.floor(#a * 33 / 100)
   if math.floor(threshold * 100 / 33) ~= #a then
      threshold = threshold + 1
   end
   local o = {}
   for k, v in pairs(c) do
      if v >= threshold then
         table.insert(o, k)
      end
   end
   if #o == 0 then
      return -1
   end
   return math.min(table.unpack(o))
end

if thirtythreepercentappearance({1, 2, 3, 3, 3, 4, 2}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thirtythreepercentappearance({1, 1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thirtythreepercentappearance({1, 2, 3}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

