#! /usr/bin/lua

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function encode(x, y)
   return x * 1e6 + y
end

function decode(c)
   return {c // 1e6, c % 1e6}
end

function contiguousblock(a)
   local y = #a
   local x = #(a[1])
   local starts = {}
   for cx = 1, x do
      for cy = 1, y do
         starts[encode(cx, cy)] = true
      end
   end
   local maxblock = 0
   while propersize(starts) > 0 do
      local start
      for k, v in pairs(starts) do
         start = k
         break
      end
      local cstart = decode(start)
      local queue = {}
      local visited = {}
      table.insert(queue, start)
      visited[start] = true
      while #queue > 0 do
         local here = table.remove(queue, 1)
         local chere = decode(here)
         for i, delta in ipairs({
               {-1, 0},
               {1, 0},
               {0, -1},
               {0, 1}
         }) do
            if (delta[1] >= 0 or chere[1] > 1) and
               (delta[1] <= 0 or chere[1] < x) and
               (delta[2] >= 0 or chere[2] > 1) and
               (delta[2] <= 0 or chere[2] < y) then
               local cthere = {chere[1] + delta[1], chere[2] + delta[2]}
               local there = encode(cthere[1], cthere[2])
               if visited[there] == nil and
                  a[cthere[2]][cthere[1]] == a[cstart[2]][cstart[1]] then
                  visited[there] = true
                  table.insert(queue, there)
               end
            end
         end
      end
      local sz = propersize(visited)
      if sz > maxblock then
         maxblock = sz
      end
      for k, v in pairs(visited) do
         starts[k] = nil
      end
   end
   return maxblock
end

if contiguousblock({{"x", "x", "x", "x", "o"}, {"x", "o", "o", "o", "o"}, {"x", "o", "o", "o", "o"}, {"x", "x", "x", "o", "o"}}) == 11 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if contiguousblock({{"x", "x", "x", "x", "x"}, {"x", "o", "o", "o", "o"}, {"x", "x", "x", "x", "o"}, {"x", "o", "o", "o", "o"}}) == 11 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if contiguousblock({{"x", "x", "x", "o", "o"}, {"o", "o", "o", "x", "x"}, {"o", "x", "x", "o", "o"}, {"o", "o", "o", "x", "x"}}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

