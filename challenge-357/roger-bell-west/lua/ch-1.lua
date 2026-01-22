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

function a2n(a)
   local t = 0
   for _, d in ipairs(a) do
      t = t * 10 + d
   end
   return t
end

function kaprekarconstant(a)
   local ct = 0
   local b = a
   while b ~= 6174 do
      if b == 0 then
         return -1
      end
      local digits = {}
      for _i = 0, 3 do
         table.insert(digits, b % 10)
         b = b // 10
      end
      table.sort(digits)
      local stigid = deepcopy(digits)
      table.sort(stigid, function (aa, bb) return bb < aa end)
      b = a2n(stigid) - a2n(digits)
      ct = ct + 1
   end
   return ct
end

if kaprekarconstant(3524) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if kaprekarconstant(6174) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if kaprekarconstant(9998) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if kaprekarconstant(1001) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if kaprekarconstant(9000) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if kaprekarconstant(1111) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

