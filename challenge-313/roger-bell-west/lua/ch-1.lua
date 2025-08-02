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

function brokenkeys(name, typed)
   local nt = split(name)
   local tt = split(typed)
   local ni = 1
   local ti = 1
   while true do
      if nt[ni] ~= tt[ti] then
         return false
      end
      if ti == #tt then
         break
      end
      if ni < #nt and nt[ni + 1] == nt[ni] then
         ni = ni + 1
      else
         while ti <= #tt and tt[ti] == nt[ni] do
            ti = ti + 1
         end
         if ti >= #tt then
            break
         end
         ni = ni + 1
      end
   end
   return true
end

if brokenkeys("perl", "perrrl") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeys("raku", "rrakuuuu") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not brokenkeys("python", "perl") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeys("coffeescript", "cofffeescccript") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

