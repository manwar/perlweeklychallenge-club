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

function twicelargest(a)
   local p = deepcopy(a)
   table.sort(p, function (i, j) return j < i end)
   if p[1] >= 2 * p[2] then
      for i, c in ipairs(a) do
         if c == p[1] then
            return i - 1
         end
      end
   end
   return -1
end

if twicelargest({2, 4, 1, 0}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if twicelargest({1, 2, 3, 4}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

