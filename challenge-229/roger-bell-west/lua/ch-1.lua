#! /usr/bin/lua

function tochars(str)
   local t={}
   for ch in string.gmatch(str, ".") do
      table.insert(t,ch)
   end
   return t
end

function tostr(tab)
   local s = ""
   for i, ch in ipairs(tab) do
      s = s .. ch
   end
   return s
end

function lexicographic(a)
   local t = 0
   for i, st in ipairs(a) do
      local q = tochars(st)
      table.sort(q)
      if tostr(q) ~= st then
         if tostr(q) ~= string.reverse(st) then
            t = t + 1
         end
      end
   end
   return t
end

if lexicographic({"abc", "bce", "cae"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if lexicographic({"yxz", "cba", "mon"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

