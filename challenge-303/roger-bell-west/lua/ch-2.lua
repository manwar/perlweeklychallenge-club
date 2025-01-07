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

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function deleteandearn(a)
   local ct = {}
   for _, c in ipairs(a) do
      if ct[c] == nil then
         ct[c] = 0
      end
      ct[c] = ct[c] + 1
   end
   local mx = 0
   local stack = {}
   table.insert(stack, {ct, 0})
   while #stack > 0 do
      local c = table.remove(stack, #stack)
      if propersize(c[1]) == 0 then
         mx = math.max(mx, c[2])
      else
         for d, _ in pairs(c[1]) do
            local cc = deepcopy(c[1])
            cc[d] = cc[d] - 1
            if cc[d] == 0 then
               cc[d] = nil
            end
            cc[d - 1] = nil
            cc[d + 1] = nil
            table.insert(stack, {cc, c[2] + d})
         end
      end
   end
   return mx
end

if deleteandearn({3, 4, 2}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if deleteandearn({2, 2, 3, 3, 3, 4}) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

