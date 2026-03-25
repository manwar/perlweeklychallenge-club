#! /usr/bin/lua

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function countprefixes(a, b)
   return #filter(a, function(x) return string.find(b, x, 1, true) end)
end

if countprefixes({"a", "ap", "app", "apple", "banana"}, "apple") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countprefixes({"cat", "dog", "fish"}, "bird") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countprefixes({"hello", "he", "hell", "heaven", "he"}, "hello") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countprefixes({"", "code", "coding", "cod"}, "coding") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countprefixes({"p", "pr", "pro", "prog", "progr", "progra", "program"}, "program") == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

