#! /usr/bin/lua

function alphanumericstringvalue(a)
   local l = {}
   for _i, n in ipairs(a) do
      local p = tonumber(n)
      if p == nil then
         p = #n
      end
      table.insert(l, p)
   end
   return math.max(table.unpack(l))
end

if alphanumericstringvalue({"perl", "2", "000", "python", "raku"}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alphanumericstringvalue({"001", "1", "000", "0001"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

