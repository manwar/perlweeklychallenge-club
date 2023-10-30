#! /usr/bin/lua

function arrayloops(a)
   local loop_id = 0
   local loops = {}
   for _i, origin in ipairs(a) do
      if loops[origin] == nil then
         local li = 0
         local thisloop = {}
         local x = origin
         while true do
            if x < 0 or x >= #a then
               break
            end
            thisloop[x] = true
            x = a[x + 1]
            if loops[x] ~= nil then
               li = loops[x]
               break
            end
            if thisloop[x] ~= nil then
               loop_id = loop_id + 1
               li = loop_id
               break
            end
         end
         for i, _t in pairs(thisloop) do
            loops[i] = li
         end
      end
   end
   return loop_id
end

if arrayloops({4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arrayloops({0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arrayloops({9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

