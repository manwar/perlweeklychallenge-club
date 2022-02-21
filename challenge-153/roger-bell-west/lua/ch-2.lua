#! /usr/bin/lua

function factorion(input)
   if input == 0 then
      return false
   end
   fd={1}
   ff=1
   for i = 1, 9 do
      ff = ff * i
      table.insert(fd,ff)
   end
   working = input
   dsum = 0
   while working > 0 do
      dsum = dsum + fd[(working % 10) + 1]
      working = math.floor(working/10)
   end
   return input == dsum
end

if factorion(145) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not factorion(125) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
