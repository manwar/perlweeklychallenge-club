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

function formatphonenumber(a)
   local pure = {}
   for _, c in ipairs(split(a)) do
      if c >= "0" and c <= "9" then
         table.insert(pure, c)
      end
   end
   local left = #pure
   local out = {}
   local i = 1
   if left > 4 then
      for _, c in ipairs(pure) do
         table.insert(out, c)
         i = i + 1
         left = left - 1
         if i % 3 == 1 then
            table.insert(out, "-")
            if left <= 4 then
               break
            end
         end
      end
   end
   if left == 4 then
      table.insert(out, pure[i])
      table.insert(out, pure[i + 1])
      table.insert(out, "-")
      i = i + 2
   end
   for p = i, #pure do
      table.insert(out, pure[p])
   end
   return join(out)
end

if formatphonenumber("1-23-45-6") == "123-456" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatphonenumber("1234") == "12-34" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatphonenumber("12 345-6789") == "123-456-789" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatphonenumber("123 4567") == "123-45-67" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatphonenumber("123 456-78") == "123-456-78" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

