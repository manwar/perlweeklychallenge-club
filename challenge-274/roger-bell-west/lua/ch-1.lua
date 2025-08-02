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

function join(t)
   local out=""
   for i, v in ipairs(t) do
      out = out .. v
   end
   return out
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

function goatlatin(a)
   local out = {}
   for ix, word in ipairs(splits(a, " ")) do
      local nw = word
      local c = split(word)
      if string.match(c[1], "[^aeiouAEIOU]") then
         table.insert(c, c[1])
         table.remove(c, 1)
         nw = join(c)
      end
      nw = nw .. "ma"
      for i = 1, ix do
         nw = nw .. "a"
      end
      table.insert(out, nw)
   end
   return joins(out, " ")
end

if goatlatin("I love Perl") == "Imaa ovelmaaa erlPmaaaa" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goatlatin("Perl and Raku are friends") == "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goatlatin("The Weekly Challenge") == "heTmaa eeklyWmaaa hallengeCmaaaa" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

