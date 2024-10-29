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

function dvalue(a)
   if a[1] < a[2] then
      return a[1] * 64 + a[2]
   else
      return a[1] + a[2] * 64
   end
end

function similardominoes(a)
   local cc = {}
   for _, x in ipairs(a) do
      table.insert(cc, dvalue(x))
   end
   c = counterify(cc)
   local t = 0
   for i, v in pairs(c) do
      if v > 1 then
         t = t + v
      end
   end
   return t
end

if similardominoes({{1, 3}, {3, 1}, {2, 4}, {6, 8}}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if similardominoes({{1, 2}, {2, 1}, {1, 1}, {1, 2}, {2, 2}}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

