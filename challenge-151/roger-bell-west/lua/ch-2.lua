#! /usr/bin/lua

function plan(houses)
   local terminal=#houses-1
   local b={{1}}
   local reward=0
   while #b > 0 do
      local c=b[#b]
      b[#b]=nil
      if c[#c] >= terminal then
         local r=0
         for k,v in pairs(c) do
            r = r + houses[v]
         end
         if r > reward then
            reward=r
         end
      else
         for n = c[#c]+2,c[#c]+3 do
            if n > #houses then
               break
            end
            local j={}
            for i,v in ipairs(c) do
               table.insert(j,v)
            end
            table.insert(j,n)
            table.insert(b,j)
         end
      end
   end
   return reward
end

if plan({2, 4, 5}) == 7 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if plan({4, 2, 3, 6, 5, 3}) == 13 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
