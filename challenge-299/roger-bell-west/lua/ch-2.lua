#! /usr/bin/lua
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function encode(x, y)
   return x * 64 + y
end

function decode(z)
   return { z // 64, z % 64 }
end

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

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

function wordsearch(grid0, word0)
   local grid = {}
   for y, row in ipairs(grid0) do
      for x, c in ipairs(row) do
         grid[encode(x, y)] = c
      end
   end
   local word = split(word0)
   for start, firstletter in pairs(grid) do
      if firstletter == word[1] then
         local queue = {{start}}
         while #queue > 0 do
            local pos = table.remove(queue, 1)
            if #pos == #word then
               return true
            else
               for _, dir in ipairs({{0, 1}, {1, 0}, {0, -1}, {-1, 0}}) do
                  local lpos = decode(pos[#pos])
                  local npos = { lpos[1] + dir[1], lpos[2] + dir[2] }
                  local np = encode(npos[1], npos[2])
                  local posmap = {}
                  for __, x in ipairs(pos) do
                     posmap[x] = true
                  end
                  if grid[np] ~= nil and
                     posmap[np] == nil and
                     grid[np] == word[#pos + 1] then
                     local pp = deepcopy(pos)
                     table.insert(pp, np)
                     table.insert(queue, pp)
                  end
               end
            end
         end
      end
   end
   return false
end

if wordsearch({{"A", "B", "D", "E"}, {"C", "B", "C", "A"}, {"B", "A", "A", "D"}, {"D", "B", "B", "C"}}, "BDCA") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not wordsearch({{"A", "A", "B", "B"}, {"C", "C", "B", "A"}, {"C", "A", "A", "A"}, {"B", "B", "B", "B"}}, "ABAC") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordsearch({{"B", "A", "B", "A"}, {"C", "C", "C", "C"}, {"A", "B", "A", "B"}, {"B", "B", "A", "A"}}, "CCCAA") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

