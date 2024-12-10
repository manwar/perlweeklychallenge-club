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

function replacewords(ww, a)
   local out = {}
   for _a, w in ipairs(splits(a, " ")) do
      local r = false
      for _b, lw in ipairs(ww) do
         if string.find(w, lw) == 1 then
            table.insert(out, lw)
            r = true
            break
         end
      end
      if not r then
         table.insert(out, w)
      end
   end
   return joins(out, " ")
end

if replacewords({"cat", "bat", "rat"}, "the cattle was rattle by the battery") == "the cat was rat by the bat" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if replacewords({"a", "b", "c"}, "aab aac and cac bab") == "a a a c b" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if replacewords({"man", "bike"}, "the manager was hit by a biker") == "the man was hit by a bike" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

