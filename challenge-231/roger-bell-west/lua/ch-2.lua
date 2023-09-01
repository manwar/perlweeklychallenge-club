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

function seniorcitizens(a)
   local p = 0
   for i, n in ipairs(a) do
      local c = split(n)
      if c[12] >= "6" then
         p = p + 1
      end
   end
   return p
end

if seniorcitizens({"7868190130M7522", "5303914400F9211", "9273338290F4010"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if seniorcitizens({"1313579440F2036", "2921522980M5644"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

