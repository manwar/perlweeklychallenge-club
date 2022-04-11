#! /usr/bin/lua

function fim(n0)
   words={"zero","one","two","three","four",
          "five","six","seven","eight","nine"}
   local n=n0
   local p={}
   while true do
      local s=words[n+1] .. " is "
      if n==4 then
         s = s .. "magic."
         table.insert(p,s)
         break
      else
         n = #(words[n+1])
         s = s .. words[n+1]
         table.insert(p,s)
      end
   end
   return string.gsub(table.concat(p,", "),"^(%a)",string.upper)
end

if fim(5) == "Five is four, four is magic." then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if fim(7) == "Seven is five, five is four, four is magic." then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if fim(6) == "Six is three, three is five, five is four, four is magic." then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if fim(4) == "Four is magic." then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
