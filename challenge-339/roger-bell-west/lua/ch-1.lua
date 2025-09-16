#! /usr/bin/lua

function maxdiff(a)
   local md = 0
   for w = 1, #a - 1 do
      for x = w + 1, #a do
         for y = w + 1, #a - 1 do
            if y ~= x then
               for z = y + 1, #a do
                  if z ~= x then
                     v = math.abs(a[w] * a[x] - a[y] * a[z])
                     md = math.max(md, v)
                  end
               end
            end
         end
      end
   end
   return md
end

if maxdiff({5, 9, 3, 4, 6}) == 42 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdiff({1, -2, 3, -4}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdiff({-3, -1, -2, -4}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdiff({10, 2, 0, 5, 1}) == 50 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdiff({7, 8, 9, 10, 10}) == 44 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

