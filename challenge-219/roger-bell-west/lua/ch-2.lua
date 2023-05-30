#! /usr/bin/lua

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function travelexpenditure(costs, days0)
   local days = days0
   table.sort(days)
   local validities = {1, 7, 30}
   local stack = {}
   table.insert(stack, {0, days})
   local cheapest = #days * costs[1]
   while #stack > 0 do
      local c = table.remove(stack, 1)
      if #(c[2]) == 0 then
         if c[1] < cheapest then
            cheapest = c[1]
         end
      else
         if c[1] < cheapest then
            local start = c[2][1]
            for i = 1, 3 do
               local ed = start + validities[i] - 1
               local dtd = {}
               for _, j in ipairs(c[2]) do
                  if j > ed then
                     table.insert(dtd , j)
                  end
               end
               table.insert(stack, {c[1] + costs[i], dtd})
            end
         end
      end
   end
   return cheapest
end

if travelexpenditure({2, 7, 25}, {1, 5, 6, 7, 9, 15}) == 11 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if travelexpenditure({2, 7, 25}, {1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31}) == 20 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

