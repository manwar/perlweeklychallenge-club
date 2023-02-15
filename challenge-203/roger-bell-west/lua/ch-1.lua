#! /usr/bin/lua

function specialquads(l)
   local ct = 0
   for ai = 1,#l - 3 do
      for bi = ai + 1,#l - 2 do
         for ci = bi + 1,#l - 1 do
            for di = ci + 1,#l do
               if l[ai] + l[bi] + l[ci] == l[di] then
                  ct = ct + 1
               end
            end
         end
      end
   end
   return ct
end

if specialquads({1, 2, 3, 6}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialquads({1, 1, 1, 3, 5}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialquads({3, 3, 6, 4, 5}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

