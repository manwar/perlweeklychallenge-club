#! /usr/bin/lua

function splits(inputstr, sep)
   sep = sep or '%s'
   local starts = {1}
   local ends = {}
   local n = 1
   while true do
      local fs, fe = string.find(inputstr, sep, n)
      if fs == nil then
         break
      end
      table.insert(ends, fs - 1)
      table.insert(starts, fe + 1)
      n = fe + 1
   end
   table.insert(ends, #inputstr)
   local t = {}
   for i = 1, #starts do
      local s = starts[i]
      local e = ends[i]
      if e >= s then
         table.insert(t, string.sub(inputstr, s, e))
      end
   end
   return t
end

function ascendingnumbers(a)
   local prev = nil
   for _, c in ipairs(splits(a, " ")) do
      local n = tonumber(c)
      if type(n) ~= "nil" then
         if type(prev) ~= "nil" then
            if prev >= n then
               return false
            end
         end
         prev = n
      end
   end
   return true
end

if ascendingnumbers("The cat has 3 kittens 7 toys 10 beds") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not ascendingnumbers("Alice bought 5 apples 2 oranges 9 bananas") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ascendingnumbers("I ran 1 mile 2 days 3 weeks 4 months") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not ascendingnumbers("Bob has 10 cars 10 bikes") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ascendingnumbers("Zero is 0 one is 1 two is 2") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

