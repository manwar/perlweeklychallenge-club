#! /usr/bin/lua

function trionicarray(a)
   local state = 0
   local prev = a[1]
   for i = 2,#a do
      local n = a[i]
      local dir = 0
      if n > prev then
         dir = 1
      elseif n < prev then
         dir = -1
      end
      if dir == 0 then
         return false
      end
      if state == 0 then
         if dir == 1 then
            state = 1
         else
            return false
         end
      elseif state == 1 then
         if dir == -1 then
            state = 2
         end
         elseif state == 2 then
         if dir == 1 then
            state = 3
         end
      elseif state == 3 then
         if dir == -1 then
            return false
         end
      else
         return false
      end
      prev = n
   end
   return state == 3
end

if trionicarray({1, 3, 5, 4, 2, 6, 8}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not trionicarray({1, 4, 4, 2, 1, 3, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if trionicarray({2, 10, 3, 1, 9}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not trionicarray({1, 2, 3, 4, 3, 2, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not trionicarray({1, 3, 2, 4, 1, 5, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

