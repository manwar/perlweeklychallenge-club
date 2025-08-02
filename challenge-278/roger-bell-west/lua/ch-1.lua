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

function joins(t,pad)
   local out=""
   local later = false
   for k,v in pairs(t) do
      if later then
         out = out .. pad
      end
      out = out .. v
      later = true
   end
   return out
end

function sortstring(a)
   local words =splits(a, " ")
   local out = {}
   for _a, _b in ipairs(words) do
      table.insert(out, "")
   end
   for _, w in ipairs(words) do
      local _a, _b, aa, ab = string.find(w, "^(.-)(%d+)$")
      out[0 + ab] = aa
   end
   return joins(out, " ")
end

if sortstring("and2 Raku3 cousins5 Perl1 are4") == "Perl and Raku are cousins" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortstring("guest6 Python1 most4 the3 popular5 is2 language7") == "Python is the most popular guest language" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortstring("Challenge3 The1 Weekly2") == "The Weekly Challenge" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

