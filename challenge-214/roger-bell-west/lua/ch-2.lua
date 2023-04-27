#! /usr/bin/lua

-- from Roger's lualib
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

function collectpoints(a)
   local m = {}
   local s = 1
   while s <= #a do
      local k = a[s]
      local e = s
      while e <= #a and a[e] == k do
         e = e + 1
      end
      table.insert(m, {k, e - s})
      s = e
   end
   local rv = 0
   local stack = { { m, 0 } }
   while #stack > 0 do
      local s = table.remove(stack)
      if #(s[1]) == 0 then
         if rv < s[2] then
            rv = s[2]
         end
      else
         for i = 1, #(s[1]) do
            local ss = deepcopy(s)
            ss[2] = ss[2] + ss[1][i][2] * ss[1][i][2]
            table.remove(ss[1], i)
            j = i
            while true do
               if j > 1 and
                  j <= #(ss[1]) and
                  ss[1][j][1] == ss[1][j - 1][1] then
                  ss[1][j][2] = ss[1][j][2] + ss[1][j - 1][2]
                  table.remove(ss[1], j - 1)
                  j = j - 1
               else
                  break
               end
            end
            table.insert(stack, ss)
         end
      end
   end
   return rv
end

if collectpoints({2, 4, 3, 3, 3, 4, 5, 4, 2}) == 23 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if collectpoints({1, 2, 2, 2, 2, 1}) == 20 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if collectpoints({1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if collectpoints({2, 2, 2, 1, 1, 2, 2, 2}) == 40 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

