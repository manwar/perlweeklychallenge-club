#! /usr/bin/lua

function isqrt(s)
   if s <= 1 then
      return s
   end
   local x0 = s // 2
   local x1 = (x0 + s // x0) // 2
   while x1 < x0 do
      x0 = x1
      x1 = (x0 + s // x0) // 2
   end
   return x0
end

function genprimes(mx)
   local primesh = {}
   for i = 2, 3 do
      primesh[i] = true
   end
   for i = 6, mx, 6 do
      for j = i-1, i+1, 2 do
         if j <= mx then
            primesh[j]=true
         end
      end
   end
   local q={2,3,5,7}
   local p=table.remove(q,1)
   local mr=isqrt(mx)
   while p <= mr do
      if primesh[p] ~= nil then
         for i = p*p,mx,p do
            primesh[i] = nil
         end
      end
      if #q < 2 then
         table.insert(q,q[#q]+4)
         table.insert(q,q[#q]+2)
      end
      p=table.remove(q,1)
   end
   local primes = {}
   for k,v in pairs(primesh) do
      table.insert(primes,k)
   end
   table.sort(primes)
   return primes
end

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function primestep(a)
   local g = 0
   for i = 1, #a do
      g = g + string.byte(a, i)
   end
   local pm = genprimes(g * 2)
   local lol = filter(pm, function(x) return x <= g end)
   local lo = lol[#lol]
   local hi = filter(pm, function(x) return x > g end)[1]
   return math.min(g - lo, hi - g)
end

if primestep("hello") == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if primestep("football") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if primestep("a") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if primestep("challenge") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if primestep("perl") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

