#! /usr/bin/lua

function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

function validator(a0)
   local a = deepcopy(a0)
   table.sort(a)
   local l = #a
   if a[1] == 0 and a[l - 1] == 0 and a[l] == 1 then
      for i = 1, l do
         if a0[i] == 1 then
            return i
         end
      end
   end
   return 0
end

function specialpositions(a)
   local vr = {}
   local xs = {}
   for y, row in ipairs(a) do
      local x = validator(row)
      if x > 0 then
         table.insert(vr, {y, x})
         xs[x] = true
      end
   end
   for x, _ in pairs(xs) do
      local c = {}
      for _, row in ipairs(a) do
         table.insert(c, row[x])
      end
      if validator(c) == 0 then
         xs[x] = nil
      end
   end
   local count = 0
   for _, yx in ipairs(vr) do
      if xs[yx[1]] ~= nil then
         count = count + 1
      end
   end
   return count
end

if specialpositions({{1, 0, 0}, {0, 0, 1}, {1, 0, 0}}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialpositions({{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

