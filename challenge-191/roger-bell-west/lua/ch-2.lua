#! /usr/bin/lua

function cutelist(n)
   local tab = {}
   local tmp = {}
   for x = 1,n do
      local row = {}
      for y = 1,n do
         table.insert(row, false)
      end
      table.insert(tab, row)
      table.insert(tmp, x)
   end
   for x = 1,n do
      for y = 1,x do
         if x % y ~= 0 and y % x ~= 0 then
            tab[x][y] = true
            tab[y][x] = true
         end
      end
   end
   local count = 0
   local stackl = {{}}
   local stackc = {tmp}
   while #stackl > 0 do
      local l = table.remove(stackl)
      local c = table.remove(stackc)
      if #c == 0 and #l == n then
         count = count + 1
      else
         local place = #l + 1
         for i, candidate in ipairs(c) do
            if not tab[place][candidate] then
               local ql = {}
               for j, qx in ipairs(l) do
                  table.insert(ql, qx)
               end
               table.insert(ql, candidate)
               table.insert(stackl, ql)
               local qc = {}
               for j, qx in ipairs(c) do
                  if qx ~= candidate then
                     table.insert(qc, qx)
                  end
               end
               table.insert(stackc, qc)
            end
         end
      end
   end
   return count
end

if cutelist(2) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if cutelist(10) == 700 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if cutelist(15) == 24679 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
