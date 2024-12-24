#! /usr/bin/lua
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


function largestnumber(a)
   local as = a
   table.sort(as,
              function(i, j)
                 return j .. i < i .. j
              end
   )
   return 0 + table.concat(as)
end

if largestnumber({20, 3}) == 320 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if largestnumber({3, 30, 34, 5, 9}) == 9534330 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

