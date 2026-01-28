#! /usr/bin/lua

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

function strvalue(a)
   local x = tonumber(a)
   if type(x) == "nil" then
      x = #a
   end
   return x
end

function maxstrvalue(a)
   return math.max(table.unpack(map(a, strvalue)))
end

if maxstrvalue({"123", "45", "6"}) == 123 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxstrvalue({"abc", "de", "fghi"}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxstrvalue({"0012", "99", "a1b2c"}) == 99 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxstrvalue({"x", "10", "xyz", "007"}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxstrvalue({"hello123", "2026", "perl"}) == 2026 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

