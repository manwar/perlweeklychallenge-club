#! /usr/bin/lua

function smallergreaterelement(a)
   local mn = math.min(table.unpack(a))
   local mx = math.max(table.unpack(a))
   local b = 0
   for i, n in ipairs(a) do
      if n ~= mn and n ~= mx then
         b = b + 1
      end
   end
   return b
end

if smallergreaterelement({2, 4}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if smallergreaterelement({1, 1, 1, 1}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if smallergreaterelement({1, 1, 4, 8, 12, 12}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if smallergreaterelement({3, 6, 6, 9}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if smallergreaterelement({0, -5, 10, -2, 4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")
