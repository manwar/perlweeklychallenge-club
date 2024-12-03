#! /usr/bin/lua

function maximalsquare(a)
   local mx = 0
   local boundy = #a
   local boundx = #(a[1])
   for y = 1, boundy do
      for x = 1, boundx do
         local size = 0
         while true do
            local tests = {}
            for xx = x, x + size do
               table.insert(tests, {y + size, xx})
            end
            if size > 0 then
               for yy = y, y + size - 1 do
                  table.insert(tests, {yy, x  + size})
               end
            end
            local tt = false
            for _, c in ipairs(tests) do
               if a[c[1]][c[2]] == 0 then
                  tt = true
               end
            end
            if tt then
               break
            end
            size = size + 1
            if x + size > boundx or y + size > boundy then
               break
            end
         end
         mx = math.max(mx, size * size)
      end
   end
   return mx
end

if maximalsquare({{1, 0, 1, 0, 0}, {1, 0, 1, 1, 1}, {1, 1, 1, 1, 1}, {1, 0, 0, 1, 0}}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximalsquare({{0, 1}, {1, 0}}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximalsquare({{0}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

