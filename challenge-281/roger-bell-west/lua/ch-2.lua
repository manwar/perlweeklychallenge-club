#! /usr/bin/lua

function cs2xy(a)
   local x = string.byte(a, 1) - string.byte("a")
   local y = string.byte(a, 2) - string.byte("1")
   return {x, y}
end

function knightsmove(from, to)
   local fc = cs2xy(from)
   local tc = cs2xy(to)
   local queue = {}
   table.insert(queue, {fc[1], fc[2], 0})
   local seen = {}
   while #queue > 0 do
      local cc = table.remove(queue, 1)
      if (cc[1] == tc[1] and cc[2] == tc[2]) then
         return cc[3]
      else
         for _, offset in ipairs({
               {2, 1},
               {1, 2},
               {2, -1},
               {1, -2},
               {-2, 1},
               {-1, 2},
               {-2, -1},
               {-1, -2}
         }) do
            local x = cc[1] + offset[1]
            local y = cc[2] + offset[2]
            if (x >= 0 and x <= 7 and y >= 0 and y <= 7) then
               local cv = x * 8 + y
               if seen[cv] == nil then
                  table.insert(queue, {x, y, cc[3] + 1})
                  seen[cv] = true
               end
            end
         end
      end
   end
   return -1
end

if knightsmove("g2", "a8") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if knightsmove("g2", "h2") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

