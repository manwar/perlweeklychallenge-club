#! /usr/bin/lua

function equaldistribution(list)
   local s = 0
   for i,v in ipairs(list) do
      s = s + v
   end
   if s % #list ~= 0 then
      return -1
   end
   local m = s / #list
   local out = 0
   local w = list
   while true do
      for i = 1,#w-1 do
         if w[i] > m then
            v = w[i] - m
            w[i+1] = w[i+1] + v
            out = out + v
            w[i] = m
         elseif w[i] < m then
            v = math.min(m - w[i], w[i+1])
            w[i+1] = w[i+1] - v
            out = out + v
            w[i] = w[i] + v
         end
      end
      local done = true
      for i,v in ipairs(w) do
         if v ~= m then
            done = false
            break
         end
      end
      if done then
         break
      end
   end
   return out
end

if equaldistribution({1, 0, 5}) == 4 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if equaldistribution({0, 2, 0}) == -1 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if equaldistribution({0, 3, 0}) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
