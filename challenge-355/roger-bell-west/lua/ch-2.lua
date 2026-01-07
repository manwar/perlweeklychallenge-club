#! /usr/bin/lua

function windows(a, size, offset)
   local out = {}
   for i = 1, #a - size + 1, offset do
      local w = {}
      for j = 0, size - 1 do
         if i + j <= #a then
            table.insert(w, a[i + j])
         end
      end
      table.insert(out, w)
   end
   return out
end

function mountainarray(a)
   local state = 0
   for _, b in ipairs(windows(a, 2, 1)) do
      if b[2] > b[1] then
         if state == 0 or state == 1 then
            state = 1
         else
            return false
         end
      elseif b[2] < b[1] then
         if state == 1 or state == 2 then
            state = 2
         else
            return false
         end
      else
         return false
      end
   end
   return state == 2
end
   
if not mountainarray({1, 2, 3, 4, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mountainarray({0, 2, 4, 6, 4, 2, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not mountainarray({5, 4, 3, 2, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not mountainarray({1, 3, 5, 5, 4, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mountainarray({1, 3, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

