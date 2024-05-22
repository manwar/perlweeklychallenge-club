#! /usr/bin/lua

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

function equalizearray(a0, x, y)
   local a = deepcopy(a0)
   table.sort(a)
   local limit = a[#a]
   local queue = {}
   table.insert(queue, {a, 0})
   mc = -1
   while #queue > 0 do
      local op = table.remove(queue, 1)
      if mc == -1 or mc > op[2] then
         if op[1][1] == op[1][#op[1]] then
            mc = op[2]
         else
            local p = deepcopy(op[1])
            p[1] = p[1] + 1
            if p[1] <= limit then
               table.sort(p)
               table.insert(queue, {p, op[2] + x})
               local q = deepcopy(op[1])
               q[1] = q[1] + 1
               q[2] = q[2] + 1
               if q[2] <= limit then
                  table.sort(q)
                  table.insert(queue, {q, op[2] + y})
               end
            end
         end
      end
   end
   return mc
end

if equalizearray({4, 1}, 3, 2) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if equalizearray({2, 3, 3, 3, 5}, 2, 1) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

