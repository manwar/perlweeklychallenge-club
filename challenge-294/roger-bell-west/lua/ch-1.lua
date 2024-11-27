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

function consecutivesequence(a)
   local b = deepcopy(a)
   table.sort(b)
   local mxlen = 0
   local here = 1
   while true do
      for there = here + 1, #b do
         if b[there] ~= there - here + b[here] then
            local l = there - here
            if l > mxlen then
               mxlen = l
            end
            here = there
            break
         end
         if there == #b then
            local l = there - here + 1
            if l > mxlen then
               mxlen = l
            end
            here = there
            break
         end
      end
      if here >= #b then
         break
      end
   end
   if mxlen < 2 then
      mxlen = -1
   end
   return mxlen
end

if consecutivesequence({10, 4, 20, 1, 3, 2}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if consecutivesequence({0, 6, 1, 8, 5, 2, 4, 3, 0, 7}) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if consecutivesequence({10, 30, 20}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

