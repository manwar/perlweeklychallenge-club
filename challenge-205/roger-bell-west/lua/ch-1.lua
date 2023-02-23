#! /usr/bin/lua

-- by hookenz at
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
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

function thirdhighest(l)
   local m = {}
   for k, va in ipairs(l) do
      m[va] = true
   end
   local v = {}
   for k, va in pairs(m) do
      table.insert(v,k)
   end
   table.sort(v, function(a, b) return b < a end)
   if #v == 0 then
      return 0
   elseif #v <= 2 then
      return v[1]
   else
      return v[3]
   end
end

if thirdhighest({5, 3, 4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thirdhighest({5, 6}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thirdhighest({5, 4, 4, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

