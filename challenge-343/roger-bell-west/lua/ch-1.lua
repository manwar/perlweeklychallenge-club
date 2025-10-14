#! /usr/bin/lua

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
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

function zerofriend(a)
   local b = math.min(table.unpack(map(a, function(x) return math.abs(x) end) ))
   if #(filter(a, function(x) return x == b end)) > 0 then
      return b
   end
   return -b
end

if zerofriend({4, 2, -1, 3, -2}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zerofriend({-5, 5, -3, 3, -1, 1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zerofriend({7, -3, 0, 2, -8}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zerofriend({-2, -5, -1, -8}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zerofriend({-2, 2, -4, 4, -1, 1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

