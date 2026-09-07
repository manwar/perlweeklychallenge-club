#! /usr/bin/lua

function zigzagsubarray(a)
   local mx = math.min(#a, 1)
   for i = 1, #a do
      local o = 0
      local lastdir = 0
      for j = i, #a do
         local thisdir = 0
         if j > i then
            if a[j] > o then
               thisdir = 1
               mx = math.max(mx, 2)
            elseif a[j] < o then
               thisdir = -1
               mx = math.max(mx, 2)
            end
         end
         if (j > i and thisdir == 0) or (j > i + 1 and thisdir * lastdir ~= -1) then
            break
         end
         o = a[j]
         lastdir = thisdir
         mx = math.max(mx, j - i + 1)
      end
   end
   return mx
end

if zigzagsubarray({9, 4, 2, 10, 7, 8, 8, 1, 9}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zigzagsubarray({1, 7, 4, 9, 2, 5}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zigzagsubarray({1, 2, 3, 4, 5}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zigzagsubarray({4, 4, 4}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zigzagsubarray({10, 20, 15, 12, 18}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

