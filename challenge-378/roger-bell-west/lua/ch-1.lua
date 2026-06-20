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

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function secondlargestdigit(a)
   local pp = filter(split(a), function(a) return a >= "0" and a <= "9" end)
   local p = {}
   for _, v in ipairs(pp) do
      p[v] = 1
   end
   local k = {}
   for x, _ in pairs(p) do
      table.insert(k, x)
   end
   table.sort(k, function (i,j) return j < i end)
   if #k > 1 then
      return 0 + k[2]
   else
      return -1
   end
end

if secondlargestdigit("aaaaa77777") == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secondlargestdigit("abcde") == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secondlargestdigit("9zero8eight7seven9") == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secondlargestdigit("xyz9876543210") == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secondlargestdigit("4abc4def2ghi8jkl2") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

