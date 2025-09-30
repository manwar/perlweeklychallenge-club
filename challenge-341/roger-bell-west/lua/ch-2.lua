#! /usr/bin/lua

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

function reverseprefix(a, b)
   local c = split(a)
   local p = string.find(a, b)
   if p ~= nil then
      local jr = deepcopy(c)
      for i = 1, p do
         c[p + 1 - i] = jr[i]
      end
   end
   return join(c)
end

if reverseprefix("programming", "g") == "gorpramming" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseprefix("hello", "h") == "hello" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseprefix("abcdefghij", "h") == "hgfedcbaij" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseprefix("reverse", "s") == "srevere" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseprefix("perl", "r") == "repl" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

