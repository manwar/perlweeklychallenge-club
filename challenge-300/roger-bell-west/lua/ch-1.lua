#! /usr/bin/lua

function beautifularrangement(a)
   local precalc = {}
   for i = 1, a do
      local row = {}
      for j = 1, a do
         table.insert(row, false)
      end
      table.insert(precalc, row)
   end
   for i = 1, a do
      for j = i, a, i do
         precalc[i][j] = true
         precalc[j][i] = true
      end
   end
   local ct = 0
   local stack = {}
   local r = {}
   for i = 1, a do
      table.insert(r, i)
   end
   table.insert(stack, r)
   while #stack > 0 do
      local trail = table.remove(stack, #stack)
      if #trail == 1 then
         ct = ct + 1
      else
         local p = a - #trail + 2
         for _, i in ipairs(trail) do
            if precalc[i][p] then
               local tt = {}
               for _, x in ipairs(trail) do
                  if x ~= i then
                     table.insert(tt, x)
                  end
               end
               table.insert(stack, tt)
            end
         end
      end
   end
   return ct
end

if beautifularrangement(2) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if beautifularrangement(1) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if beautifularrangement(10) == 700 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if beautifularrangement(20) == 1939684 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

