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

function longestparenthesis(aa)
   local a = split(aa)
   local ml = 0
   for l = 1, #a do
      for r = l, #a do
         local depth = 0
         local valid = true
         for i = l, r do
            if a[i] == "(" then
               depth = depth + 1
            else
               depth = depth - 1
               if depth < 0 then
                  valid = false
                  break
               end
            end
         end
         if depth ~= 0 then
            valid = false
         end
         if valid then
            ml = math.max(ml, r - l + 1)
         end
      end
   end
   return ml
end

if longestparenthesis("(()())") == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestparenthesis(")()())") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestparenthesis("((()))()(((()") == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestparenthesis("))))((()(") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestparenthesis("()(()") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

