#! /usr/bin/lua

function fibstr(aa,bb,limit)
   a=aa
   b=bb
   while true do
      c = a .. b
      print(c)
      if #c >= limit then
         return string.sub(c,limit,limit)
      end
      a=b
      b=c
   end
end

if fibstr("1234","5678",51) == "7" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
