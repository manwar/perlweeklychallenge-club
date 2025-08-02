#! /usr/bin/lua

function splits(inputstr, sep)
   sep = sep or '%s'
   local starts = {1}
   local ends = {}
   local n = 1
   while true do
      local fs, fe = string.find(inputstr, sep, n)
      if fs == nil then
         break
      end
      table.insert(ends, fs - 1)
      table.insert(starts, fe + 1)
      n = fe + 1
   end
   table.insert(ends, #inputstr)
   local t = {}
   for i = 1, #starts do
      local s = starts[i]
      local e = ends[i]
      if e >= s then
         table.insert(t, string.sub(inputstr, s, e))
      end
   end
   return t
end

function lastword(a)
   local w = splits(a, " ")
   for i = #w, 1, -1 do
      if #(w[i]) > 0 then
         return #(w[i])
      end
   end
   return 0
end

if lastword("The Weekly Challenge") == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if lastword("   Hello   World    ") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if lastword("Let's begin the fun") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

