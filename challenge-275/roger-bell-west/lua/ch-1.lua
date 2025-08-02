#! /usr/bin/lua

-- bart at https://stackoverflow.com/questions/1426954/split-string-in-lua
function splits(inputstr, sep)
   sep=sep or '%s'
   local t={}
   for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
      table.insert(t,field)
      if s=="" then
         return t
      end
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

function brokenkeys(a, k)
   local out = 0
   local failset = {}
   for _, c in ipairs(k) do
      failset[string.lower(c)] = true
   end
   for _, word in ipairs(splits(string.lower(a), " ")) do
      local wordset = {}
      for _b, c in ipairs(split(word)) do
         wordset[c] = true
      end
      local intersect = {}
      for k, v in pairs(failset) do
         if wordset[k] ~= nil then
            table.insert(intersect, k)
         end
      end
      if #intersect == 0 then
         out = out + 1
      end
   end
   return out
end

if brokenkeys("Perl Weekly Challenge", {"l", "a"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeys("Perl and Raku", {"a"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeys("Well done Team PWC", {"l", "o"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

