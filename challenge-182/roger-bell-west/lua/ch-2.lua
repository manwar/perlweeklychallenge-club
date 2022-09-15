#! /usr/bin/lua

-- bart at https://stackoverflow.com/questions/1426954/split-string-in-lua
function split(inputstr, sep)
   sep=sep or '%s'
   local t={}
   for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
      table.insert(t,field)
      if s=="" then
         return t
      end
   end
end
   

function commonpath(p)
   local pa = {}
   local pl = {}
   for i, sp in ipairs(p) do
      local q = split(sp, "/")
      table.insert(pl,#q)
      table.insert(pa,q)
   end
   local out = {}
   for cl = 1,math.min(table.unpack(pl)) do
      local ex = false
      local tx = pa[1][cl]
      for i, pe in ipairs(pa) do
         if pe[cl] ~= tx then
            ex = true
            break
         end
      end
      if ex then
         break
      end
      table.insert(out,tx)
   end
   return table.concat(out,"/")
end

if commonpath({
      "/a/b/c/1/x.pl",
      "/a/b/c/d/e/2/x.pl",
      "/a/b/c/d/3/x.pl",
      "/a/b/c/4/x.pl",
      "/a/b/c/d/5/x.pl"
             }) == "/a/b/c" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
